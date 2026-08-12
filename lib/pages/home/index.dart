import 'package:flutter/material.dart';
import 'package:shop_app_demo/api/home.dart';
import 'package:shop_app_demo/components/home/hm_category.dart';
import 'package:shop_app_demo/components/home/hm_hot.dart';
import 'package:shop_app_demo/components/home/hm_more_list.dart';
import 'package:shop_app_demo/components/home/hm_slider.dart';
import 'package:shop_app_demo/components/home/hm_suggestion.dart';
import 'package:shop_app_demo/utils/toast_utils.dart';
import 'package:shop_app_demo/view_models/home.dart';

/// 主页视图
///
/// @author mxy
/// @date 2026/8/11
class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // 轮播图数据
  List<BannerItem> _bannerList = [];

  // 分类数据
  List<CategoryItem> _categoryList = [];

  // 特惠推荐数据
  SpecialRecommendResult _specialRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 爆款推荐数据
  SpecialRecommendResult _hotRecommendResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 一站买全数据
  SpecialRecommendResult _allInResult = SpecialRecommendResult(
    id: "",
    title: "",
    subTypes: [],
  );

  // 推荐列表
  List<GoodsDetailItem> _recommendList = [];

  // 获取滚动容器的内容
  List<Widget> _getScrollChildren() {
    return [
      // 放置轮播图
      SliverToBoxAdapter(child: HmSlider(bannerList: _bannerList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 放置分类
      SliverToBoxAdapter(child: HmCategory(categoryList: _categoryList)),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 放置推荐
      SliverToBoxAdapter(
        child: HmSuggestion(specialRecommendResult: _specialRecommendResult),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 放置热门商品
      SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: Axis.horizontal,
            children: [
              Expanded(
                child: HmHot(
                  hotRecommendResult: _hotRecommendResult,
                  type: "vogue",
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: HmHot(hotRecommendResult: _allInResult, type: "stop"),
              ),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(child: SizedBox(height: 10)),
      // 放置滚动列表
      HmMoreList(recommendList: _recommendList),
    ];
  }

  @override
  void initState() {
    super.initState();
    // 监听滚动到底部事件
    _registerScrollBottomListenerEvent();
    // 刷新数据
    Future.microtask(() {
      _paddingTop = 100;
      _refreshKey.currentState?.show();
    });
  }

  // 监听滚动到底部事件
  void _registerScrollBottomListenerEvent() {
    _scrollController.addListener(() {
      // 滚动距离大于等于最大滚动距离时，加载更多数据
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        // 加载更多数据
        _getRecommendList();
      }
    });
  }

  // 获取轮播图列表
  Future<void> _getBannerList() async {
    _bannerList = await getBannerListApi();
  }

  // 获取分类列表
  Future<void> _getCategoryList() async {
    _categoryList = await getCategoryListApi();
  }

  // 获取特惠推荐列表
  Future<void> _getSpecialRecommendList() async {
    _specialRecommendResult = await getSpecialRecommendListApi();
  }

  // 获取爆款推荐列表
  Future<void> _getHotRecommendList() async {
    _hotRecommendResult = await getHotRecommendListApi();
  }

  // 获取一站买全列表
  Future<void> _getAllInList() async {
    _allInResult = await getAllInListApi();
  }

  // 获取推荐列表
  Future<void> _getRecommendList() async {
    if (_isLoading || !_hasMore) {
      // 当前正在加载更多数据，或者没有更多数据了，不重复加载
      return;
    }
    _isLoading = true;
    // 每页加载8条数据
    int requestPage = _page * 8;
    _recommendList = await getRecommendListApi({"limit": requestPage});
    _isLoading = false;
    setState(() {});

    // 检查是否还有更多数据
    _hasMore = _recommendList.length >= requestPage;

    // 页码增加1
    _page++;
  }

  // 滚动控制器
  final ScrollController _scrollController = ScrollController();

  // 页码
  int _page = 1;

  // 当前是否正在加载更多数据
  bool _isLoading = false;

  // 是否还有更多数据
  bool _hasMore = true;

  // 下拉
  Future<void> _onRefresh() async {
    // 重置数据
    _page = 1;
    _isLoading = false;
    _hasMore = true;

    // 刷新数据
    await _getBannerList();
    await _getCategoryList();
    await _getSpecialRecommendList();
    await _getHotRecommendList();
    await _getAllInList();
    await _getRecommendList();

    // 刷新完成，显示刷新成功提示
    ToastUtils.showToast(context, "刷新成功");
    // 刷新完成，重置顶部间距
    _paddingTop = 0;
    setState(() {});
  }

  // 刷新指示器状态键
  final GlobalKey<RefreshIndicatorState> _refreshKey =
      GlobalKey<RefreshIndicatorState>();
  // 刷新指示器顶部间距
  double _paddingTop = 0;

  @override
  Widget build(BuildContext context) {
    // 刷新指示器
    return RefreshIndicator(
      key: _refreshKey,
      onRefresh: _onRefresh,
      // 增加动画效果
      child: AnimatedContainer(
        padding: EdgeInsets.only(top: _paddingTop),
        duration: Duration(milliseconds: 300),
        child: CustomScrollView(
          slivers: _getScrollChildren(),
          controller: _scrollController,
        ),
      ),
    );
  }
}
