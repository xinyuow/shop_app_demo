import 'package:flutter/material.dart';

/// 加载弹窗工具类
///
/// @author mxy
/// @date 2026/8/12
class LoadingDialog {
  // 展示加载弹窗
  static void show(BuildContext context, {String? message = "加载中..."}) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // 转圈加载动画
                  CircularProgressIndicator(),
                  SizedBox(height: 10),
                  // 加载提示信息
                  Text(message ?? "加载中...", style: const TextStyle(fontSize: 16)),
                ],
              ),
            )
          ),
        );
      },
    );
  }

  // 关闭加载弹窗
  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
