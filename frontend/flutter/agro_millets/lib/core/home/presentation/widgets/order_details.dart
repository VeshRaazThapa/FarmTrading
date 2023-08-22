import 'package:agro_millets/data/cache/app_cache.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatefulWidget {
  const OrderDetails({super.key});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  @override
  Widget build(BuildContext context) {
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
                                  'https://californiaavocado.com/wp-content/uploads/2020/07/avocado-fruit-or-vegetable-1.jpeg',
                                ),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          SizedBox(height: 16),
                          _buildUserSpecificInfo(),
                          ListTile(
                            title: Text('Product Name'),
                            trailing: Text('Item'),
                          ),
                          ListTile(
                            title: Text('Order Id'),
                            trailing: Text('-----'),
                          ),
                          ListTile(
                            title: Text('Quantity'),
                            trailing: Text('20'),
                          ),
                          ListTile(
                            title: Text('Price/item'),
                            trailing: Text('200'),
                          ),
                          ListTile(
                            title: Text('Mode of payment'),
                            trailing: Text('Cash on Delivery'),
                          ),
                           ListTile(
                            title: Text('Date/Time of Order'),
                            trailing: Text('____'),
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
                              'रू 20000',
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
          ListTile(
            title: Text('Ordered By'),
            trailing: Text('Wholesaler'),
          ),
          ListTile(
            title: Text('Ordered From'),
            trailing: Text('Farmer'),
          ),
        ],
      );
    } else if (!appCache.isAdmin() && appCache.isCustomer()) {
      return ListTile(
        title: Text('Ordered From'),
        trailing: Text('Farmer'),
      );
    } else if (!appCache.isAdmin() && appCache.isFarmer()) {
      return ListTile(
        title: Text('Ordered By'),
        trailing: Text('Wholesaler'),
      );
    }
    return SizedBox.shrink();
  }
}
