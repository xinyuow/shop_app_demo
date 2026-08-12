import 'package:shop_app_demo/constants/index.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Token管理器
///
/// @author mxy
/// @date 2026/8/12
class TokenManager {
  // 返回持久化对象的实例对象
  Future<SharedPreferences> _getInstance(){
    return SharedPreferences.getInstance();
  }

  // 私有的Token变量
  String _token = "";

  // 初始化Token
  Future<void> init() async {
    final prefs = await _getInstance();
    _token = prefs.getString(GlobalConstants.tokenKey) ?? "";
  }

  // 设置Token
  Future<void> setToken(String token) async {
    final prefs = await _getInstance();
    // token持久化，写入磁盘
    prefs.setString(GlobalConstants.tokenKey, token);
    _token = token;
  }

  // 获取Token - 同步
  String getToken() {
    return _token;
  }

  // 移除Token
  Future<void> removeToken() async {
    final prefs = await _getInstance();
    // 从磁盘移除Token
    prefs.remove(GlobalConstants.tokenKey);
    // 从内存中移除Token
    _token = "";
  }
}

/// 单例对象
final tokenManager = TokenManager();
