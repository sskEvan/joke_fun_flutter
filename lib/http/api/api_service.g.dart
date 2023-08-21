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
  Future<BaseResult<List<JokeDetailEntity>>> getAttentionRecommendList(
      page) async {
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
  Future<BaseResult<List<JokeDetailEntity>>> getCommentList(page) async {
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
              '/user/comment/list',
              queryParameters: queryParameters,
              data: _data,
            )
            .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = BaseResult<List<JokeDetailEntity>>.fromJson(_result.data!);
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
