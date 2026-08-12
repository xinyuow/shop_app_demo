/// 定义全局常量
///
/// @author mxy
/// @date 2026/8/11
class GlobalConstants {
  // API基础地址
  static const String baseUrl = "https://meikou-api.itheima.net";
  // 超时时间，单位：秒
  static const int timeout = 10;
  // 请求成功状态码
  static const String successCode = "1";
  // Token持久化键名
  static const String tokenKey = "hm_shop_token";
}

/// API常量
class ApiConstants {
  // 获取轮播图列表
  static const String bannerList = "/home/banner";
  // 获取分类列表
  static const String categoryList = "/home/category/head";
  // 获取特惠推荐
  static const String specialRecommendList = "/hot/preference";
  // 获取爆款推荐
  static const String hotRecommendList = "/hot/inVogue";
  // 获取一站买全列表
  static const String allInList = "/hot/oneStop";
  // 获取推荐列表
  static const String recommendList = "/home/recommend";
  // 获取猜你喜欢列表
  static const String guessList = "/home/goods/guessLike";
  // 登录 - POST
  static const String login = "/login";
  // 获取用户信息
  static const String userInfo = "/member/profile";
}
