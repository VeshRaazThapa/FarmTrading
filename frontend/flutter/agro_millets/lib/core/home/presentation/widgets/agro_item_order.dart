import 'package:agro_millets/data/cache/app_cache.dart';
import 'package:agro_millets/globals.dart';
import 'package:agro_millets/models/millet_item.dart';
import 'package:agro_millets/models/order_item.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

class AgroItemOrder extends StatelessWidget {
  /// Index is for sizing
  final int index;
  final MilletItem item;
  final MilletOrder itemOrder;
  final bool showAddCartIcon;
  final bool showCallIcon;

  const AgroItemOrder({
    super.key,
    required this.index,
    required this.item,
    required this.itemOrder,
    this.showAddCartIcon = true,
    this.showCallIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 0.5 * getWidth(context),
      height: 0.3 * getHeight(context),
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () {
                // goToPage(context, ItemDetailPage(item: item));
              },
              child: Container(
                padding: const EdgeInsets.all(8.0),
                margin: const EdgeInsets.all(2.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5.0,
                      spreadRadius: 3.0,
                      offset: const Offset(5.0, 5.0),
                    )
                  ],
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: LayoutBuilder(builder: (context, constraints) {
                  //print(item);
                  return Column(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                          ),
                          child: Image.network(
                            item.images[0].toString(),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey.withOpacity(0.2),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 1 * constraints.maxWidth,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: null,
                                    ),
                                    // maxLines: 1,
                                    // overflow: TextOverflow.fade,
                                  ),
                                ),
                                // const Spacer(),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "${itemOrder.quantity} ${itemOrder.quantityType}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300),
                                ),
                                const Spacer(),
                                Text(
                                  "रू ${itemOrder.price}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w300),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Delivery in",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w100),
                                ),
                                const Spacer(),
                                Text(
                                  "2 days",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w100),
                                ),

                              ],
                            ),
                            if (appCache.isCustomer())
                            Row(
                              children: [
                                Text(
                                  "Contact Farmer",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    color: Colors.green,
                                  ),
                                ),

                              ],
                            ),
                            if (appCache.isFarmer())
                              Row(
                              children: [
                                Text(
                                  "Contact Wholesaler",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                    color: Colors.green,
                                  ),
                                ),

                              ],
                            ),
                            if (appCache.isCustomer())
                              Row(
                                children: [
                                  Text(
                                    "${itemOrder.phoneCustomer}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w100),
                                  ),
                                  const Spacer(),

                                  IconButton(
                                    onPressed: () => UrlLauncher.launch(
                                        'tel://${itemOrder.phoneCustomer}'),
                                    icon: const Icon(MdiIcons.phoneDial),
                                  ),
                                ],
                              ),
                            if (appCache.isFarmer())
                              Row(
                                children: [
                                  Text(
                                    "${itemOrder.phoneCustomer}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w100),
                                  ),
                                  const Spacer(),
                                  IconButton(
                                    onPressed: () => UrlLauncher.launch(
                                        'tel://${itemOrder.phoneCustomer}'),
                                    icon: const Icon(MdiIcons.phoneDial),
                                  ),
                                ],
                              ),
                          ]),
                    ],
                  );
                }),
              ),
            ),
          ),
          // if (showAddCartIcon && !appCache.isAdmin() && !appCache.isFarmer())
          //   Consumer(builder: (context, ref, child) {
          //     return Positioned(
          //       right: 0,
          //       top: 0,
          //       child: GestureDetector(
          //         onTap: () async {
          //           CartItem cartItem = CartItem(item: item.id, count: 1);
          //           ref.read(cartProvider).addItemToCart(cartItem);
          //           CartManager(context, ref, poll: false)
          //               .addItemToCart(item: cartItem);
          //         },
          //         child: Container(
          //           width: 40,
          //           height: 40,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.black.withOpacity(0.05),
          //                 blurRadius: 5.0,
          //                 spreadRadius: 3.0,
          //                 offset: const Offset(0.0, 0.0),
          //               )
          //             ],
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           child: const Icon(
          //             MdiIcons.cartPlus,
          //             color: Colors.black,
          //           ),
          //         ),
          //       ),
          //     );
          //   }),
          // if (!showAddCartIcon)
          //   Consumer(builder: (context, ref, child) {
          //     return Positioned(
          //       right: 0,
          //       top: 0,
          //       child: GestureDetector(
          //         onTap: () async {
          //           ref.read(cartProvider).removeItemFromCart(item.id);
          //           CartManager(context, ref, poll: false)
          //               .removeItemFromCart(itemId: item.id);
          //         },
          //         child: Container(
          //           width: 40,
          //           height: 40,
          //           decoration: BoxDecoration(
          //             color: Colors.white,
          //             boxShadow: [
          //               BoxShadow(
          //                 color: Colors.black.withOpacity(0.05),
          //                 blurRadius: 5.0,
          //                 spreadRadius: 3.0,
          //                 offset: const Offset(0.0, 0.0),
          //               )
          //             ],
          //             borderRadius: BorderRadius.circular(10.0),
          //           ),
          //           // child: const Icon(
          //           //   MdiIcons.delete,
          //           //   color: Colors.red,
          //           // ),
          //         ),
          //       ),
          //     );
          //   }),
        ],
      ),
    );
  }
}
