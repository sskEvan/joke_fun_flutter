import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/comment_entity.dart';

CommentEntity $CommentEntityFromJson(Map<String, dynamic> json) {
	final CommentEntity commentEntity = CommentEntity();
	final int? commentId = jsonConvert.convert<int>(json['commentId']);
	if (commentId != null) {
		commentEntity.commentId = commentId;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		commentEntity.content = content;
	}
	final String? extraContent = jsonConvert.convert<String>(json['extraContent']);
	if (extraContent != null) {
		commentEntity.extraContent = extraContent;
	}
	final int? msgId = jsonConvert.convert<int>(json['msgId']);
	if (msgId != null) {
		commentEntity.msgId = msgId;
	}
	final int? msgItemType = jsonConvert.convert<int>(json['msgItemType']);
	if (msgItemType != null) {
		commentEntity.msgItemType = msgItemType;
	}
	final String? msgItemTypeDesc = jsonConvert.convert<String>(json['msgItemTypeDesc']);
	if (msgItemTypeDesc != null) {
		commentEntity.msgItemTypeDesc = msgItemTypeDesc;
	}
	final int? msgMainType = jsonConvert.convert<int>(json['msgMainType']);
	if (msgMainType != null) {
		commentEntity.msgMainType = msgMainType;
	}
	final String? msgMainTypeDesc = jsonConvert.convert<String>(json['msgMainTypeDesc']);
	if (msgMainTypeDesc != null) {
		commentEntity.msgMainTypeDesc = msgMainTypeDesc;
	}
	final int? msgStatus = jsonConvert.convert<int>(json['msgStatus']);
	if (msgStatus != null) {
		commentEntity.msgStatus = msgStatus;
	}
	final String? msgTime = jsonConvert.convert<String>(json['msgTime']);
	if (msgTime != null) {
		commentEntity.msgTime = msgTime;
	}
	final int? ownerUserId = jsonConvert.convert<int>(json['ownerUserId']);
	if (ownerUserId != null) {
		commentEntity.ownerUserId = ownerUserId;
	}
	final int? targetId = jsonConvert.convert<int>(json['targetId']);
	if (targetId != null) {
		commentEntity.targetId = targetId;
	}
	final String? targetNickname = jsonConvert.convert<String>(json['targetNickname']);
	if (targetNickname != null) {
		commentEntity.targetNickname = targetNickname;
	}
	final String? targetUserAvatar = jsonConvert.convert<String>(json['targetUserAvatar']);
	if (targetUserAvatar != null) {
		commentEntity.targetUserAvatar = targetUserAvatar;
	}
	final int? targetUserId = jsonConvert.convert<int>(json['targetUserId']);
	if (targetUserId != null) {
		commentEntity.targetUserId = targetUserId;
	}
	return commentEntity;
}

Map<String, dynamic> $CommentEntityToJson(CommentEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['commentId'] = entity.commentId;
	data['content'] = entity.content;
	data['extraContent'] = entity.extraContent;
	data['msgId'] = entity.msgId;
	data['msgItemType'] = entity.msgItemType;
	data['msgItemTypeDesc'] = entity.msgItemTypeDesc;
	data['msgMainType'] = entity.msgMainType;
	data['msgMainTypeDesc'] = entity.msgMainTypeDesc;
	data['msgStatus'] = entity.msgStatus;
	data['msgTime'] = entity.msgTime;
	data['ownerUserId'] = entity.ownerUserId;
	data['targetId'] = entity.targetId;
	data['targetNickname'] = entity.targetNickname;
	data['targetUserAvatar'] = entity.targetUserAvatar;
	data['targetUserId'] = entity.targetUserId;
	return data;
}