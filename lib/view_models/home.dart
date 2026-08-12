/// 首页相关的数据模型
///
/// @author mxy
/// @date 2026/8/11
///
/// 每个轮播图的具体类型
class BannerItem {
  String id;
  String imgUrl;

  BannerItem({required this.id, required this.imgUrl});

  // Flutter必须强制转化，没有隐式转化。扩展一个工厂函数，一般用factory声明，用来创建实例对象
  factory BannerItem.formJSON(Map<String, dynamic> json) {
    // 必须返回一个 BannerItem 对象
    return BannerItem(id: json["id"] ?? "", imgUrl: json["imgUrl"] ?? "");
  }
}

/// 每个分类的具体类型
class CategoryItem {
  String id;
  String name;
  String picture;
  List<CategoryItem> children;

  CategoryItem({
    required this.id,
    required this.name,
    required this.picture,
    this.children = const [],
  });

  factory CategoryItem.formJSON(Map<String, dynamic> json) => CategoryItem(
    id: json["id"],
    name: json["name"],
    picture: json["picture"],
    children: json["children"] == null
        ? const []
        : (json["children"] as List)
              .map((e) => CategoryItem.formJSON(e as Map<String, dynamic>))
              .toList(),
  );
}

/// 特惠推荐 - 结果
class SpecialRecommendResult {
  String id;
  String title;
  List<SubType> subTypes;

  SpecialRecommendResult({
    required this.id,
    required this.title,
    required this.subTypes,
  });

  factory SpecialRecommendResult.fromJSON(Map<String, dynamic> json) {
    return SpecialRecommendResult(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      subTypes: (json["subTypes"] as List)
          .map((e) => SubType.fromJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 特惠推荐 - 子类型
class SubType {
  String id;
  String title;
  GoodsItems goodsItems;

  SubType({required this.id, required this.title, required this.goodsItems});

  factory SubType.fromJSON(Map<String, dynamic> json) {
    return SubType(
      id: json["id"] ?? "",
      title: json["title"] ?? "",
      goodsItems: GoodsItems.fromJSON(
        json["goodsItems"] as Map<String, dynamic>,
      ),
    );
  }
}

/// 特惠推荐 - 商品分页信息
class GoodsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsItem> items;

  GoodsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsItems.fromJSON(Map<String, dynamic> json) {
    return GoodsItems(
      counts: json["counts"] as int,
      pageSize: json["pageSize"] as int,
      pages: json["pages"] as int,
      page: json["page"] as int,
      items: (json["items"] as List)
          .map((e) => GoodsItem.fromJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
}

/// 特惠推荐 - 商品项
class GoodsItem {
  String id;
  String name;
  String? desc; // 允许为空值
  String price;
  String picture;
  int orderNum;

  GoodsItem({
    required this.id,
    required this.name,
    this.desc,
    required this.price,
    required this.picture,
    required this.orderNum,
  });

  factory GoodsItem.fromJSON(Map<String, dynamic> json) {
    return GoodsItem(
      id: json["id"] ?? "",
      name: json["name"] ?? "",
      desc: json["desc"] as String?,
      // 处理可能为null的描述字段
      price: json["price"] ?? "",
      picture: json["picture"] ?? "",
      orderNum: json["orderNum"] as int,
    );
  }
}

/// 商品详情
class GoodsDetailItem extends GoodsItem {
  int payCount = 0;

  GoodsDetailItem({
    required super.id,
    required super.name,
    required super.desc,
    required super.price,
    required super.picture,
    required super.orderNum,
    required this.payCount,
  });

  // 转化方法
  factory GoodsDetailItem.fromJSON(Map<String, dynamic> json) {
    return GoodsDetailItem(
      id: json["id"]?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      desc: json["desc"]?.toString(),
      price: json["price"]?.toString() ?? "",
      picture: json["picture"]?.toString() ?? "",
      orderNum: int.tryParse(json["orderNum"]?.toString() ?? "0") ?? 0,
      payCount: int.tryParse(json["payCount"]?.toString() ?? "0") ?? 0,
    );
  }
}

/// 猜你喜欢 - 商品分页信息
class GoodsDetailsItems {
  int counts;
  int pageSize;
  int pages;
  int page;
  List<GoodsDetailItem> items;

  GoodsDetailsItems({
    required this.counts,
    required this.pageSize,
    required this.pages,
    required this.page,
    required this.items,
  });

  factory GoodsDetailsItems.fromJSON(Map<String, dynamic> json) {
    return GoodsDetailsItems(
      counts: json["counts"] as int,
      pageSize: json["pageSize"] as int,
      pages: json["pages"] as int,
      page: json["page"] as int,
      items: (json["items"] as List)
          .map((e) => GoodsDetailItem.fromJSON(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
