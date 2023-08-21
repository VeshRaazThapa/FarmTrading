import 'package:esewa_flutter_sdk/esewa_config.dart';
import 'package:esewa_flutter_sdk/esewa_payment.dart';
import 'package:esewa_flutter_sdk/esewa_payment_success_result.dart';
import 'package:flutter/material.dart';
import 'package:esewa_flutter_sdk/esewa_flutter_sdk.dart';


class MyEsewaApp extends StatefulWidget {
  @override
  _MyEsewaAppState createState() => _MyEsewaAppState();
}

class _MyEsewaAppState extends State<MyEsewaApp> {
  // late ESewaPnp _esewaPnp;
  // late ESewaConfiguration _conf
  // iguration;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    initPayment();
    // _configuration = ESewaConfiguration(
    //   clientID: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
    //   secretKey: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
    //   environment: ESewaConfiguration.ENVIRONMENT_TEST,
    // );

    }


  void initPayment  () async {
    // ESewaPayment _payment = ESewaPayment(
    //   amount: 10.0,
    //   productName: "https://example.com",
    //   productID: "abc123",
    //   callBackURL: "Flutter SDK Example",
    // );

    try {
      EsewaFlutterSdk.initPayment(
        esewaConfig: EsewaConfig(
          environment: Environment.test,
          clientId: "JB0BBQ4aD0UqIThFJwAKBgAXEUkEGQUBBAwdOgABHD4DChwUAB0R",
          secretId: "BhwIWQQADhIYSxILExMcAgFXFhcOBwAKBgAXEQ==",
        ),
        esewaPayment: EsewaPayment(
          productId: "1d71jd81",
          productName: "Product One",
          productPrice: "20",
        ),
        onPaymentSuccess: (EsewaPaymentSuccessResult data) {
          debugPrint(":::SUCCESS::: => $data");
          verifyTransactionStatus(data);
        },
        onPaymentFailure: (data) {
          debugPrint(":::FAILURE::: => $data");
        },
        onPaymentCancellation: (data) {
          debugPrint(":::CANCELLATION::: => $data");
        },
      );
    } on Exception catch (e) {
      debugPrint("EXCEPTION : ${e.toString()}");
    }

  }
  void verifyTransactionStatus(EsewaPaymentSuccessResult result) async {
    var response = await callVerificationApi(result);
    if (response.statusCode == 200) {
      var map = {'data': response.data};
      final sucResponse = EsewaPaymentSuccessResult.fromJson(map);
      debugPrint("Response Code => ${sucResponse}");
    //   if (sucResponse.data[0].transactionDetails.status == 'COMPLETE') {
    //     //TODO Handle Txn Verification Success
    //     return;
    //   }
    //   //TODO Handle Txn Verification Failure
    // } else {
    //   //TODO Handle Txn Verification Failure
    // }
  } }




  double _amount = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Color.fromRGBO(65, 161, 36, 1),
      ),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("ESewa PNP"),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    _amount = double.parse(value);
                  });
                },
                decoration: InputDecoration(
                  labelText: "Enter amount",
                ),
              ),
              SizedBox(
                height: 16,
              ),

              SizedBox(
                height: 84,
              ),
              Text(
                "Plugin developed by Ashim Upadhaya.",
                style: TextStyle(color: Colors.black45),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSnackBar(Color color, String msg) {
    return SnackBar(
      backgroundColor: color,
      content: Text(msg),
    );
  }
}

callVerificationApi(EsewaPaymentSuccessResult result) {

  var request_uri = 'https://esewa.com.np/mobile/transaction?txnRefId={result[0].transactionDetails.status}';

}