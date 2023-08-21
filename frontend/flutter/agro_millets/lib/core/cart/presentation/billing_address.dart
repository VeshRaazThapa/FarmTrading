import 'package:agro_millets/core/cart/presentation/add_address_page.dart';
import 'package:agro_millets/core/cart/presentation/payment_details.dart';
import 'package:flutter/material.dart';

import '../../../models/millet_item.dart';
import '../../home/presentation/news/constants.dart';

class UnpaidPage extends StatefulWidget {
  @override
  _UnpaidPageState createState() => _UnpaidPageState();
}

enum PaymentMethod {
  CashOnDelivery,
  Esewa,
}

class _UnpaidPageState extends State<UnpaidPage> {
  late PaymentMethod selectedPaymentMethod = PaymentMethod.Esewa;
  late MilletItem selectedItem; // Declare the selectedItem variable

  void _togglePaymentMethod(PaymentMethod? newMethod) {
    if (newMethod != null) {
      setState(() {
        selectedPaymentMethod = newMethod;
        if (selectedPaymentMethod == PaymentMethod.CashOnDelivery) {
          showSuccessToast('Cash on Delivery Selected');
        } else {
          showSuccessToast('Esewa Selected');
        }
      });
    }
  }

  void _onPayButtonPressed() {
    if (selectedPaymentMethod == PaymentMethod.CashOnDelivery) {
      // Handle Cash on Delivery payment logic
    } else if (selectedPaymentMethod == PaymentMethod.Esewa) {
      // Handle Esewa payment logic
    }
  }

  void _showPaymentModePopup() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Payment Mode'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: <Widget>[
                  Radio(
                    value: PaymentMethod.CashOnDelivery,
                    groupValue: selectedPaymentMethod,
                    onChanged: (newValue) {
                      _togglePaymentMethod(newValue);
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  Text('Cash on Delivery'),
                ],
              ),
              Row(
                children: <Widget>[
                  Radio(
                    value: PaymentMethod.Esewa,
                    groupValue: selectedPaymentMethod,
                    onChanged: (newValue) {
                      _togglePaymentMethod(newValue);
                      Navigator.of(context).pop(); // Close the dialog
                    },
                  ),
                  Text('Esewa'),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Close the popup
                Navigator.of(context).pop();
              },
              child: Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget updateAddressButton = GestureDetector(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => AddAddressPage())),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Text(
          "Update Address",
          style: const TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
          ),
        ),
      ),
    );

    Widget continueButton = ElevatedButton(
      onPressed: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PaymentPage()));
      },
      style: ElevatedButton.styleFrom(
        primary: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Text(
          "Continue",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 15.0,
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
                          IconButton(
                            icon: Icon(Icons.account_balance_wallet),
                            onPressed: _showPaymentModePopup,
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
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                'Aarati Adhikari',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Email',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                'adhikariaarati68@gmail.com',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Phone Number',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                '+977-9843807439',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Billing Address',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                'Lubhoo, Bagmati, 4406',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            ListTile(
                              title: Text(
                                'Shipping Address',
                                style:
                                    TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              subtitle: Text(
                                'Lubhoo, Bagmati, 4406',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                            ),
                            // Add more ListTiles as needed for the payment summary
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20, right: 16.0),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            updateAddressButton,
                            SizedBox(height: 10),
                             continueButton,
                          ],

                        ),
                      ),
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
