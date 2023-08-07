import 'package:agro_millets/colors.dart';
import 'package:agro_millets/core/cart/application/cart_manager.dart';
import 'package:agro_millets/core/cart/application/cart_provider.dart';
import 'package:agro_millets/core/home/application/home_manager.dart';
import 'package:agro_millets/core/home/presentation/widgets/agro_item.dart';
import 'package:agro_millets/globals.dart';
import 'package:agro_millets/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  late CartManager cartManager;

  @override
  void initState() {
    cartManager = CartManager(context, ref);
    super.initState();
  }

  @override
  void dispose() {
    cartManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Consumer(
              builder: (context, ref, child) {
                List<CartItem> cart = ref.watch(cartProvider).getCart();

                return MasonryGridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 30.0,
                  ),
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  itemCount: cart.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: getItemById(cart[index].item),
                      builder: (context, snapshot) {
                        if (snapshot.hasData && snapshot.data != null) {
                          return AgroItem(
                            index: index,
                            item: snapshot.data!,
                            showAddCartIcon: false,
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text("Error Occured"),
                          );
                        }
                        return const Center(
                          // child: CircularProgressIndicator(),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
