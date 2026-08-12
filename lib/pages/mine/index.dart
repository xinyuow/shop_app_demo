import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_app_demo/api/mine.dart';
import 'package:shop_app_demo/components/home/hm_more_list.dart';
import 'package:shop_app_demo/components/mine/hm_guess.dart';
import 'package:shop_app_demo/stores/token_manager.dart';
import 'package:shop_app_demo/stores/user_controller.dart';
import 'package:shop_app_demo/view_models/home.dart';
import 'package:shop_app_demo/view_models/user.dart';

/// 我的视图
///
/// @author mxy
/// @date 2026/8/11
class MineView extends StatefulWidget {
  const MineView({super.key});

  @override
  State<MineView> createState() => _MineViewState();
}

class _MineViewState extends State<MineView> {
  // put用户信息控制器
  final UserController _userController = Get.find();

  // 退出登录
  Widget _getLogout() {
    return _userController.user.value.id.isNotEmpty
        ? Expanded(
            child: GestureDetector(
              onTap: () {
                // 弹出提示弹窗
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      // 提示标题
                      title: const Text("提示"),
                      // 提示内容
                      content: const Text("确认退出登录吗？"),
                      // 行为
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("取消"),
                        ),
                        TextButton(
                          onPressed: () async {
                            // 删除Token
                            await tokenManager.removeToken();
                            _userController.updateUserInfo(
                              UserInfo.fromJSON({}),
                            );
                            Navigator.pop(context);
                          },
                          child: const Text("确认"),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("退出", textAlign: TextAlign.end),
            ),
          )
        : Text("");
  }

  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFFFFF2E8), Color(0xFFFDF6F1)],
        ),
      ),
      padding: const EdgeInsets.only(left: 20, right: 40, top: 80, bottom: 20),
      child: Row(
        children: [
          Obx(() {
            return CircleAvatar(
              radius: 26,
              backgroundImage: _userController.user.value.id.isNotEmpty
                  ? NetworkImage(_userController.user.value.avatar)
                  : AssetImage("lib/assets/goods_avatar.png"),
              backgroundColor: Colors.white,
            );
          }),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(() {
                  // Obx中必须得有可检测的响应式数据
                  return GestureDetector(
                    onTap: () {
                      if (_userController.user.value.id.isEmpty) {
                        // 未登录，跳转到登录页
                        Navigator.pushNamed(context, '/login');
                      }
                    },
                    child: Text(
                      _userController.user.value.id.isNotEmpty
                          ? _userController.user.value.account
                          : "立即登录",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          Obx(() {
            // 退出登录按钮
            return _getLogout();
          }),
        ],
      ),
    );
  }

  Widget _buildVipCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 240, 192, 155),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
        ),
        child: Row(
          children: [
            Image.asset("lib/assets/ic_user_vip.png", width: 30, height: 30),
            const SizedBox(width: 10),
            const Expanded(
              child: Text(
                '升级商城会员，尊享无限免邮',
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromRGBO(126, 43, 26, 1),
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromRGBO(126, 43, 26, 1),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: const Text('立即开通', style: TextStyle(fontSize: 12)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    Widget item(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(label, style: const TextStyle(fontSize: 12)),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            item("lib/assets/ic_user_collect.png", "我的收藏"),
            item("lib/assets/ic_user_history.png", "我的足迹"),
            item("lib/assets/ic_user_unevaluated.png", "我的客服"),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderModule() {
    Widget orderItem(String pic, String label) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(pic, width: 30, height: 30, fit: BoxFit.cover),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 2,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "订单管理",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  orderItem("lib/assets/ic_user_order.png", "我的订单"),
                  orderItem("lib/assets/ic_user_obligation.png", "待付款"),
                  orderItem("lib/assets/ic_user_unreceived.png", "待发货"),
                  orderItem("lib/assets/ic_user_unshipped.png", "待收货"),
                  orderItem("lib/assets/ic_user_unevaluated.png", "待评价"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 猜你喜欢商品列表
  List<GoodsDetailItem> _goodsList = [];

  // 分页请求参数
  Map<String, dynamic> _params = {"page": 1, "pageSize": 10};

  // 滚动
  final ScrollController _scrollController = ScrollController();

  // 是否正在加载更多数据
  bool _isLoading = false;

  // 是否还有更多数据
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _getGuessList();
    _registerEvent();
  }

  // 获取猜你喜欢
  void _getGuessList() async {
    if (_isLoading || !_hasMore) {
      // 正在加载更多数据或没有更多数据了
      return;
    }

    _isLoading = true;
    final res = await getGuessListApi(_params);
    _isLoading = false;
    // 追加数据
    _goodsList.addAll(res.items);
    setState(() {});

    // 检查是否还有更多数据
    if (_params["page"] >= res.pages) {
      _hasMore = false;
      return;
    }
    // 更新分页参数
    _params["page"]++;
  }

  // 注册滚动事件监听
  void _registerEvent() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // 滚动到最底部，加载更多数据
        _getGuessList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      slivers: [
        SliverToBoxAdapter(child: _buildHeader()),
        SliverToBoxAdapter(child: _buildVipCard()),
        SliverToBoxAdapter(child: _buildQuickActions()),
        SliverToBoxAdapter(child: _buildOrderModule()),
        // pinned 表示固定在顶部，不随内容滚动
        SliverPersistentHeader(delegate: HmGuess(), pinned: true),
        // 猜你喜欢
        HmMoreList(recommendList: _goodsList),
      ],
    );
  }
}
