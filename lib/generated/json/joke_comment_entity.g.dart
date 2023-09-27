import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/joke_comment_entity.dart';

JokeCommentEntity $JokeCommentEntityFromJson(Map<String, dynamic> json) {
	final JokeCommentEntity jokeCommentEntity = JokeCommentEntity();
	final List<JokeComment>? comments = jsonConvert.convertListNotNull<JokeComment>(json['comments']);
	if (comments != null) {
		jokeCommentEntity.comments = comments;
	}
	final int? count = jsonConvert.convert<int>(json['count']);
	if (count != null) {
		jokeCommentEntity.count = count;
	}
	return jokeCommentEntity;
}

Map<String, dynamic> $JokeCommentEntityToJson(JokeCommentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['comments'] =  entity.comments?.map((v) => v.toJson()).toList();
	data['count'] = entity.count;
	return data;
}

JokeComment $JokeCommentFromJson(Map<String, dynamic> json) {
	final JokeComment jokeComment = JokeComment();
	final int? commentId = jsonConvert.convert<int>(json['commentId']);
	if (commentId != null) {
		jokeComment.commentId = commentId;
	}
	final JokeCommentUser? commentUser = jsonConvert.convert<JokeCommentUser>(json['commentUser']);
	if (commentUser != null) {
		jokeComment.commentUser = commentUser;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		jokeComment.content = content;
	}
	final bool? isLike = jsonConvert.convert<bool>(json['isLike']);
	if (isLike != null) {
		jokeComment.isLike = isLike;
	}
	final List<JokeSubComment>? itemCommentList = jsonConvert.convertListNotNull<JokeSubComment>(json['itemCommentList']);
	if (itemCommentList != null) {
		jokeComment.itemCommentList = itemCommentList;
	}
	final int? itemCommentNum = jsonConvert.convert<int>(json['itemCommentNum']);
	if (itemCommentNum != null) {
		jokeComment.itemCommentNum = itemCommentNum;
	}
	final int? jokeId = jsonConvert.convert<int>(json['jokeId']);
	if (jokeId != null) {
		jokeComment.jokeId = jokeId;
	}
	final int? jokeOwnerUserId = jsonConvert.convert<int>(json['jokeOwnerUserId']);
	if (jokeOwnerUserId != null) {
		jokeComment.jokeOwnerUserId = jokeOwnerUserId;
	}
	final int? likeNum = jsonConvert.convert<int>(json['likeNum']);
	if (likeNum != null) {
		jokeComment.likeNum = likeNum;
	}
	final String? timeStr = jsonConvert.convert<String>(json['timeStr']);
	if (timeStr != null) {
		jokeComment.timeStr = timeStr;
	}
	final int? status = jsonConvert.convert<int>(json['status']);
	if (status != null) {
		jokeComment.status = status;
	}
	return jokeComment;
}

Map<String, dynamic> $JokeCommentToJson(JokeComment entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['commentId'] = entity.commentId;
	data['commentUser'] = entity.commentUser?.toJson();
	data['content'] = entity.content;
	data['isLike'] = entity.isLike;
	data['itemCommentList'] =  entity.itemCommentList?.map((v) => v.toJson()).toList();
	data['itemCommentNum'] = entity.itemCommentNum;
	data['jokeId'] = entity.jokeId;
	data['jokeOwnerUserId'] = entity.jokeOwnerUserId;
	data['likeNum'] = entity.likeNum;
	data['timeStr'] = entity.timeStr;
	data['status'] = entity.status;
	return data;
}

JokeCommentUser $JokeCommentUserFromJson(Map<String, dynamic> json) {
	final JokeCommentUser jokeCommentUser = JokeCommentUser();
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		jokeCommentUser.nickname = nickname;
	}
	final String? userAvatar = jsonConvert.convert<String>(json['userAvatar']);
	if (userAvatar != null) {
		jokeCommentUser.userAvatar = userAvatar;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		jokeCommentUser.userId = userId;
	}
	return jokeCommentUser;
}

Map<String, dynamic> $JokeCommentUserToJson(JokeCommentUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['nickname'] = entity.nickname;
	data['userAvatar'] = entity.userAvatar;
	data['userId'] = entity.userId;
	return data;
}

JokeSubComment $JokeSubCommentFromJson(Map<String, dynamic> json) {
	final JokeSubComment jokeSubComment = JokeSubComment();
	final int? commentItemId = jsonConvert.convert<int>(json['commentItemId']);
	if (commentItemId != null) {
		jokeSubComment.commentItemId = commentItemId;
	}
	final int? commentParentId = jsonConvert.convert<int>(json['commentParentId']);
	if (commentParentId != null) {
		jokeSubComment.commentParentId = commentParentId;
	}
	final JokeCommentUser? commentUser = jsonConvert.convert<JokeCommentUser>(json['commentUser']);
	if (commentUser != null) {
		jokeSubComment.commentUser = commentUser;
	}
	final String? commentedNickname = jsonConvert.convert<String>(json['commentedNickname']);
	if (commentedNickname != null) {
		jokeSubComment.commentedNickname = commentedNickname;
	}
	final int? commentedUserId = jsonConvert.convert<int>(json['commentedUserId']);
	if (commentedUserId != null) {
		jokeSubComment.commentedUserId = commentedUserId;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		jokeSubComment.content = content;
	}
	final bool? isReplyChild = jsonConvert.convert<bool>(json['isReplyChild']);
	if (isReplyChild != null) {
		jokeSubComment.isReplyChild = isReplyChild;
	}
	final int? jokeId = jsonConvert.convert<int>(json['jokeId']);
	if (jokeId != null) {
		jokeSubComment.jokeId = jokeId;
	}
	final String? timeStr = jsonConvert.convert<String>(json['timeStr']);
	if (timeStr != null) {
		jokeSubComment.timeStr = timeStr;
	}
	return jokeSubComment;
}

Map<String, dynamic> $JokeSubCommentToJson(JokeSubComment entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['commentItemId'] = entity.commentItemId;
	data['commentParentId'] = entity.commentParentId;
	data['commentUser'] = entity.commentUser?.toJson();
	data['commentedNickname'] = entity.commentedNickname;
	data['commentedUserId'] = entity.commentedUserId;
	data['content'] = entity.content;
	data['isReplyChild'] = entity.isReplyChild;
	data['jokeId'] = entity.jokeId;
	data['timeStr'] = entity.timeStr;
	return data;
}