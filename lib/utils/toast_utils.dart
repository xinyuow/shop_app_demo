import 'package:flutter/material.dart';

/// 小提示工具
///
/// @author mxy
/// @date 2026/8/12
class ToastUtils {
  // 是否显示加载提示
  static bool showLoading = false;

  static void showToast(BuildContext context, String? message) {
    if (ToastUtils.showLoading) {
      return;
    }
    ToastUtils.showLoading = true;
    Future.delayed(Duration(seconds: 3), () {
      ToastUtils.showLoading = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        width: 180,
        // 设置成浮动模式
        behavior: SnackBarBehavior.floating,
        // 设置显示时间
        duration: Duration(seconds: 3),
        shape: RoundedRectangleBorder(
          // 设置圆角
          borderRadius: BorderRadius.circular(30),
        ),
        content: Text(message ?? "加载成功", textAlign: TextAlign.center,),
      ),
    );
  }
}
