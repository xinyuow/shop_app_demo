import 'package:dio/dio.dart';
import 'package:shop_app_demo/constants/index.dart';
import 'package:shop_app_demo/stores/token_manager.dart';

/// Dio工具类
///
/// @author mxy
/// @date 2026/8/11
class DioRequest {
  // 内部Dio实例
  final _dio = Dio();

  DioRequest() {
    // 单个赋值。API基础地址
    _dio.options.baseUrl = GlobalConstants.baseUrl;
    // 多个连续赋值。连接超时、发送超时、接收超时
    _dio.options
      ..connectTimeout = Duration(seconds: GlobalConstants.timeout)
      ..sendTimeout = Duration(seconds: GlobalConstants.timeout)
      ..receiveTimeout = Duration(seconds: GlobalConstants.timeout);

    // 拦截器
    _addInterceptor();
  }

  // 注册拦截器
  void _addInterceptor() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        // 请求拦截器
        onRequest: (request, handler) {
          // 注入Token
          if (tokenManager.getToken().isNotEmpty) {
            request.headers = {
              "Authorization": "Bearer ${tokenManager.getToken()}"
            };
          }

          // 放行
          handler.next(request);
          // 拦截
          // handler.reject(error);
        },
        // 响应拦截器
        onResponse: (response, handler) {
          // 判断HTTP状态码
          if (response.statusCode! >= 200 && response.statusCode! < 300) {
            // 放行
            handler.next(response);
            return;
          } else {
            // 发生异常，抛出异常
            handler.reject(
              DioException(requestOptions: response.requestOptions),
            );
          }
        },
        // 错误拦截器
        onError: (error, handler) {
          handler.reject(
            DioException(
              requestOptions: error.requestOptions,
              message: error.response?.data["msg"] ?? "加载数据失败",
            ),
          );
        },
      ),
    );
  }

  // get请求
  Future<dynamic> get(String url, {Map<String, dynamic>? params}) {
    return _handleResponse(_dio.get(url, queryParameters: params));
  }

  // post请求
  Future<dynamic> post(String url, {Map<String, dynamic>? data}) {
    return _handleResponse(_dio.post(url, data: data));
  }

  // 解构业务响应结果
  Future<dynamic> _handleResponse(Future<Response<dynamic>> task) async {
    try {
      Response<dynamic> res = await task;
      final data = res.data as Map<String, dynamic>;
      if (data["code"] == GlobalConstants.successCode) {
        return data["result"];
      } else {
        // 抛出异常
        throw DioException(
          requestOptions: res.requestOptions,
          message: data["msg"] ?? "加载数据失败",
        );
      }
    } catch (e) {
      // 不改变原来抛出的异常
      rethrow;
    }
  }
}

/// 单例对象
final dioRequest = DioRequest();
