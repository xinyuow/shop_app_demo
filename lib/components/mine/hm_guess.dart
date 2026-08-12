import 'package:flutter/material.dart';

/// 猜你喜欢组件
///
/// @author mxy
/// @date 2026/8/12
class HmGuess extends SliverPersistentHeaderDelegate {
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      alignment: Alignment.center,
      child: const Text("猜你喜欢", style: TextStyle(fontSize: 20),),
    );
  }

  @override
  double get maxExtent => 60;

  @override
  double get minExtent => 60;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
