import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/login_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class LoginEntity {
	String? token;
	String? type;
	User? userInfo;

	LoginEntity();

	factory LoginEntity.fromJson(Map<String, dynamic> json) => $LoginEntityFromJson(json);

	Map<String, dynamic> toJson() => $LoginEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class User {
	String? avatar;
	String? birthday;
	String? inviteCode;
	String? invitedCode;
	String? nickname;
	String? sex;
	String? signature;
	int? userId;
	String? userPhone;

	User();

	factory User.fromJson(Map<String, dynamic> json) => $UserFromJson(json);

	Map<String, dynamic> toJson() => $UserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}