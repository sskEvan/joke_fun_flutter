import 'dart:convert';

import 'package:joke_fun_flutter/generated/json/base/json_field.dart';
import 'package:joke_fun_flutter/generated/json/comment_entity.g.dart';

@JsonSerializable()
class CommentEntity {
	int? commentId;
	String? content;
	String? extraContent;
	int? msgId;
	int? msgItemType;
	String? msgItemTypeDesc;
	int? msgMainType;
	String? msgMainTypeDesc;
	int? msgStatus;
	String? msgTime;
	int? ownerUserId;
	int? targetId;
	String? targetNickname;
	String? targetUserAvatar;
	int? targetUserId;

	CommentEntity();

	factory CommentEntity.fromJson(Map<String, dynamic> json) => $CommentEntityFromJson(json);

	Map<String, dynamic> toJson() => $CommentEntityToJson(this);

	@override
	String toString() {
		return jsonEncode(this);
	}
}