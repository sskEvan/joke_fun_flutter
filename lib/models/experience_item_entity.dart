import 'dart:convert';

import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/experience_item_entity.g.dart';

@JsonSerializable()
class ExperienceItemEntity {
	String? desc;
	String? num;
	String? time;

	ExperienceItemEntity();

	factory ExperienceItemEntity.fromJson(Map<String, dynamic> json) => $ExperienceItemEntityFromJson(json);

	Map<String, dynamic> toJson() => $ExperienceItemEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}