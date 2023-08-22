import 'package:agro_millets/data/cache/app_cache.dart';
import 'package:agro_millets/models/millet_item.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../../../models/order_item.dart';
import '../../application/home_manager.dart';

class OrderDetails extends StatefulWidget {
  final MilletItem? item;
  final MilletOrder? itemOrder;

  const OrderDetails({super.key, this.item, this.itemOrder});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();

}


class _OrderDetailsState extends State<OrderDetails> {
  String? selectedStatus="Processing";

  @override
  void initState() {
    selectedStatus = widget.itemOrder?.status!;
    print('------insided initstat---');
    print(selectedStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('-----status------');
    print(selectedStatus);
    return Material(
      color: Colors.white,
      child: SafeArea(
        child: LayoutBuilder(
          builder: (_, constraints) => SingleChildScrollView(
            physics: ClampingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            'Order Details',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CloseButton(),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(16.0),
                      padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.16),
                            offset: Offset(0, 5),
                            blurRadius: 10.0,
                          ),
                        ],
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            height: 200, // Adjust the height as needed
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(
                                  widget.item?.images[0],
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildUserSpecificInfo(),
                          ListTile(
                            title: Text('Name'),
                            trailing: Text('${this.widget.item?.name}'),
                          ),
                          if (!appCache.isFarmer())
                            ListTile(
                            title: Text('Status'),
                            trailing: Text('${this.widget.itemOrder?.status}'),
                          ),
                          if (appCache.isFarmer())
                            ListTile(
                              title: Text('Status'),
                              trailing: DropdownButton<String>(
                                value: selectedStatus,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    updateOrderStatus(widget.itemOrder!.id,newValue!);
                                    selectedStatus = newValue!;
                                  });
                                },
                                items: [
                                  'Processing',
                                  'Packaging',
                                  'Delivering'
                                ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(
                                          value,
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      );
                                    }).toList(),
                              ),

                            ),

                          ListTile(
                            title: Text('Order Id'),
                            trailing: Text('${this.widget.itemOrder?.id}'),
                          ),
                          ListTile(
                            title: Text('Quantity'),
                            trailing: Text('${this.widget.itemOrder?.quantity}'),
                          ),
                          ListTile(
                            title: Text('Price/item'),
                            trailing: Text('${this.widget.item?.price}'),
                          ),
                          ListTile(
                            title: Text('Mode of payment'),
                            trailing: Text('${this.widget.itemOrder?.modeOfPayment}'),
                          ),
                          ListTile(
                            title: Text('Paid'),
                            trailing: Text('${this.widget.itemOrder?.isPaid}'),
                          ),
                           ListTile(
                            title: Text('Date/Time of Order'),
                            trailing: Text('${DateFormat('MMMM d, y').format(this.widget.itemOrder!.listedAt)}'),
                          ),
                          Divider(),
                          ListTile(
                            title: Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              'रू ${this.widget.itemOrder?.price}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserSpecificInfo() {
    if (appCache.isAdmin()) {
      return Column(
        children: [
          // ListTile(
          //   title: Text('Ordered By'),
          //   trailing: Text('Wholesaler'),
          // ),
          ListTile(
            title: Text('Ordered From'),
            trailing: Text('${this.widget.item?.farmer}'),
          ),
        ],
      );
    } else if (!appCache.isAdmin() && appCache.isCustomer()) {
      return ListTile(
        title: Text('Ordered From'),
        trailing: Text('${this.widget.item?.farmer}'),
      );
    }
      // else if (!appCache.isAdmin() && appCache.isFarmer()) {
    //   return ListTile(
    //     title: Text('Ordered By'),
    //     trailing: Text('Wholesaler'),
    //   );
    // }
    return SizedBox.shrink();
  }
}
