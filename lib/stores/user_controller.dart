import 'package:get/get.dart';
import 'package:shop_app_demo/view_models/user.dart';

/// 用户信息共享控制器
///
/// @author mxy
/// @date 2026/8/12
class UserController extends GetxController {
  // obs结尾，表明这是一个可观察的变量，当变量值改变时，会自动触发更新
  var user = UserInfo.fromJSON({}).obs;
  // 想要取值的话，直接使用user.value即可

  void updateUserInfo(UserInfo newUser) {
    user.value = newUser;
  }
}
