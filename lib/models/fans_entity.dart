import 'dart:convert';

import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/fans_entity.g.dart';

@JsonSerializable()
class FansEntity {
	int? attention;
	String? avatar;
	String? nickname;
	String? signature;
	int? userId;

	FansEntity();

	factory FansEntity.fromJson(Map<String, dynamic> json) => $FansEntityFromJson(json);

	Map<String, dynamic> toJson() => $FansEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}