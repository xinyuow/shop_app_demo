import 'package:flutter/material.dart';

/// 购物车视图
///
/// @author mxy
/// @date 2026/8/11
class CartView extends StatefulWidget {
  const CartView({super.key});

  @override
  State<CartView> createState() => _CartViewState();
}

class _CartViewState extends State<CartView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text("购物车"),
    );
  }
}
