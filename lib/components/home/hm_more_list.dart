import 'package:flutter/material.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 商品列表组件
///
/// @author mxy
/// @date 2026/8/11
class HmMoreList extends StatefulWidget {
  // 商品列表数据
  final List<GoodsDetailItem> recommendList;

  const HmMoreList({super.key, required this.recommendList});

  @override
  State<HmMoreList> createState() => _HmMoreListState();
}

class _HmMoreListState extends State<HmMoreList> {
  Widget _getChildren(int index) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          // 宽高比组件，保持图片比例
          child: AspectRatio(
            // 设置宽高比，1为正方形
            aspectRatio: 1.0,
            child: Image.network(
              widget.recommendList[index].picture,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  "lib/assets/home_cmd_inner.png",
                  fit: BoxFit.cover,
                );
              },
            ),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            widget.recommendList[index].name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text.rich(
                TextSpan(
                  text: "¥${widget.recommendList[index].price}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                  children: [
                    TextSpan(text: ""),
                    TextSpan(
                      text: widget.recommendList[index].price,
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                        decoration: TextDecoration.lineThrough,
                      ),
                    )
                  ],
                ),
              ),
              Text(
                "¥${widget.recommendList[index].payCount}人付款",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: widget.recommendList.length,
      // 网格是两列
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: _getChildren(index),
        );
      },
    );
  }
}
