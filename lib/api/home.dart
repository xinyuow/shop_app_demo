import 'package:shop_app_demo/constants/index.dart';
import 'package:shop_app_demo/utils/dio_request.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 主页相关请求的API封装
/// 封装请求API，并解构返回的业务数据结构
///
/// @author mxy
/// @date 2026/8/11

/// 获取轮播图列表
Future<List<BannerItem>> getBannerListApi() async {
  // 请求并处理返回结果
  return ((await dioRequest.get(ApiConstants.bannerList)) as List).map((item) {
    return BannerItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

/// 获取分类列表
Future<List<CategoryItem>> getCategoryListApi() async {
  // 请求并处理返回结果
  return ((await dioRequest.get(ApiConstants.categoryList)) as List).map((
    item,
  ) {
    return CategoryItem.formJSON(item as Map<String, dynamic>);
  }).toList();
}

/// 获取特惠推荐
Future<SpecialRecommendResult> getSpecialRecommendListApi() async {
  // 请求并处理返回结果
  return SpecialRecommendResult.fromJSON(
    await dioRequest.get(ApiConstants.specialRecommendList),
  );
}

/// 获取爆款推荐
Future<SpecialRecommendResult> getHotRecommendListApi() async {
  // 请求并处理返回结果
  return SpecialRecommendResult.fromJSON(
    await dioRequest.get(ApiConstants.hotRecommendList),
  );
}

/// 获取一站买全
Future<SpecialRecommendResult> getAllInListApi() async {
  // 请求并处理返回结果
  return SpecialRecommendResult.fromJSON(
    await dioRequest.get(ApiConstants.allInList),
  );
}

/// 获取推荐列表
Future<List<GoodsDetailItem>> getRecommendListApi(
  Map<String, dynamic> params,
) async {
  // 请求并处理返回结果
  return ((await dioRequest.get(ApiConstants.recommendList, params: params))
          as List)
      .map((item) {
        return GoodsDetailItem.fromJSON(item as Map<String, dynamic>);
      })
      .toList();
}
