// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _ApiService implements ApiService {
  _ApiService(
    this._dio, {
    this.baseUrl,
  }) {
    baseUrl ??= 'http://tools.cretinzp.com/jokes/';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getRecommendList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/home/recommend',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getPicList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/home/pic',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getTextList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/home/text',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getLatestList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/home/latest',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getAttentionList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/home/attention/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<RecommendAttentionEntity>>>
      getAttentionRecommendList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<RecommendAttentionEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/home/attention/recommend',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        BaseResult<List<RecommendAttentionEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getUserLikeTextPicJokesList(
    targetUserId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'targetUserId': targetUserId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/text_pic_jokes/like/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getUserTextPicJokesList(
    targetUserId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'targetUserId': targetUserId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/text_pic_jokes/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<VideoEntity>>> getUserVideoList(
    targetUserId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'targetUserId': targetUserId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<VideoEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/video/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<VideoEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<VideoEntity>>> getUserLikeVideoList(
    targetUserId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'targetUserId': targetUserId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<VideoEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/video/like/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<VideoEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> unlikeJoke(
    id,
    status,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'id': id,
      'status': status,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/unlike',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> likeJoke(
    id,
    status,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'id': id,
      'status': status,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/like',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<JokeCommentEntity>> getJokeCommentList(
    jokeId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'jokeId': jokeId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<JokeCommentEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/comment/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<JokeCommentEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<JokeComment>> postJokeComment(
    jokeId,
    content,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'jokeId': jokeId,
      'content': content,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<JokeComment>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/comment',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<JokeComment>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> likeJokeComment(
    commentId,
    status,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'commentId': commentId,
      'status': status,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/comment/like',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> deleteJokeComment(commentId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'commentId': commentId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/comment/delete',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> deleteJokeSubComment(commentId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'commentId': commentId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/comment/item/delete',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<JokeSubComment>> postJokeSubComment(
    commentId,
    content,
    isReplyChild,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'commentId': commentId,
      'content': content,
      'isReplyChild': isReplyChild,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<JokeSubComment>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/comment/item',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<JokeSubComment>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeSubComment>>> getJokeSubCommentList(
    commentId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'commentId': commentId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeSubComment>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/comment/list/item',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeSubComment>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeLikeUserEntity>>> getJokeLikeList(
    jokeId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'jokeId': jokeId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeLikeUserEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/like/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeLikeUserEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<JokeDetailEntity>> getTargetJoke(jokeId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'jokeId': jokeId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<JokeDetailEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/target',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<JokeDetailEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> searchJokes(
    keyword,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'keyword': keyword,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/home/jokes/search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<String>>> getHotSearch() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<String>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/helper/hot_search',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<String>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> postJoke(
    content,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'content': content,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/jokes/post',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> discoveryList() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/douyin/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getCreationJokeList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/jokes/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<CommentEntity>>> getCommentList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<CommentEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/comment/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<CommentEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getCollectJokeList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/collect/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<JokeDetailEntity>>> getLikeJokeList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<JokeDetailEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/like/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> getLoginVerifyCode(phone) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'phone': phone};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/login/get_code',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<LoginEntity>> loginByCode(
    code,
    phone,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'code': code,
      'phone': phone,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<LoginEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/login/code',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<LoginEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<UserInfoEntity>> getUserInfo() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<UserInfoEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
    )
            .compose(
              _dio.options,
              '/user/info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<UserInfoEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<UserCenterEntity>> getTargetUserInfo(targetUserId) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'targetUserId': targetUserId};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<UserCenterEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/info/target',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<UserCenterEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> updateUserInfo(
    content,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'content': content,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/info/update',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<QiNiuTokenEntity>> getQiNiuToken(
    filename,
    type,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'filename': filename,
      'type': type,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<QiNiuTokenEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/helper/qiniu/token',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<QiNiuTokenEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<dynamic>> attentionUser(
    status,
    userId,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'status': status,
      'userId': userId,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<dynamic>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/attention',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<dynamic>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<FansEntity>>> getUserAttentionList(
    targetUserId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'targetUserId': targetUserId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<FansEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/attention/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<FansEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<FansEntity>>> getUserFansList(
    targetUserId,
    page,
  ) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {
      'targetUserId': targetUserId,
      'page': page,
    };
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<FansEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/fans/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<FansEntity>>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<ExperienceOverviewEntity>> getExperienceOverview() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final Map<String, dynamic>? _data = null;
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<ExperienceOverviewEntity>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/ledou/info',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<ExperienceOverviewEntity>.fromJson(_result.data!);
    return value;
  }

  @override
  Future<BaseResult<List<ExperienceItemEntity>>> getExperienceList(page) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    final _data = {'page': page};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<BaseResult<List<ExperienceItemEntity>>>(Options(
      method: 'POST',
      headers: _headers,
      extra: _extra,
      contentType: 'application/x-www-form-urlencoded',
    )
            .compose(
              _dio.options,
              '/user/ledou/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value =
        BaseResult<List<ExperienceItemEntity>>.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
