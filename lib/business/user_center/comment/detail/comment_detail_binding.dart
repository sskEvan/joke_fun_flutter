import 'package:get/get.dart';

import 'comment_detail_logic.dart';

class CommentDetailBinding extends Bindings {
  final String tag;

  CommentDetailBinding({required this.tag});

  @override
  void dependencies() {
    Get.lazyPut(() => CommentDetailLogic(), tag: tag);
  }
}
