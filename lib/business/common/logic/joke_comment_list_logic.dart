import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joke_fun_flutter/business/common/event/joke_comment_num_event.dart';
import 'package:joke_fun_flutter/common/ext/get_ext.dart';
import 'package:joke_fun_flutter/common/util/event_bus_manager.dart';
import 'package:joke_fun_flutter/common/util/keyboard_util.dart';
import 'package:joke_fun_flutter/common/util/user_manager.dart';
import 'package:joke_fun_flutter/common/view_state/simple_view_state_paging_logic.dart';
import 'package:joke_fun_flutter/common/view_state/view_state.dart';
import 'package:joke_fun_flutter/http/retrofit_client.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/joke_comment_entity.dart';
import 'package:joke_fun_flutter/router/routers.dart';

/// 段子评论列表通用logic
class JokeCommentListLogic extends SimpleViewStatePagingLogic {
  int jokesId = 0;
  TextEditingController textEditingController = TextEditingController();
  RxBool isInputValid = false.obs;
  RxString commentInput = "".obs;
  RxInt totalNum = 0.obs;
  int? replyCommentId;
  bool isReplyChild = false;

  final Map<int, int> _subCommentsExpandPageMap = {};

  @override
  void onReady() {
    super.onReady();
    loadData();
  }

  @override
  Future<BaseResult<JokeCommentEntity>> requestFuture(String pageNum) {
    return RetrofitClient.instance.apiService
        .getJokeCommentList(jokesId.toString(), pageNum);
  }

  @override
  bool judgeEmpty(BaseResult result) {
    return (result.data as JokeCommentEntity).comments?.isEmpty ?? true;
  }

  @override
  bool judgeNoMoreData(BaseResult result) {
    return ((result.data as JokeCommentEntity).comments?.length ?? 0) <
        pageSize;
  }

  @override
  List convertResult(dynamic originResult) {
    return (originResult as JokeCommentEntity).comments!;
  }

  void updateCommentInput(String value) {
    isInputValid.value = value.isNotEmpty;
    commentInput.value = value;
    if (isInputValid.value == false) {
      replyCommentId = null;
      isReplyChild = false;
    }
    textEditingController.value = TextEditingValue(
        text: value,
        selection: TextSelection.fromPosition(TextPosition(
            affinity: TextAffinity.downstream, offset: value.length)));
  }

  /// 发表评论
  void postComment() {
    Get.hideBottomSheet();
    hideKeyboard();
    if(!UserManager.instance.isLogin()) {
      Get.toNamed(AppRoutes.verifyCodeLoginPage);
      return;
    }
    if (isInputValid.value) {
      sendRequest(
          RetrofitClient.instance.apiService
              .postJokeComment(jokesId.toString(), commentInput.value),
          bindViewState: false,
          showLoadingDialog: true, successCallback: (value) {
        updateCommentInput("");
        if (dataList.isEmpty) {
          viewState.value = ViewStateSuccess(dataList);
        }
        dataList.insert(0, value);
        dataList.refresh();
        totalNum.value = totalNum.value + 1;
        eventBus.fire(JokeCommentNumEvent(totalNum.value, jokesId));
      });
    }
  }

  /// 发表子评论
  void postSubComment() {
    Get.hideBottomSheet();
    hideKeyboard();
    if(!UserManager.instance.isLogin()) {
      Get.toNamed(AppRoutes.verifyCodeLoginPage);
      return;
    }
    if (isInputValid.value) {
      sendRequest(
          RetrofitClient.instance.apiService.postJokeSubComment(
              replyCommentId.toString(), commentInput.value, "$isReplyChild"),
          bindViewState: false,
          showLoadingDialog: true, successCallback: (value) {
        JokeComment comment;
        if (!isReplyChild) {
          comment = dataList
              .firstWhere((element) => element.commentId == replyCommentId);
        } else {
          comment = dataList.firstWhere((element) =>
              element.itemCommentList
                  ?.any((item) => item.commentItemId == replyCommentId) ??
              false);
        }
        updateCommentInput("");
        comment.itemCommentNum = (comment.itemCommentNum ?? 0) + 1;
        if (comment.itemCommentList == null) {
          comment.itemCommentList = [value!];
        } else {
          comment.itemCommentList!.insert(0, value!);
        }
        comment.status =
            comment.itemCommentNum! > comment.itemCommentList!.length ? 2 : 3;
        dataList.refresh();

        totalNum.value = totalNum.value + 1;
        eventBus.fire(JokeCommentNumEvent(totalNum.value, jokesId));
      });
    }
  }

