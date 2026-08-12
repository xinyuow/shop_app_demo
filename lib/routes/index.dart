import 'package:flutter/material.dart';
import 'package:shop_app_demo/pages/login/index.dart';
import 'package:shop_app_demo/pages/main/index.dart';

/// 管理路由返回根级组件
///
/// @author mxy
/// @date 2026/8/11
Widget getRootWidget () {
  return MaterialApp(
    // 命名路由
    initialRoute: "/",
    routes: getRootRoutes(),
  );
}

// 返回路由配置
Map<String, Widget Function(BuildContext)> getRootRoutes () {
  return {
    "/" : (context) => MainPage(),
    "/login" : (context) => LoginPage(),
  };
}
