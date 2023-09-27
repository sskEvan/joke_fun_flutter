import 'dart:convert';

import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/qi_niu_token_entity.g.dart';

@JsonSerializable()
class QiNiuTokenEntity {
	String? token;

	QiNiuTokenEntity();

	factory QiNiuTokenEntity.fromJson(Map<String, dynamic> json) => $QiNiuTokenEntityFromJson(json);

	Map<String, dynamic> toJson() => $QiNiuTokenEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}