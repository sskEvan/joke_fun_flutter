import 'dart:convert';

import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/joke_comment_entity.g.dart';

@JsonSerializable()
class JokeCommentEntity {
	List<JokeComment>? comments;
	int? count;

	JokeCommentEntity();

	factory JokeCommentEntity.fromJson(Map<String, dynamic> json) => $JokeCommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $JokeCommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class JokeComment {
	int? commentId;
	JokeCommentUser? commentUser;
	String? content;
	bool? isLike;
	List<JokeSubComment>? itemCommentList;
	int? itemCommentNum;
	int? jokeId;
	int? jokeOwnerUserId;
	int? likeNum;
	String? timeStr;
	/// 0或者null:收起，1：加载中，2：展开一半， 3：完全展开
	int? status;

	JokeComment();

	factory JokeComment.fromJson(Map<String, dynamic> json) => $JokeCommentFromJson(json);

	Map<String, dynamic> toJson() => $JokeCommentToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class JokeCommentUser {
	String? nickname;
	String? userAvatar;
	int? userId;

	JokeCommentUser();

	factory JokeCommentUser.fromJson(Map<String, dynamic> json) => $JokeCommentUserFromJson(json);

	Map<String, dynamic> toJson() => $JokeCommentUserToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}

@JsonSerializable()
class JokeSubComment {
	int? commentItemId;
	int? commentParentId;
	JokeCommentUser? commentUser;
	String? commentedNickname;
	int? commentedUserId;
	String? content;
	bool? isReplyChild;
	int? jokeId;
	String? timeStr;

	JokeSubComment();

	factory JokeSubComment.fromJson(Map<String, dynamic> json) => $JokeSubCommentFromJson(json);

	Map<String, dynamic> toJson() => $JokeSubCommentToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}
