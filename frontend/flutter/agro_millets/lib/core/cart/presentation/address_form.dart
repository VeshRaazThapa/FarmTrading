import 'package:flutter/material.dart';

class AddAddressForm extends StatefulWidget {
  @override
  _AddAddressFormState createState() => _AddAddressFormState();
}

class _AddAddressFormState extends State<AddAddressForm> {
  String selectedProvince = 'Province 1';
  bool isDefaultAddress = false;
  bool isDefaultBillingAddress = false;

  List<String> provinces = [
    'Province 1',
    'Province 2',
    'Bagmati',
    'Gandaki',
    'Lumbini',
    'Karnali',
    'Sudurpaschim',
  ];

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          TextFormField(
            decoration: _inputDecoration('Full Name'),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: _inputDecoration('Email'),
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: _inputDecoration('Mobile Number'),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: _inputDecoration('City'),
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: selectedProvince,
            decoration: _inputDecoration('Province'),
            items: provinces.map((province) {
              return DropdownMenuItem<String>(
                value: province,
                child: Text(province),
              );
            }).toList(),
            onChanged: (newValue) {
              setState(() {
                selectedProvince = newValue!;
              });
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            decoration: _inputDecoration('Postal Code'),
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 13),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Default Address Options',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
                ClipRect(
                  child: Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: isDefaultAddress,
                              onChanged: (newValue) {
                                setState(() {
                                  isDefaultAddress = newValue!;
                                });
                              },
                            ),
                            Text('Default Shipping Address'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Checkbox(
                              value: isDefaultBillingAddress,
                              onChanged: (newValue) {
                                setState(() {
                                  isDefaultBillingAddress = newValue!;
                                });
                              },
                            ),
                            Text('Default Billing Address'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
