import 'package:dio/dio.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/comment_entity.dart';
import 'package:joke_fun_flutter/models/experience_item_entity.dart';
import 'package:joke_fun_flutter/models/experience_overview_entity.dart';
import 'package:joke_fun_flutter/models/fans_entity.dart';
import 'package:joke_fun_flutter/models/joke_comment_entity.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/models/joke_like_user_entity.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';
import 'package:joke_fun_flutter/models/qi_niu_token_entity.dart';
import 'package:joke_fun_flutter/models/recommend_attention_entity.dart';
import 'package:joke_fun_flutter/models/user_center_entity.dart';
import 'package:joke_fun_flutter/models/user_info_entity.dart';
import 'package:joke_fun_flutter/models/video_entity.dart';
import 'package:retrofit/http.dart';

import '../dio_client.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://tools.cretinzp.com/jokes/")
abstract class ApiService {
  factory ApiService({Dio? dio, String? baseUrl}) {
    return _ApiService(DioClient().dio, baseUrl: baseUrl);
  }

  ///获取主页的推荐列表数据
  @POST('/home/recommend')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getRecommendList(
      @Field() String page);

  ///获取主页的纯图片列表数据
  @POST('/home/pic')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getPicList(@Field() String page);

  ///获取主页的纯图片列表数据
  @POST('/home/text')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getTextList(@Field() String page);

  /// 获取主页的最新列表数据
  @POST('/home/latest')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getLatestList(
      @Field() String page);

  /// 获取主页的推荐关注数据
  @POST('/home/attention/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getAttentionList(
      @Field() String page);

  /// 获取主页的推荐关注数据
  @POST('/home/attention/recommend')
  Future<BaseResult<List<RecommendAttentionEntity>>>
      getAttentionRecommendList();

  /// 获取指定用户喜欢的图文段子列表
  @POST('/jokes/text_pic_jokes/like/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getUserLikeTextPicJokesList(
      @Field() String targetUserId, @Field() String page);

  /// 获取指定用户图文段子列表
  @POST('/jokes/text_pic_jokes/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getUserTextPicJokesList(
      @Field() String targetUserId, @Field() String page);

  /// 获取指定用户所有视频列表
  @POST('/jokes/video/list')
  @FormUrlEncoded()
  Future<BaseResult<List<VideoEntity>>> getUserVideoList(
      @Field() String targetUserId, @Field() String page);

  /// 获取指定用户喜欢的视频列表
  @POST('/jokes/video/like/list')
  @FormUrlEncoded()
  Future<BaseResult<List<VideoEntity>>> getUserLikeVideoList(
      @Field() String targetUserId, @Field() String page);

  ///踩段子-取消踩段子
  ///status:true为踩 false为取消踩
  @POST('/jokes/unlike')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> unlikeJoke(
      @Field() String id, @Field() String status);

  ///给段子点赞-取消点赞
  ///status:true为点赞 false为取消点赞
  @POST('/jokes/like')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> likeJoke(
      @Field() String id, @Field() String status);

  ///获取段子获取评论列表/jokes/comment/list
  @POST('/jokes/comment/list')
  @FormUrlEncoded()
  Future<BaseResult<JokeCommentEntity>> getJokeCommentList(
      @Field() String jokeId, @Field() String page);

  /// 发表一级评论
  @POST('/jokes/comment')
  @FormUrlEncoded()
  Future<BaseResult<JokeComment>> postJokeComment(
      @Field() String jokeId, @Field() String content);

  /// 评论 点赞-取消点赞
  /// status: true 点赞 false 取消点赞
  @POST('/jokes/comment/like')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> likeJokeComment(
      @Field() String commentId, @Field() String status);

  /// 删除主评论
  @POST('/jokes/comment/delete')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> deleteJokeComment(@Field() String commentId);

  /// 删除子评论
  @POST('/jokes/comment/item/delete')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> deleteJokeSubComment(@Field() String commentId);

  /// 添加子评论
  @POST('/jokes/comment/item')
  @FormUrlEncoded()
  Future<BaseResult<JokeSubComment>> postJokeSubComment(
      @Field() String commentId,
      @Field() String content,
      @Field() String isReplyChild);

