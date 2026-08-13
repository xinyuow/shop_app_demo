import 'package:flutter/material.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 爆款推荐组件
///
/// @author mxy
/// @date 2026/8/11
class HmHot extends StatefulWidget {
  // 热榜推荐
  final SpecialRecommendResult hotRecommendResult;

  // 类型
  final String type;

  const HmHot({
    super.key,
    required this.hotRecommendResult,
    required this.type,
  });

  @override
  State<HmHot> createState() => _HmHotState();
}

class _HmHotState extends State<HmHot> {
  // 取推荐结果的前两条
  List<GoodsItem> _getDisplayItems() {
    if (widget.hotRecommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.hotRecommendResult.subTypes.first.goodsItems.items
        .take(2)
        .toList();
  }

  // 构建头部
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.type == "vogue" ? "爆款推荐" : "一站买全",
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        Text(
          widget.type == "vogue" ? "精心优选" : "最受欢迎",
          style: TextStyle(
            color: Colors.yellow,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // 构建结果
  List<Widget> _getChildrenList() {
    List<GoodsItem> items = _getDisplayItems();
    return List.generate(items.length, (int index) {
      return Expanded(
        child: Column(
          children: [
            // ClipRRect 可以包裹子元素、裁剪图片、设置圆角
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                items[index].picture,
                height: 100,
                fit: BoxFit.cover,
                // 如果网络图片加载失败，则显示默认图片
                errorBuilder: (context, error, stackTrace) {
                  return Image.asset(
                    "lib/assets/home_cmd_inner.png",
                    fit: BoxFit.cover,
                    height: 100,
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                "￥${items[index].price}",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _getChildrenList(),
            ),
          ],
        ),
      ),
    );
  }
}
