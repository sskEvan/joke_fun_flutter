/// 赞、踩段子动作事件
class JokeLikeActionEvent {
  int? jokesId;
  /// true表示赞段子动作， false表示踩段子动作
  bool isLikeAction;
  bool value;
  JokeLikeActionEvent({this.jokesId, required this.isLikeAction, required this.value});
}