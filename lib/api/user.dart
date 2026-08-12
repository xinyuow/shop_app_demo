import 'package:shop_app_demo/constants/index.dart';
import 'package:shop_app_demo/utils/dio_request.dart';
import 'package:shop_app_demo/view_models/user.dart';

/// 用户相关请求的API封装
/// 封装请求API，并解构返回的业务数据结构
///
/// @author mxy
/// @date 2026/8/12

// 执行登录请求
Future<UserInfo> loginAPI(Map<String, dynamic> data) async {
  return UserInfo.fromJSON(
    await dioRequest.post(ApiConstants.login, data: data),
  );
}

// 获取用户信息
Future<UserInfo> getUserInfoAPI() async {
  return UserInfo.fromJSON(await dioRequest.get(ApiConstants.userInfo));
}
