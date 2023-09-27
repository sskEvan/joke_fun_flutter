import 'package:joke_fun_flutter/generated/json/base/json_convert_content.dart';
import 'package:joke_fun_flutter/models/recommend_attention_entity.dart';

RecommendAttentionEntity $RecommendAttentionEntityFromJson(Map<String, dynamic> json) {
	final RecommendAttentionEntity recommendAttentionEntity = RecommendAttentionEntity();
	final String? avatar = jsonConvert.convert<String>(json['avatar']);
	if (avatar != null) {
		recommendAttentionEntity.avatar = avatar;
	}
	final String? fansNum = jsonConvert.convert<String>(json['fansNum']);
	if (fansNum != null) {
		recommendAttentionEntity.fansNum = fansNum;
	}
	final bool? isAttention = jsonConvert.convert<bool>(json['isAttention']);
	if (isAttention != null) {
		recommendAttentionEntity.isAttention = isAttention;
	}
	final String? jokesNum = jsonConvert.convert<String>(json['jokesNum']);
	if (jokesNum != null) {
		recommendAttentionEntity.jokesNum = jokesNum;
	}
	final String? nickname = jsonConvert.convert<String>(json['nickname']);
	if (nickname != null) {
		recommendAttentionEntity.nickname = nickname;
	}
	final int? userId = jsonConvert.convert<int>(json['userId']);
	if (userId != null) {
		recommendAttentionEntity.userId = userId;
	}
	return recommendAttentionEntity;
}

Map<String, dynamic> $RecommendAttentionEntityToJson(RecommendAttentionEntity entity) {
	final Map<String, dynamic> data = <String, dynamic>{};
	data['avatar'] = entity.avatar;
	data['fansNum'] = entity.fansNum;
	data['isAttention'] = entity.isAttention;
	data['jokesNum'] = entity.jokesNum;
	data['nickname'] = entity.nickname;
	data['userId'] = entity.userId;
	return data;
}