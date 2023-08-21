import 'package:flutter/cupertino.dart';

class VisibleIndexScrollDelegate extends SliverChildBuilderDelegate {
  Function(int firstIndex, int lastIndex, double leadingScrollOffset, double trailingScrollOffset)? scrollCallback;
  Function(int firstIndex, int lastIndex)? scrollCallback2;

  VisibleIndexScrollDelegate(builder,
      {required int itemCount, this.scrollCallback, this.scrollCallback2})
      : super(builder, childCount: itemCount);

  @override
  double? estimateMaxScrollOffset(int firstIndex, int lastIndex,
      double leadingScrollOffset, double trailingScrollOffset) {
    // if (scrollCallback != null) {
    //   scrollCallback!(firstIndex, lastIndex, leadingScrollOffset, trailingScrollOffset);
    // }
    return super.estimateMaxScrollOffset(
        firstIndex, lastIndex, leadingScrollOffset, trailingScrollOffset);
  }

  @override
  void didFinishLayout(int firstIndex, int lastIndex) {
    super.didFinishLayout(firstIndex, lastIndex);
    if(scrollCallback2 != null) {
      scrollCallback2!(firstIndex, lastIndex);
    }
  }
}
