import 'package:flutter/material.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 分类组件
///
/// @author mxy
/// @date 2026/8/11
class HmCategory extends StatefulWidget {
  final List<CategoryItem> categoryList;
  const HmCategory({super.key, required this.categoryList});

  @override
  State<HmCategory> createState() => _HmCategoryState();
}

class _HmCategoryState extends State<HmCategory> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: ListView.builder(
        itemCount: widget.categoryList.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          // 从分类列表中获取当前分类
          CategoryItem category = widget.categoryList[index];
          return Container(
            height: 50,
            width: 100,
            alignment: Alignment.center,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 232, 234),
              borderRadius: BorderRadius.circular(40),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.network(category.picture, width: 30, height: 30,),
                Text(category.name, style: TextStyle(color: Colors.black, fontSize: 12),),
              ],
            ),
          );
        },
      ),
    );
  }
}
