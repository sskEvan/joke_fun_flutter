/// 用户关注状态改变事件
class AttentionChangeEvent {
  String? userId;
  bool? attention;

  AttentionChangeEvent({this.userId, this.attention = false});
}
