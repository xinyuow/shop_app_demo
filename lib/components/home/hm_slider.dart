import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 轮播图组件
///
/// @author mxy
/// @date 2026/8/11
class HmSlider extends StatefulWidget {
  final List<BannerItem> bannerList;

  const HmSlider({super.key, required this.bannerList});

  @override
  State<HmSlider> createState() => _HmSliderState();
}

class _HmSliderState extends State<HmSlider> {
  // 轮播图跳转控制器
  final CarouselSliderController _controller = CarouselSliderController();

  // 当前命中轮播图的索引
  int _currentIndex = 0;

  // 返回轮播图插件
  Widget _getSlider() {
    // 在flutter中获取屏幕宽度的方法
    final double screenWidth = MediaQuery.of(context).size.width;
    // 利用轮播图插件
    return CarouselSlider(
      items: List.generate(widget.bannerList.length, (int index) {
        return Image.network(
          widget.bannerList[index].imgUrl,
          fit: BoxFit.cover,
          width: screenWidth,
        );
      }),
      options: CarouselOptions(
        // 轮播图占比，默认是0.8
        viewportFraction: 1,
        // 自动播放，默认是3秒钟
        autoPlay: true,
        // 设置轮播图高度，默认是300
        height: 300,
        // 自定义自动播放的时间间隔
        autoPlayInterval: Duration(seconds: 2),
        onPageChanged: (int index, CarouselPageChangedReason reason) {
          _currentIndex = index;
          setState(() {});
        },
      ),
      // 绑定控制器对象
      carouselController: _controller,
    );
  }

  // 获取搜索框
  Widget _getSearch() {
    return Positioned(
      top: 10,
      left: 0,
      right: 0,
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: 50,
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.4),
            borderRadius: BorderRadius.circular(25),
          ),
          child: const Text(
            "搜索...",
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ),
    );
  }

  // 返回轮播图指示灯导航部件
  Widget _getDots() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 10,
      child: SizedBox(
        height: 40,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.bannerList.length, (int index) {
            return GestureDetector(
              onTap: () {
                _controller.jumpToPage(index);
              },
              // 带动画效果的Container
              child: AnimatedContainer(
                height: 6,
                // 设置导航条长度
                width: index == _currentIndex ? 40 : 20,
                // 设置左右对称的外部间距
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  // 设置导航条选中颜色
                  color: index == _currentIndex
                      ? Colors.white
                      : Color.fromRGBO(0, 0, 0, 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
                // 切换动画持续时间
                duration: Duration(milliseconds: 300),
              ),
            );
          }),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Stack -> 轮播图、搜索框、指示灯导航
    return Stack(children: [_getSlider(), _getSearch(), _getDots()]);
  }
}
