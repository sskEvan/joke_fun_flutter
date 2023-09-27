import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/user_center_entity.dart';

UserCenterEntity $UserCenterEntityFromJson(Map<String, dynamic> json) {
	final UserCenterEntity userCenterEntity = UserCenterEntity();
	final String? attentionNum = jsonConvert.convert<String>(json['attentionNum']);
	if (attentionNum != null) {
		userCenterEntity.attentionNum = attentionNum;
	}
	final int? attentionState = jsonConvert.convert<int>(json['attentionState']);
	if (attentionState != null) {
		userCenterEntity.attentionState = attentionState;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		userCenterEntity.avatar = avatar;
	}
	final String? collectNum = jsonConvert.convert<String>(json['collectNum']);
	if (collectNum != null) {
		userCenterEntity.collectNum = collectNum;
	}
	final String? commentNum = jsonConvert.convert<String>(json['commentNum']);
	if (commentNum != null) {
		userCenterEntity.commentNum = commentNum;
	}
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		userCenterEntity.cover = cover;
	}
	final String? fansNum = jsonConvert.convert<String>(json['fansNum']);
	if (fansNum != null) {
		userCenterEntity.fansNum = fansNum;
	}
	final String? joinTime = jsonConvert.convert<String>(json['joinTime']);
	if (joinTime != null) {
		userCenterEntity.joinTime = joinTime;
	}
	final String? jokeLikeNum = jsonConvert.convert<String>(json['jokeLikeNum']);
	if (jokeLikeNum != null) {
		userCenterEntity.jokeLikeNum = jokeLikeNum;
	}
	final String? jokesNum = jsonConvert.convert<String>(json['jokesNum']);
	if (jokesNum != null) {
		userCenterEntity.jokesNum = jokesNum;
	}
	final String? likeNum = jsonConvert.convert<String>(json['likeNum']);
	if (likeNum != null) {
		userCenterEntity.likeNum = likeNum;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		userCenterEntity.nickname = nickname;
	}
	final String? sigbature = jsonConvert.convert<String>(json['sigbature']);
	if (sigbature != null) {
		userCenterEntity.sigbature = sigbature;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		userCenterEntity.userId = userId;
	}
	return userCenterEntity;
}

Map<String, dynamic> $UserCenterEntityToJson(UserCenterEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['attentionNum'] = entity.attentionNum;
	data['attentionState'] = entity.attentionState;
	data['avatar'] = entity.avatar;
	data['collectNum'] = entity.collectNum;
	data['commentNum'] = entity.commentNum;
	data['cover'] = entity.cover;
	data['fansNum'] = entity.fansNum;
	data['joinTime'] = entity.joinTime;
	data['jokeLikeNum'] = entity.jokeLikeNum;
	data['jokesNum'] = entity.jokesNum;
	data['likeNum'] = entity.likeNum;
	data['nickname'] = entity.nickname;
	data['sigbature'] = entity.sigbature;
	data['userId'] = entity.userId;
	return data;
}