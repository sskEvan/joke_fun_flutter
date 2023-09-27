import 'dart:convert';

import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/experience_overview_entity.g.dart';

@JsonSerializable()
class ExperienceOverviewEntity {
	String? experienceNum;
	String? experienceRank;
	bool? isSignin;
	int? lotteryCost;

	ExperienceOverviewEntity();

	factory ExperienceOverviewEntity.fromJson(Map<String, dynamic> json) => $ExperienceOverviewEntityFromJson(json);

	Map<String, dynamic> toJson() => $ExperienceOverviewEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}