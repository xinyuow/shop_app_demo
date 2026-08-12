import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_demo/api/user.dart';
import 'package:shop_app_demo/pages/cart/index.dart';
import 'package:shop_app_demo/pages/category/index.dart';
import 'package:shop_app_demo/pages/home/index.dart';
import 'package:shop_app_demo/pages/mine/index.dart';
import 'package:shop_app_demo/stores/token_manager.dart';
import 'package:shop_app_demo/stores/user_controller.dart';

/// 首页
///
/// @author mxy
/// @date 2026/8/11
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // 默认导航栏激活的索引
  int _currentIndex = 0;

  // 定义数据，根据数据进行渲染4个导航。一般应用程序的导航是不变的
  final List<Map<String, String>> _tabList = [
    {
      "icon": "lib/assets/ic_public_home_normal.png",
      "active_icon": "lib/assets/ic_public_home_active.png",
      "text": "首页",
    },
    {
      "icon": "lib/assets/ic_public_pro_normal.png",
      "active_icon": "lib/assets/ic_public_pro_active.png",
      "text": "分类",
    },
    {
      "icon": "lib/assets/ic_public_cart_normal.png",
      "active_icon": "lib/assets/ic_public_cart_active.png",
      "text": "购物车",
    },
    {
      "icon": "lib/assets/ic_public_my_normal.png",
      "active_icon": "lib/assets/ic_public_my_active.png",
      "text": "我的",
    },
  ];

  // 返回底部导航栏渲染的分类
  List<BottomNavigationBarItem> _getTabBarWidget() {
    return List.generate(_tabList.length, (index) {
      return BottomNavigationBarItem(
        icon: Image.asset(_tabList[index]["icon"]!, width: 30, height: 30),
        activeIcon: Image.asset(
          _tabList[index]["active_icon"]!,
          width: 30,
          height: 30,
        ),
        label: _tabList[index]["text"],
      );
    });
  }

  // 导航栏切换的视图列表
  List<Widget> _getBodyChildren() {
    return [HomeView(), CategoryView(), CartView(), MineView()];
  }

  @override
  void initState() {
    super.initState();
    // 初始化用户
    _initUser();
  }

  final UserController _userController = Get.put(UserController());
  // 初始化用户
  void _initUser() async {
    // 初始化Token管理器
    await tokenManager.init();
    if (tokenManager.getToken().isNotEmpty) {
      // 有Token，获取用户信息
      _userController.updateUserInfo(await getUserInfoAPI());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 页面主体，使用避开安全区组件
      body: SafeArea(
        child: IndexedStack(
          // 当前页面主体的索引
          index: _currentIndex,
          children: _getBodyChildren(),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        currentIndex: _currentIndex,
        items: _getTabBarWidget(),
        onTap: (int index) {
          // index是当前点击的索引
          _currentIndex = index;
          setState(() {});
        },
      ),
    );
  }
}
