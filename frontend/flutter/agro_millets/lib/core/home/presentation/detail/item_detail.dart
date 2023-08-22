import 'package:agro_millets/colors.dart';
import 'package:agro_millets/core/cart/application/cart_manager.dart';
import 'package:agro_millets/core/cart/application/cart_provider.dart';
import 'package:agro_millets/core/home/application/comment_manager.dart';
import 'package:agro_millets/core/home/application/comment_provider.dart';
import 'package:agro_millets/core/home/application/home_manager.dart';
import 'package:agro_millets/data/cache/app_cache.dart';
import 'package:agro_millets/globals.dart';
import 'package:agro_millets/models/cart_item.dart';
import 'package:agro_millets/models/comment.dart';
import 'package:agro_millets/models/millet_item.dart';
import 'package:agro_millets/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;

import '../../../../models/order_item.dart';
import '../../../admin/application/admin_apis.dart';
import '../../../order/presentation/order_form_page.dart';

class ItemDetailPage extends ConsumerStatefulWidget {
  final MilletItem item;

  const ItemDetailPage({Key? key, required this.item}) : super(key: key);

  @override
  ConsumerState<ItemDetailPage> createState() => _ItemDetailPageState();
}

class _ItemDetailPageState extends ConsumerState<ItemDetailPage> {
  late CommentManager _commentManager;
  late HomeManager _homeManager;
  late MilletItem item;
  final TextEditingController _commentController = TextEditingController();

  int amount = 1;

  @override
  void initState() {
    item = widget.item;
    _commentManager = CommentManager(context, ref, item.id);
    _homeManager = HomeManager(context, ref);
    super.initState();
  }

  @override
  void dispose() {
    _commentManager.dispose();
    _homeManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          // if (appCache.isCustomer())
          //   IconButton(
          //     onPressed: () => UrlLauncher.launch('tel://9812345668'),
          //     icon: const Icon(MdiIcons.phoneDial),
          //   ),
          if (appCache.isCustomer())
            IconButton(
              onPressed: () {
                CartItem cartItem = CartItem(item: item.id, count: 1);
                ref.read(cartProvider).addItemToCart(cartItem);
                CartManager(context, ref, poll: false)
                    .addItemToCart(item: cartItem);
              },
              icon: const Icon(MdiIcons.cartPlus),
            ),
          if (appCache.isAdmin() || appCache.isOwnerOf(item.listedBy))
            IconButton(
              onPressed: () {
                Navigator.pop(context);
                deleteItem(item.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
            ),
        ],
        elevation: 0,
        centerTitle: true,
        title: const Text("Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 0.015 * getHeight(context)),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.network(
                  item.images[0],
                  height: 0.3 * getHeight(context),
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(height: 0.025 * getHeight(context)),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 0.6 * getWidth(context),
                  child: Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                Text(
                  "रू ${item.price}/${item.quantityType}",
                  style: const TextStyle(
                      fontSize: 18,
                      overflow: TextOverflow.ellipsis,
                      color: lightColor,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
            SizedBox(height: 0.01 * getHeight(context)),
            Text(
              'Category: ' + item.category,
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            //SizedBox(height: 0.01 * getHeight(context)),
            Text(
              'Farmer : ${item.farmer}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            Text(
              'Description : ${item.description}',
              style: const TextStyle(
                fontSize: 15,
                color: Colors.grey,
              ),
            ),
            Text(
              "Quantity: ${item.quantity} ${item.quantityType}",
              style: const TextStyle(
                  fontSize: 15, color: lightColor, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 0.025 * getHeight(context)),
            const Divider(height: 10),
            const Text(
              "Comments",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            SizedBox(height: 0.015 * getHeight(context)),
            if (!appCache.isAdmin())
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    hint: "Type comment here...",
                    controller: _commentController,
                    onChanged: (v) {},
                    onSubmitted: (v) => postComment(),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    MdiIcons.sendCircle,
                    size: 35,
                  ),
                  onPressed: () => postComment(),
                ),
              ],
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: ref.watch(commentProvider).getComments().length,
              itemBuilder: (context, index) {
                var list = ref.watch(commentProvider).getComments();
                if (appCache.isAdmin()) {
                  return Dismissible(
                    key: ValueKey(list[index].id),
                    background: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [
                            Colors.white,
                            Colors.red,
                          ],
                        ),
                      ),
                      child: Row(
                        children: const [
                          Spacer(),
                          Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          SizedBox(width: 20),
                        ],
                      ),
                    ),
                    child: _getCommentItem(list, index),
                  );
                } else {
                  return _getCommentItem(list, index);
                }
              },
            ),
            // const SizedBox(height: 40),
            SizedBox(height: 0.015 * getHeight(context)),
            if (appCache.isCustomer())
              //
              const Text(
                "You May Like This",
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            SizedBox(height: 0.015 * getHeight(context)),
            if (appCache.isCustomer()) _getRecommendedProducts(context),
            //const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  ListTile _getCommentItem(List<CommentItem> list, int index) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(list[index].name[0]),
      ),
      title: Row(
        children: [
          Text(
            list[index].name,
            style: const TextStyle(
              fontSize: 13,
            ),
          ),
          const Spacer(),
          Text(
            timeago.format(list[index].commentAt, locale: 'en_short'),
            style: const TextStyle(
              fontSize: 13,
              color: Colors.grey,
            ),
          ),
        ],
      ),
      subtitle: Text(list[index].content),
    );
  }

  void postComment() {
    _commentManager.addComment(_commentController.text);
    _commentController.text = "";
  }

  FutureBuilder<List<MilletItem>> _getRecommendedProducts(
      BuildContext context) {
    return FutureBuilder(
        future: AdminAPIs.getAllRecommendedItems(widget.item),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            List<MilletItem> list = snapshot.data ?? [];
            // print(list);
            // print('--------------');
            return SizedBox(
              height: 400, // Set a specific height here
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Divider(
                      color: Colors.grey.withOpacity(0.2),
                    ),
                  );
                },
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    width: 150, // Set the width of each product container
                    child: GestureDetector(
                      onTap: () {
                        goToPage(context, ItemDetailPage(item: list[index]));
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              list[index].images[0],
                              height: 100,
                              width: 150,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(height: 5),
                            Text(
                              list[index].name,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "रू ${list[index].price}/${list[index].quantityType}",
                              style: TextStyle(
                                fontSize: 14,
                                color: semiDarkColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}
