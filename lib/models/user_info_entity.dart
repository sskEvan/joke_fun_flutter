import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/user_info_entity.g.dart';
import 'dart:convert';

import 'login_entity.dart';

@JsonSerializable()
class UserInfoEntity {
	UserInfo? info;
	User? user;

	UserInfoEntity();

	factory UserInfoEntity.fromJson(Map<String, dynamic> json) => $UserInfoEntityFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class UserInfo {
	int? attentionNum;
	int? experienceNum;
	int? fansNum;
	int? likeNum;

	UserInfo();

	factory UserInfo.fromJson(Map<String, dynamic> json) => $UserInfoFromJson(json);

	Map<String, dynamic> toJson() => $UserInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