  /// 点赞评论
  void likeComment(JokeComment item) {
    bool isLike = item.isLike ?? false;
    sendRequest(
        RetrofitClient.instance.apiService
            .likeJokeComment(item.commentId.toString(), "${!isLike}"),
        bindViewState: false,
        emptyAsSuccess: true,
        showLoadingDialog: true, successCallback: (value) {
      item.isLike = !isLike;
      if (!isLike) {
        // 点赞操作
        item.likeNum = (item.likeNum ?? 0) + 1;
      } else {
        item.likeNum = min((item.likeNum ?? 0) - 1, 0);
      }
      dataList.refresh();
    });
  }

  /// 展开子评论
  void expandSubComments(JokeComment comment) {
    int status = comment.status ?? 0;
    int itemCommentListLength = comment.itemCommentList?.length ?? 0;
    int itemCommentNum = comment.itemCommentNum ?? 0;
    int commentId = comment.commentId ?? 0;
    if (status != 3) {
      /// 展开
      if (itemCommentListLength >= itemCommentNum) {
        /// 子评论已经完全加载完，可以一次性展开
        comment.status = 3;
        dataList.refresh();
      } else {
        /// 分页加载子数据
        comment.status = 1;
        dataList.refresh();
        int pageNum = _subCommentsExpandPageMap[commentId] ?? 0;
        sendRequest(
            RetrofitClient.instance.apiService
                .getJokeSubCommentList(commentId.toString(), "${pageNum + 1}"),
            bindViewState: false, successCallback: (value) {
          List<JokeSubComment> newList = [];
          if (comment.itemCommentList != null &&
              comment.itemCommentList!.isNotEmpty) {
            newList.addAll(comment.itemCommentList!);
            for (JokeSubComment newItem in value!) {
              bool allowAdd = true;
              for (JokeSubComment existItem in comment.itemCommentList!) {
                if (newItem.commentItemId == existItem.commentItemId) {
                  allowAdd = false;
                  break;
                }
              }
              if (allowAdd) {
                newList.add(newItem);
              }
            }
          } else {
            newList.addAll(value!);
          }
          comment.itemCommentList = newList;
          _subCommentsExpandPageMap[commentId] = pageNum + 1;
          comment.status =
              (comment.itemCommentList?.length ?? 0) >= itemCommentNum ? 3 : 2;
          dataList.refresh();
        }, failCallback: () {
          comment.status = 2;
          dataList.refresh();
        }, emptyCallback: () {
          comment.status = 2;
          dataList.refresh();
        });
      }
    } else {
      /// 收起
      comment.status = 0;
      dataList.refresh();
    }
  }

  /// 删除主评论
  void deleteComment(JokeComment comment) {
    sendRequest(
        RetrofitClient.instance.apiService
            .deleteJokeComment(comment.commentId.toString()),
        emptyAsSuccess: true,
        showLoadingDialog: true,
        bindViewState: false, successCallback: (value) {
      dataList.remove(comment);
      totalNum.value = totalNum.value - 1 - (comment.itemCommentNum ?? 0);
      eventBus.fire(JokeCommentNumEvent(totalNum.value, jokesId));
      dataList.refresh();
    });
  }

  /// 删除子评论
  void deleteSubComment(JokeComment comment, JokeSubComment subComment) {
    sendRequest(
        RetrofitClient.instance.apiService
            .deleteJokeSubComment(subComment.commentItemId.toString()),
        emptyAsSuccess: true,
        showLoadingDialog: true,
        bindViewState: false, successCallback: (value) {
      comment.itemCommentList?.remove(subComment);
      comment.itemCommentNum = (comment.itemCommentNum ?? 0) - 1;
      _subCommentsExpandPageMap[comment.commentId!] = min(
          (comment.itemCommentNum ?? 0) ~/ 10,
          _subCommentsExpandPageMap[comment.commentId!] ?? 0);
      totalNum.value = totalNum.value - 1;
      eventBus.fire(JokeCommentNumEvent(totalNum.value, jokesId));
      dataList.refresh();
    });
  }
}
