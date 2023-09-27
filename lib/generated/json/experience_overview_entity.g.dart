import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/experience_overview_entity.dart';

ExperienceOverviewEntity $ExperienceOverviewEntityFromJson(Map<String, dynamic> json) {
	final ExperienceOverviewEntity experienceOverviewEntity = ExperienceOverviewEntity();
	final String? experienceNum = jsonConvert.convert<String>(json['experienceNum']);
	if (experienceNum != null) {
		experienceOverviewEntity.experienceNum = experienceNum;
	}
	final String? experienceRank = jsonConvert.convert<String>(json['experienceRank']);
	if (experienceRank != null) {
		experienceOverviewEntity.experienceRank = experienceRank;
	}
	final bool? isSignin = jsonConvert.convert<bool>(json['isSignin']);
	if (isSignin != null) {
		experienceOverviewEntity.isSignin = isSignin;
	}
	final int? lotteryCost = jsonConvert.convert<int>(json['lotteryCost']);
	if (lotteryCost != null) {
		experienceOverviewEntity.lotteryCost = lotteryCost;
	}
	return experienceOverviewEntity;
}

Map<String, dynamic> $ExperienceOverviewEntityToJson(ExperienceOverviewEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['experienceNum'] = entity.experienceNum;
	data['experienceRank'] = entity.experienceRank;
	data['isSignin'] = entity.isSignin;
	data['lotteryCost'] = entity.lotteryCost;
	return data;
}