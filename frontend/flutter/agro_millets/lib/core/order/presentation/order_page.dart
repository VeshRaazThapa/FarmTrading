import 'package:agro_millets/core/home/application/home_manager.dart';
import 'package:agro_millets/core/home/application/home_provider.dart';
import 'package:agro_millets/globals.dart';
import 'package:agro_millets/main.dart';
import 'package:agro_millets/models/order_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../data/cache/app_cache.dart';
import '../../home/presentation/widgets/agro_item_order.dart';

class OrderPage extends ConsumerStatefulWidget {
  const OrderPage({super.key});

  @override
  ConsumerState<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends ConsumerState<OrderPage> {
  late HomeManager homeManager;

  @override
  void initState() {
    homeManager = HomeManager(context, ref);
    super.initState();
  }

  @override
  void dispose() {
    homeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Orders"),
      actions: [
          IconButton(
            icon: Icon(Icons.home), // Add the home icon
            onPressed: () {
              goToPage(context, const RolePage(), clearStack: true);
              Navigator.of(context).pop(); // Navigate back to the home screen
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Consumer(
          builder: (context, ref, child) {
            List<MilletOrder> orders;
            if (appCache.isFarmer()) {
              orders = ref.watch(homeProvider).getAllDeliveries();
              ref.read(homeProvider).updateItemDeliveries(orders);
            } else {
              orders = ref.watch(homeProvider).getAllOrders();
              ref.read(homeProvider).updateItemOrder(orders);
            }

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
              itemCount: orders.length,
              itemBuilder: (context, index) {
                return FutureBuilder(
                  future: getItemById(orders[index].item),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return AgroItemOrder(
                        index: index,
                        item: snapshot.data!,
                        itemOrder: orders[index],
                        showAddCartIcon: false,
                      );
                    } else if (snapshot.hasError) {
                      return const Center(
                        child: Text("Error Occurred"),
                      );
                    }
                    return Container();
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
