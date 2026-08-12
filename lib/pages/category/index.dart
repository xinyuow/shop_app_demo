import 'package:flutter/material.dart';

/// 分类视图
///
/// @author mxy
/// @date 2026/8/11
class CategoryView extends StatefulWidget {
  const CategoryView({super.key});

  @override
  State<CategoryView> createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text("分类"),
    );
  }
}
