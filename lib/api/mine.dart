import 'package:shop_app_demo/constants/index.dart';
import 'package:shop_app_demo/utils/dio_request.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 我的相关请求的API封装
/// 封装请求API，并解构返回的业务数据结构
///
/// @author mxy
/// @date 2026/8/12

// 获取猜你喜欢
Future<GoodsDetailsItems> getGuessListApi(Map<String, dynamic> params) async {
  return GoodsDetailsItems.fromJSON(
    await dioRequest.get(ApiConstants.guessList, params: params),
  );
}
