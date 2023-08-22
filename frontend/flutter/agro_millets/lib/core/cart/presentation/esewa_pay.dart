import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:agro_millets/core/home/presentation/news/constants.dart';
import 'package:agro_millets/core/home/presentation/widgets/agro_item_order.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/order_item.dart';
import '../../../secrets.dart';
import '../../order/presentation/order_page.dart';

class EsewaEpay extends StatefulWidget {
  late final MilletOrder? itemOrder;
  EsewaEpay({required this.itemOrder});

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<EsewaEpay> {
  int onPageFinishedCount = 0; // Counter to keep track of onPageFinished calls
  Completer<WebViewController> _controller = Completer<WebViewController>();
  MilletOrder? itemOrder; // Declare the selectedItem variable

  late WebViewController _webViewController;

  String testUrl = "https://pub.dev/packages/webview_flutter";

  _loadHTMLfromAsset() async {
    String file = await rootBundle.loadString("assets/epay_request.html");
    _webViewController.loadUrl(Uri.dataFromString(file,
            mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
        .toString());
  }



  @override
  void initState() {
    super.initState();
    itemOrder = widget.itemOrder!;
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }





  @override
  Widget build(BuildContext context) {
    // ePay deatils
    double amt = itemOrder?.price ?? 0.0 ;
    double txAmt = amt * 0.25;
    double psc = 10;
    double pdc = 50;
    double tAmt = txAmt + amt + psc + pdc;
    String scd = "EPAYTEST";
    String su = "$API_URL/auth/esewa-success-payment/${itemOrder?.id}";
    String fu = "$API_URL/auth/esewa-failure-payment";
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     setState(() {
      //       String pid = UniqueKey().toString();
      //       _webViewController.evaluateJavascript(
      //           'requestPayment(tAmt = $tAmt, amt = $amt, txAmt = $txAmt, psc = $psc, pdc = $pdc, scd = "$scd", pid = "$pid", su = "$su", fu = "$fu")');
      //     });
      //   },
      //   child: Icon(Icons.add),
      // ),
      appBar: AppBar(
        leading: SizedBox.shrink(),
      ),
      body: WebView(
        initialUrl: "about:blank",
        javascriptMode: JavascriptMode.unrestricted,
        javascriptChannels: Set.from([
          JavascriptChannel(
            name: "message",
            onMessageReceived: (message) {},
          ),
        ]),
        onPageFinished: (data) async {
          onPageFinishedCount++;
          setState(() {
            String pid = UniqueKey().toString();
            _webViewController.runJavascript(
                'requestPayment(tAmt = $tAmt, amt = $amt, txAmt = $txAmt, psc = $psc, pdc = $pdc, scd = "$scd", pid = "$pid", su = "$su", fu = "$fu")');
          });
          // print('------data----');
          await Future.delayed(Duration(milliseconds: 2000));
          // if (onPageFinishedCount > 2) {
          //   print(onPageFinishedCount);
          //   // Redirect after onPageFinished is reached two times
          //   await Future.delayed(Duration(milliseconds: 1000));
          //
          //   Navigator.pushReplacement(
          //     context,
          //     MaterialPageRoute(builder: (context) => OrderPage()),
          //   );
          // }
        },
        onWebViewCreated: (webViewController) {
          // _controller.complete(webViewController);
          _webViewController = webViewController;
          _loadHTMLfromAsset();
        },
        navigationDelegate: (NavigationRequest request) {
          if (request.url == su) {
            showSuccessToast('Payment Success !');
            // Redirect after receiving response from speci fic URL
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => OrderPage()),
            );

            // Return NavigationDecision.prevent to prevent loading the URL
            return NavigationDecision.prevent;
          }if (request.url == fu) {
            showFailureToast('Payment Failure. Try again !');
            // Redirect after receiving response from specific URL
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => EsewaEpay(itemOrder: itemOrder,)),
            );

            // Return NavigationDecision.prevent to prevent loading the URL
            return NavigationDecision.prevent;
          }

          // Allow navigation for other URLs
          return NavigationDecision.navigate;
        },
      ),
    );
  }
}
