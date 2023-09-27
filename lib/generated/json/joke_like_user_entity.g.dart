import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/joke_like_user_entity.dart';

JokeLikeUserEntity $JokeLikeUserEntityFromJson(Map<String, dynamic> json) {
	final JokeLikeUserEntity jokeLikeUserEntity = JokeLikeUserEntity();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		jokeLikeUserEntity.avatar = avatar;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		jokeLikeUserEntity.nickname = nickname;
	}
	final int? userId = jsonConvert.convert<int>(json['user_id']);
	if (userId != null) {
		jokeLikeUserEntity.userId = userId;
	}
	return jokeLikeUserEntity;
}

Map<String, dynamic> $JokeLikeUserEntityToJson(JokeLikeUserEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['avatar'] = entity.avatar;
	data['nickname'] = entity.nickname;
	data['user_id'] = entity.userId;
	return data;
}