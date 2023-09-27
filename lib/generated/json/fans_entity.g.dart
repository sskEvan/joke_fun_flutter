import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/fans_entity.dart';

FansEntity $FansEntityFromJson(Map<String, dynamic> json) {
	final FansEntity fansEntity = FansEntity();
	final int? attention = jsonConvert.convert<int>(json['attention']);
	if (attention != null) {
		fansEntity.attention = attention;
	}
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		fansEntity.avatar = avatar;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		fansEntity.nickname = nickname;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		fansEntity.signature = signature;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		fansEntity.userId = userId;
	}
	return fansEntity;
}

Map<String, dynamic> $FansEntityToJson(FansEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['attention'] = entity.attention;
	data['avatar'] = entity.avatar;
	data['nickname'] = entity.nickname;
	data['signature'] = entity.signature;
	data['userId'] = entity.userId;
	return data;
}