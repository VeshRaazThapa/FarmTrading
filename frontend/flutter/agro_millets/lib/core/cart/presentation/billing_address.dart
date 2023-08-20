import 'package:agro_millets/core/cart/presentation/add_address_page.dart';
import 'package:flutter/material.dart';

class UnpaidPage extends StatefulWidget {
  @override
  _UnpaidPageState createState() => _UnpaidPageState();
}

class _UnpaidPageState extends State<UnpaidPage> {
  @override
  Widget build(BuildContext context) {
    Widget payButton = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AddAddressPage())),
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width / 1.5,
        decoration: BoxDecoration(
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.16),
              offset: Offset(0, 5),
              blurRadius: 10.0,
            )
          ],
          borderRadius: BorderRadius.circular(9.0),
        ),
        child: Center(
          child: Text(
            "Update Address",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );

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
                            'Billing Address',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          CloseButton()
                        ],
                      ),
                    ),
                    ClipRect(
                      child: Container(
                        margin: const EdgeInsets.all(16.0),
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.16),
                              offset: Offset(0, 5),
                              blurRadius: 10.0,
                            )
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            // Add labels and ListTile widgets with appropriate details
                            ListTile(
                              title: Text(
                                'Username',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                'Aarati Adhikari',
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Email',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                'adhikariaarati68@gmail.com',
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Phone Number',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                '+977-9843807439',
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Address',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                'Lubhoo, Bagmati, 4406',
                                style: TextStyle(color: Colors.black, fontSize: 16),
                              ),
                            ),
                            // Add more ListTiles as needed for the payment summary

                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: payButton,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
