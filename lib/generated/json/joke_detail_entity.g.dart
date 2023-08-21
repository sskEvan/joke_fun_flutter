import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';

JokeDetailEntity $JokeDetailEntityFromJson(Map<String, dynamic> json) {
	final JokeDetailEntity jokeDetailEntity = JokeDetailEntity();
	final JokeDetailInfo? info = jsonConvert.convert<JokeDetailInfo>(json['info']);
	if (info != null) {
		jokeDetailEntity.info = info;
	}
	final JokeDetailJoke? joke = jsonConvert.convert<JokeDetailJoke>(json['joke']);
	if (joke != null) {
		jokeDetailEntity.joke = joke;
	}
	final JokeDetailUser? user = jsonConvert.convert<JokeDetailUser>(json['user']);
	if (user != null) {
		jokeDetailEntity.user = user;
	}
	return jokeDetailEntity;
}

Map<String, dynamic> $JokeDetailEntityToJson(JokeDetailEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['info'] = entity.info?.toJson();
	data['joke'] = entity.joke?.toJson();
	data['user'] = entity.user?.toJson();
	return data;
}

JokeDetailInfo $JokeDetailInfoFromJson(Map<String, dynamic> json) {
	final JokeDetailInfo jokeDetailInfo = JokeDetailInfo();
	final int? commentNum = jsonConvert.convert<int>(json['commentNum']);
	if (commentNum != null) {
		jokeDetailInfo.commentNum = commentNum;
	}
	final int? disLikeNum = jsonConvert.convert<int>(json['disLikeNum']);
	if (disLikeNum != null) {
		jokeDetailInfo.disLikeNum = disLikeNum;
	}
	final bool? isAttention = jsonConvert.convert<bool>(json['isAttention']);
	if (isAttention != null) {
		jokeDetailInfo.isAttention = isAttention;
	}
	final bool? isLike = jsonConvert.convert<bool>(json['isLike']);
	if (isLike != null) {
		jokeDetailInfo.isLike = isLike;
	}
	final bool? isUnlike = jsonConvert.convert<bool>(json['isUnlike']);
	if (isUnlike != null) {
		jokeDetailInfo.isUnlike = isUnlike;
	}
	final int? likeNum = jsonConvert.convert<int>(json['likeNum']);
	if (likeNum != null) {
		jokeDetailInfo.likeNum = likeNum;
	}
	final int? shareNum = jsonConvert.convert<int>(json['shareNum']);
	if (shareNum != null) {
		jokeDetailInfo.shareNum = shareNum;
	}
	return jokeDetailInfo;
}

Map<String, dynamic> $JokeDetailInfoToJson(JokeDetailInfo entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['commentNum'] = entity.commentNum;
	data['disLikeNum'] = entity.disLikeNum;
	data['isAttention'] = entity.isAttention;
	data['isLike'] = entity.isLike;
	data['isUnlike'] = entity.isUnlike;
	data['likeNum'] = entity.likeNum;
	data['shareNum'] = entity.shareNum;
	return data;
}

JokeDetailJoke $JokeDetailJokeFromJson(Map<String, dynamic> json) {
	final JokeDetailJoke jokeDetailJoke = JokeDetailJoke();
	final String? addTime = jsonConvert.convert<String>(json['addTime']);
	if (addTime != null) {
		jokeDetailJoke.addTime = addTime;
	}
	final String? auditMsg = jsonConvert.convert<String>(json['audit_msg']);
	if (auditMsg != null) {
		jokeDetailJoke.auditMsg = auditMsg;
	}
	final String? content = jsonConvert.convert<String>(json['content']);
	if (content != null) {
		jokeDetailJoke.content = content;
	}
	final bool? hot = jsonConvert.convert<bool>(json['hot']);
	if (hot != null) {
		jokeDetailJoke.hot = hot;
	}
	final String? imageSize = jsonConvert.convert<String>(json['imageSize']);
	if (imageSize != null) {
		jokeDetailJoke.imageSize = imageSize;
	}
	final String? imageUrl = jsonConvert.convert<String>(json['imageUrl']);
	if (imageUrl != null) {
		jokeDetailJoke.imageUrl = imageUrl;
	}
	final int? jokesId = jsonConvert.convert<int>(json['jokesId']);
	if (jokesId != null) {
		jokeDetailJoke.jokesId = jokesId;
	}
	final String? latitudeLongitude = jsonConvert.convert<String>(json['latitudeLongitude']);
	if (latitudeLongitude != null) {
		jokeDetailJoke.latitudeLongitude = latitudeLongitude;
	}
	final String? showAddress = jsonConvert.convert<String>(json['showAddress']);
	if (showAddress != null) {
		jokeDetailJoke.showAddress = showAddress;
	}
	final String? thumbUrl = jsonConvert.convert<String>(json['thumbUrl']);
	if (thumbUrl != null) {
		jokeDetailJoke.thumbUrl = thumbUrl;
	}
	final int? type = jsonConvert.convert<int>(json['type']);
	if (type != null) {
		jokeDetailJoke.type = type;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		jokeDetailJoke.userId = userId;
	}
	final String? videoSize = jsonConvert.convert<String>(json['videoSize']);
	if (videoSize != null) {
		jokeDetailJoke.videoSize = videoSize;
	}
	final int? videoTime = jsonConvert.convert<int>(json['videoTime']);
	if (videoTime != null) {
		jokeDetailJoke.videoTime = videoTime;
	}
	final String? videoUrl = jsonConvert.convert<String>(json['videoUrl']);
	if (videoUrl != null) {
		jokeDetailJoke.videoUrl = videoUrl;
	}
	return jokeDetailJoke;
}

Map<String, dynamic> $JokeDetailJokeToJson(JokeDetailJoke entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['addTime'] = entity.addTime;
	data['audit_msg'] = entity.auditMsg;
	data['content'] = entity.content;
	data['hot'] = entity.hot;
	data['imageSize'] = entity.imageSize;
	data['imageUrl'] = entity.imageUrl;
	data['jokesId'] = entity.jokesId;
	data['latitudeLongitude'] = entity.latitudeLongitude;
	data['showAddress'] = entity.showAddress;
	data['thumbUrl'] = entity.thumbUrl;
	data['type'] = entity.type;
	data['userId'] = entity.userId;
	data['videoSize'] = entity.videoSize;
	data['videoTime'] = entity.videoTime;
	data['videoUrl'] = entity.videoUrl;
	return data;
}

JokeDetailUser $JokeDetailUserFromJson(Map<String, dynamic> json) {
	final JokeDetailUser jokeDetailUser = JokeDetailUser();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		jokeDetailUser.avatar = avatar;
	}
	final String? nickName = jsonConvert.convert<String>(json['nickName']);
	if (nickName != null) {
		jokeDetailUser.nickName = nickName;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		jokeDetailUser.signature = signature;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		jokeDetailUser.userId = userId;
	}
	return jokeDetailUser;
}

Map<String, dynamic> $JokeDetailUserToJson(JokeDetailUser entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['avatar'] = entity.avatar;
	data['nickName'] = entity.nickName;
	data['signature'] = entity.signature;
	data['userId'] = entity.userId;
	return data;
}