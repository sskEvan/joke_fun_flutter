import 'package:dio/dio.dart';
import 'package:joke_fun_flutter/models/base_result.dart';
import 'package:joke_fun_flutter/models/joke_detail_entity.dart';
import 'package:joke_fun_flutter/models/login_entity.dart';
import 'package:joke_fun_flutter/models/user_info_entity.dart';
import 'package:retrofit/http.dart';

import '../dio_client.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://tools.cretinzp.com/jokes/")
abstract class ApiService {
  factory ApiService({Dio? dio, String? baseUrl}) {
    return _ApiService(DioClient().dio, baseUrl: baseUrl);
  }

  ///获取主页的推荐列表数据
  @POST('/home/recommend')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getRecommendList(
      @Field() String page);

  ///获取主页的纯图片列表数据
  @POST('/home/pic')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getPicList(
      @Field() String page);

  ///获取主页的纯图片列表数据
  @POST('/home/text')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getTextList(
      @Field() String page);

  /// 获取主页的最新列表数据
  @POST('/home/latest')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getLatestList(
      @Field() String page);

  /// 获取主页的推荐关注数据
  @POST('/home/attention/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getAttentionRecommendList(
      @Field() String page);


  /// *****************************当前用户相关*****************************

  /// 获取当前用户帖子列表
  @POST('/user/jokes/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getCreationJokeList(
      @Field() String page);

  /// 获取当前用户的评论列表
  @POST('/user/comment/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getCommentList(
      @Field() String page);

  /// 获取当前用户的收藏列表
  @POST('/user/collect/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getCollectJokeList(
      @Field() String page);

  /// 获取当前登录用户点赞列表
  @POST('/user/like/list')
  @FormUrlEncoded()
  Future<BaseResult<List<JokeDetailEntity>>> getLikeJokeList(
      @Field() String page);


  /// 获取登录验证码
  @POST('/user/login/get_code')
  @FormUrlEncoded()
  Future<BaseResult<dynamic>> getLoginVerifyCode(
      @Field() String phone);

  /// 根据验证码登陆
  @POST('/user/login/code')
  @FormUrlEncoded()
  Future<BaseResult<LoginEntity>> loginByCode(
      @Field() String code, @Field() String phone);

  /// 获取用户信息
  @POST('/user/info')
  Future<BaseResult<UserInfoEntity>> getUserInfo();
}
