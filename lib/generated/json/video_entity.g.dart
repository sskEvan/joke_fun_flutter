import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/video_entity.dart';

VideoEntity $VideoEntityFromJson(Map<String, dynamic> json) {
	final VideoEntity videoEntity = VideoEntity();
	final String? cover = jsonConvert.convert<String>(json['cover']);
	if (cover != null) {
		videoEntity.cover = cover;
	}
	final int? jokeId = jsonConvert.convert<int>(json['jokeId']);
	if (jokeId != null) {
		videoEntity.jokeId = jokeId;
	}
	final String? likeNum = jsonConvert.convert<String>(json['likeNum']);
	if (likeNum != null) {
		videoEntity.likeNum = likeNum;
	}
	return videoEntity;
}

Map<String, dynamic> $VideoEntityToJson(VideoEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['cover'] = entity.cover;
	data['jokeId'] = entity.jokeId;
	data['likeNum'] = entity.likeNum;
	return data;
}