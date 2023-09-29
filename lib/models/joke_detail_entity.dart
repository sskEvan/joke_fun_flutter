import 'dart:math';

import 'package:joke_fun_flutter/common/util/media_util.dart';
import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/joke_detail_entity.g.dart';
import 'dart:convert';

@JsonSerializable()
class JokeDetailEntity {
	JokeDetailInfo? info;
	JokeDetailJoke? joke;
	JokeDetailUser? user;

	JokeDetailEntity();

	factory JokeDetailEntity.fromJson(Map<String, dynamic> json) => $JokeDetailEntityFromJson(json);

	Map<String, dynamic> toJson() => $JokeDetailEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class JokeDetailInfo {
	int? commentNum;
	int? disLikeNum;
	bool? isAttention;
	bool? isLike;
	bool? isUnlike;
	int? likeNum;
	int? shareNum;

	JokeDetailInfo();

	factory JokeDetailInfo.fromJson(Map<String, dynamic> json) => $JokeDetailInfoFromJson(json);

	Map<String, dynamic> toJson() => $JokeDetailInfoToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class JokeDetailJoke {
	String? addTime;
	@JSONField(name: "audit_msg")
	String? auditMsg;
	String? content;
	bool? hot;
	String? imageSize;
	String? imageUrl;
	int? jokesId;
	String? latitudeLongitude;
	String? showAddress;
	String? thumbUrl;
	int? type;
	int? userId;
	String? videoSize;
	int? videoTime;
	String? videoUrl;

	/// 大部分videoUrl无法播放，这里使用测试视频
	Map<String, dynamic>? _testVideoInfo;

	JokeDetailJoke();

	factory JokeDetailJoke.fromJson(Map<String, dynamic> json) => $JokeDetailJokeFromJson(json);

	Map<String, dynamic> toJson() => $JokeDetailJokeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	String getTestVideoUrl() {
		_testVideoInfo ??= getTestVideoInfo();
		return _testVideoInfo!["videoUrl"]!;
	}


	int getTestVideoWidth() {
		_testVideoInfo ??= getTestVideoInfo();
		return _testVideoInfo!["width"]!;
	}

	int getTestVideoHeight() {
		_testVideoInfo ??= getTestVideoInfo();
		return _testVideoInfo!["height"]!;
	}
}

@JsonSerializable()
class JokeDetailUser {
	String? avatar;
	String? nickName;
	String? signature;
	int? userId;

	JokeDetailUser();

	factory JokeDetailUser.fromJson(Map<String, dynamic> json) => $JokeDetailUserFromJson(json);

	Map<String, dynamic> toJson() => $JokeDetailUserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}