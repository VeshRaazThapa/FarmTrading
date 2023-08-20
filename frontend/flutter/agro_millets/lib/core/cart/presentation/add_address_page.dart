import 'package:agro_millets/core/cart/presentation/unpaid_page.dart';
import 'package:flutter/material.dart';

import 'address_form.dart';


class AddAddressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget finishButton = InkWell(
      onTap: () => Navigator.of(context)
          .push(MaterialPageRoute(builder: (_) => UnpaidPage())),
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
            "Finish",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.grey[800]),
        title: Text(
          'Billing Details',
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w500,
            fontFamily: "Montserrat",
            fontSize: 25.0,
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (_, viewportConstraints) => SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: viewportConstraints.maxHeight),
            child: Container(
              padding: EdgeInsets.zero,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: <Widget>[
                //       Card(
                //         margin: EdgeInsets.symmetric(vertical: 8.0),
                //         color: Colors.white,
                //         elevation: 3,
                //         child: SizedBox(
                //           height: 100,
                //           width: 80,
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Padding(
                //                   padding: const EdgeInsets.all(4.0),
                //                   child: Image.asset('assets/icons/address_home.png'),
                //                 ),
                //                 Text(
                //                   'Add New Address',
                //                   style: TextStyle(
                //                     fontSize: 8,
                //                     color: Colors.grey[800],
                //                   ),
                //                   textAlign: TextAlign.center,
                //                 )
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       Card(
                //         margin: EdgeInsets.symmetric(vertical: 8.0),
                //         color: Colors.yellow, // Use the predefined color
                //         elevation: 3,
                //         child: SizedBox(
                //           height: 80,
                //           width: 100,
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Padding(
                //                   padding: const EdgeInsets.all(4.0),
                //                   child: Image.asset(
                //                     'assets/icons/address_home.png',
                //                     color: Colors.white,
                //                     height: 20,
                //                   ),
                //                 ),
                //                 Text(
                //                   'Simon Philip,\nCity Oscarlad',
                //                   style: TextStyle(
                //                     fontSize: 8,
                //                     color: Colors.white,
                //                   ),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //       Card(
                //         margin: EdgeInsets.symmetric(vertical: 8.0),
                //         color: Colors.yellow, // Use the predefined color
                //         elevation: 3,
                //         child: SizedBox(
                //           height: 80,
                //           width: 100,
                //           child: Padding(
                //             padding: const EdgeInsets.all(8.0),
                //             child: Column(
                //               mainAxisAlignment: MainAxisAlignment.center,
                //               children: <Widget>[
                //                 Padding(
                //                   padding: const EdgeInsets.all(4.0),
                //                   child: Image.asset(
                //                     'assets/icons/address_work.png',
                //                     color: Colors.white,
                //                     height: 20,
                //                   ),
                //                 ),
                //                 Text(
                //                   'Workplace',
                //                   style: TextStyle(
                //                     fontSize: 8,
                //                     color: Colors.white,
                //                   ),
                //                   textAlign: TextAlign.center,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                  AddAddressForm(),
                  Center(child: finishButton),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
