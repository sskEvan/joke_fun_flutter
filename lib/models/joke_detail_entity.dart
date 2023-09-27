import 'dart:math';

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

	String? _testVideoURL;

	JokeDetailJoke();

	factory JokeDetailJoke.fromJson(Map<String, dynamic> json) => $JokeDetailJokeFromJson(json);

	Map<String, dynamic> toJson() => $JokeDetailJokeToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}

	/// 大部分videoUrl无法播放，这里使用测试url
	String getTestVideoUrl() {
		if(_testVideoURL == null) {
			List<String> testUrls = [
				"http://video.chinanews.com/flv/2019/04/23/400/111773_web.mp4",
				"https://v-cdn.zjol.com.cn/276982.mp4",
				"https://v-cdn.zjol.com.cn/280443.mp4",
				"https://v-cdn.zjol.com.cn/276984.mp4",
				"https://v-cdn.zjol.com.cn/276985.mp4",
			];
			_testVideoURL = testUrls[Random().nextInt(testUrls.length)];
		}
		return _testVideoURL!;
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