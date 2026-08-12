import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_demo/api/user.dart';
import 'package:shop_app_demo/stores/token_manager.dart';
import 'package:shop_app_demo/stores/user_controller.dart';
import 'package:shop_app_demo/utils/loading_dialog.dart';
import 'package:shop_app_demo/utils/toast_utils.dart';

/// 登录页
///
/// @author mxy
/// @date 2026/8/11
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  // 寻找User对象
  final UserController _userController = Get.find();

  Widget _buildPhoneTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "请输入手机号";
        }
        if (!RegExp(r"^1[3-9]\d{9}$").hasMatch(value)) {
          return "请输入正确的手机号";
          // account：13200000001~13200000010
          // pwd：123456
        }
        return null;
      },
      controller: _phoneController,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20),
        hintText: "请输入手机号",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Widget _buildCodeTextField() {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "请输入验证码";
        }
        if (!RegExp(r"^[a-zA-Z0-9_]{6,16}$").hasMatch(value)) {
          return "请输入6-16位的字母数字或者下划线";
        }
        return null;
      },
      controller: _codeController,
      obscureText: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.only(left: 20),
        hintText: "请输入验证码",
        fillColor: const Color.fromRGBO(243, 243, 243, 1),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(25),
        ),
      ),
    );
  }

  Future<void> _login() async {
    try {
      // 展示加载弹窗
      LoadingDialog.show(context, message: "登录中...");

      final res = await loginAPI({
        "account": _phoneController.text,
        "password": _codeController.text,
      });
      _userController.updateUserInfo(res);
      // 写入Token到磁盘
      tokenManager.setToken(res.token);

      ToastUtils.showToast(context, "登录成功");
      // 返回上个页面
      Navigator.of(context).pop();
    } catch (e) {
      ToastUtils.showToast(context, (e as DioException).message);
    } finally {
      // 关闭加载弹窗
      LoadingDialog.hide(context);
    }
  }

  bool _isChecked = false;
  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          if (_key.currentState!.validate()) {
            if (_isChecked) {
              _login();
            } else {
              ToastUtils.showToast(context, "请勾选用户协议");
            }
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: const Text(
          "登录",
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: Colors.black,
          checkColor: Colors.white,
          onChanged: (bool? value) {
            setState(() {
              _isChecked = value ?? false;
            });
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          side: const BorderSide(color: Colors.grey, width: 2.0),
        ),

        const Text.rich(
          TextSpan(
            children: [
              TextSpan(text: "我已阅读并同意"),
              TextSpan(
                text: "《用户协议》",
                style: TextStyle(color: Colors.blue),
              ),
              TextSpan(text: "和"),
              TextSpan(
                text: "《隐私政策》",
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHeader() {
    return const Row(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Text(
            "账号密码登录",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  // 校验登录表单
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("登录", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: _key,
        child: Container(
          child: Column(
            children: [
              const SizedBox(height: 20),
              _buildHeader(),
              const SizedBox(height: 30),
              _buildPhoneTextField(),
              const SizedBox(height: 20),
              _buildCodeTextField(),
              const SizedBox(height: 30),
              _buildLoginButton(),
              const SizedBox(height: 20),
              _buildCheckbox(),
            ],
          ),
        ),
      ),
    );
  }
}