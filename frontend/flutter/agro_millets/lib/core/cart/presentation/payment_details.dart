import 'package:agro_millets/core/cart/presentation/esewa_pay.dart';
import 'package:agro_millets/core/cart/presentation/khalti_pay.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  int selectedPaymentOption = 0; // 0: Cash on Delivery, 1: eSewa, 2: Khalti

  void _showPaymentDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select Payment Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CheckboxListTile(
                title: Text('Cash on Delivery'),
                value: selectedPaymentOption == 0,
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedPaymentOption = 0;
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('eSewa'),
                value: selectedPaymentOption == 1,
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedPaymentOption = 1;
                      
                    }
                  });
                },
              ),
              CheckboxListTile(
                title: Text('Khalti'),
                value: selectedPaymentOption == 2,
                onChanged: (value) {
                  setState(() {
                    if (value!) {
                      selectedPaymentOption = 2;
                    }
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
            child: Text('Pay'),
            onPressed: () {
              // Perform the payment based on the selected option
              // For now, let's just print the selected option
              print('Selected Payment Option: $selectedPaymentOption');
              
              if (selectedPaymentOption == 1) {
                // Navigate to eSewa payment page
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => EsewaEpay()));
              } else if (selectedPaymentOption == 2) {
                // Navigate to Khalti payment page
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => KhaltiPay()));
              } else {
                // Perform other payment logic for Cash on Delivery
                Navigator.of(context).pop(); // Close the dialog
              }
            },
          ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget payNow = InkWell(
      onTap: _showPaymentDialog, // Show the payment dialog
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
            ),
          ],
          borderRadius: BorderRadius.circular(7.0),
        ),
        child: Center(
          child: Text(
            "Pay Now",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 20.0,
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
                            'Payment Details',
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
                          ListTile(
                            title: Text('Product Name'),
                            trailing: Text('Beans'),
                          ),
                          ListTile(
                            title: Text('Farmer Name'),
                            trailing: Text('Aarati'),
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
                    SizedBox(height: 18),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: payNow,
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
}
