import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';

LoginEntity $LoginEntityFromJson(Map<String, dynamic> json) {
	final LoginEntity loginEntity = LoginEntity();
	final String? token = jsonConvert.convert<String>(json['token']);
	if (token != null) {
		loginEntity.token = token;
	}
	final String? type = jsonConvert.convert<String>(json['type']);
	if (type != null) {
		loginEntity.type = type;
	}
	final User? userInfo = jsonConvert.convert<User>(json['userInfo']);
	if (userInfo != null) {
		loginEntity.userInfo = userInfo;
	}
	return loginEntity;
}

Map<String, dynamic> $LoginEntityToJson(LoginEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['token'] = entity.token;
	data['type'] = entity.type;
	data['userInfo'] = entity.userInfo?.toJson();
	return data;
}

User $UserFromJson(Map<String, dynamic> json) {
	final User user = User();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		user.avatar = avatar;
	}
	final String? birthday = jsonConvert.convert<String>(json['birthday']);
	if (birthday != null) {
		user.birthday = birthday;
	}
	final String? inviteCode = jsonConvert.convert<String>(json['inviteCode']);
	if (inviteCode != null) {
		user.inviteCode = inviteCode;
	}
	final String? invitedCode = jsonConvert.convert<String>(json['invitedCode']);
	if (invitedCode != null) {
		user.invitedCode = invitedCode;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		user.nickname = nickname;
	}
	final String? sex = jsonConvert.convert<String>(json['sex']);
	if (sex != null) {
		user.sex = sex;
	}
	final String? signature = jsonConvert.convert<String>(json['signature']);
	if (signature != null) {
		user.signature = signature;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		user.userId = userId;
	}
	final String? userPhone = jsonConvert.convert<String>(json['userPhone']);
	if (userPhone != null) {
		user.userPhone = userPhone;
	}
	return user;
}

Map<String, dynamic> $UserToJson(User entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['avatar'] = entity.avatar;
	data['birthday'] = entity.birthday;
	data['inviteCode'] = entity.inviteCode;
	data['invitedCode'] = entity.invitedCode;
	data['nickname'] = entity.nickname;
	data['sex'] = entity.sex;
	data['signature'] = entity.signature;
	data['userId'] = entity.userId;
	data['userPhone'] = entity.userPhone;
	return data;
}