  /// 获取子评论列表
  @POST('/jokes/comment/list/item')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeSubComment>>> getJokeSubCommentList(
      @Field() String commentId, @Field() String page);

  /// 获取指定id的段子的点赞列表
  @POST('/jokes/like/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeLikeUserEntity>>> getJokeLikeList(
      @Field() String jokeId, @Field() String page);

  /// 获取指定id的段子
  @POST('/jokes/target')
  @FormUrlEncoded()
  Future<BaseResult<JokeDetailEntity>> getTargetJoke(@Field() String jokeId);

  /// 搜索段子
  @POST('/home/jokes/search')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> searchJokes(
      @Field() String keyword, @Field() String page);

  /// 获取热搜关键词
  @POST('/helper/hot_search')
  @FormUrlEncoded()
  Future<BaseResult<List<String>>> getHotSearch();

  /// 发布段子(目前只支持发布文本，图片和url暂时无法上传)
  /// type 发布类型 1 文本 2 图片 3 视频
  @POST('/jokes/post')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> postJoke(
      @Field() String content, @Field() int type);

  /// *****************************当前用户相关*****************************

  /// 获取当前用户帖子列表
  @POST('/user/jokes/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getCreationJokeList(
      @Field() String page);

  /// 获取当前用户的评论列表
  @POST('/user/comment/list')
  @FormUrlEncoded()
  Future<BaseResult<List<CommentEntity>>> getCommentList(@Field() String page);

  /// 获取当前用户的收藏列表
  @POST('/user/collect/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getCollectJokeList(
      @Field() String page);

  /// 获取当前登录用户点赞列表
  @POST('/user/like/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getLikeJokeList(
      @Field() String page);

  /// 获取登录验证码
  @POST('/user/login/get_code')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> getLoginVerifyCode(@Field() String phone);

  /// 根据验证码登录
  @POST('/user/login/code')
  @FormUrlEncoded()
  Future<BaseResult<LoginEntity>> loginByCode(
      @Field() String code, @Field() String phone);

  /// 获取用户信息
  @POST('/user/info')
  Future<BaseResult<UserInfoEntity>> getUserInfo();

  /// 获取用户信息
  @POST('/user/info/target')
  @FormUrlEncoded()
  Future<BaseResult<UserCenterEntity>> getTargetUserInfo(
      @Field() String targetUserId);

  /// 更新用户信息
  /// type: 更新的类目 0 修改头像 先上传到七牛云 1 修改昵称 2 修改签名 3 修改性别 4 修改生日
  @POST('/user/info/update')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> updateUserInfo(
      @Field() String content, @Field() String type);

  /// 获取七牛云token
  /// 类型 type 0 获取普通token type 1 获取头像token
  @POST('/helper/qiniu/token')
  @FormUrlEncoded()
  Future<BaseResult<QiNiuTokenEntity>> getQiNiuToken(
      @Field() String filename, @Field() String type);

  /// 用户关注 /user/attention
  /// status 1 关注 0 取消关注
  @POST('/user/attention')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> attentionUser(
      @Field() String status, @Field() String userId);

  /// 获取指定用户关注列表
  @POST('/user/attention/list')
  @FormUrlEncoded()
  Future<BaseResult<List<FansEntity>>> getUserAttentionList(
      @Field() String targetUserId, @Field() String page);

  /// 获取指定用户粉丝列表
  @POST('/user/fans/list')
  @FormUrlEncoded()
  Future<BaseResult<List<FansEntity>>> getUserFansList(
      @Field() String targetUserId, @Field() String page);

  /// 获取当前用户积分概述
  @POST('/user/ledou/info')
  @FormUrlEncoded()
  Future<BaseResult<ExperienceOverviewEntity>> getExperienceOverview();

  /// 获取当前用户积分详情列表
  @POST('/user/ledou/list')
  @FormUrlEncoded()
  Future<BaseResult<List<ExperienceItemEntity>>> getExperienceList(
      @Field() String page);
}
