import 'package:flutter/material.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 推荐组件
///
/// @author mxy
/// @date 2026/8/11
class HmSuggestion extends StatefulWidget {
  final SpecialRecommendResult specialRecommendResult;

  const HmSuggestion({super.key, required this.specialRecommendResult});

  @override
  State<HmSuggestion> createState() => _HmSuggestionState();
}

class _HmSuggestionState extends State<HmSuggestion> {
  // 取特惠推荐结果的前三条
  List<GoodsItem> _getDisplayItems() {
    if (widget.specialRecommendResult.subTypes.isEmpty) {
      return [];
    }
    return widget.specialRecommendResult.subTypes.first.goodsItems.items
        .take(3)
        .toList();
  }

  // 构建头部
  Widget _buildHeader() {
    return Row(
      children: [
        Text(
          widget.specialRecommendResult.title,
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(width: 10),
        const Text(
          "精选攻略",
          style: TextStyle(
            color: Colors.deepOrangeAccent,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }

  // 构建左侧
  Widget _buildLeft() {
    return Container(
      width: 100,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          // 从项目中获取
          image: AssetImage("lib/assets/home_cmd_inner.png"),
          // 填充满
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // 构建右侧
  List<Widget> _buildRight() {
    List<GoodsItem> items = _getDisplayItems();
    return List.generate(items.length, (int index) {
      return Column(
        children: [
          // ClipRRect 可以包裹子元素、裁剪图片、设置圆角
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              items[index].picture,
              width: 100,
              height: 140,
              fit: BoxFit.cover,
              // 如果网络图片加载失败，则显示默认图片
              errorBuilder: (context, error, stackTrace) {
                return Image.asset("lib/assets/home_cmd_inner.png");
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
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        // height: 300,
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.blue,
          // 设置背景图片
          image: DecorationImage(
            // 从项目中获取
            image: AssetImage("lib/assets/home_cmd_sm.png"),
            // 填充满
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildHeader(),
            SizedBox(height: 10),
            Row(
              children: [
                _buildLeft(),
                Expanded(
                  child: Row(
                    // 分布均分
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: _buildRight(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
