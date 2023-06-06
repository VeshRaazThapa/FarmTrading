import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/state_manager.dart';
import 'package:latlong2/latlong.dart';
import 'package:agro_millets/core/auth/presentation/phone_verify.dart';

import '../../../globals.dart';

class MyPhone extends StatefulWidget {


  const MyPhone({
    Key? key,
  }) : super(key: key);

  @override
  State<MyPhone> createState() => _MyPhoneState();
}
class VerificationData {
  static String verificationId = '';
}
class _MyPhoneState extends State<MyPhone> {
  TextEditingController countryController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var verificationId = ''.obs;
  // static String verificationId = '';

  @override
  void initState() {
    // TODO: implement initState
    countryController.text = "+977";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/logo_app.png',
                width: 150,
                height: 150,
              ),
              SizedBox(
                height: 25,
              ),
              Text(
                "Phone Verification",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "We need to register your phone before getting started!",
                style: TextStyle(
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                height: 55,
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      width: 40,
                      child: TextField(
                        controller: countryController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Text(
                      "|",
                      style: TextStyle(fontSize: 33, color: Colors.grey),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Expanded(
                        child: TextField(
                          controller: _phoneController,
                      keyboardType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(10), // Limit input to 10 characters
                          ],
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ))
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      String phone = countryController.text+' '+_phoneController.text;
                      await phoneAuthentication(phone);
                      // print(phone_number_verified);
                      // print('-----');
                      goToPage(context,MyVerify(verificationId:this.verificationId.value,phone:phone));
                      // Navigator.pushNamed(context, 'verify');
                    },
                    child: Text("Send the code")),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> sendOTPCode(String phoneNumber) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationFailed: (FirebaseAuthException e) {
        // Handle verification failure
      },
      codeSent: (String verificationId, [int? forceResendingToken]) {
        VerificationData.verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Handle timeout error if needed
      }, verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {  },
    );
  }

  Future<void> phoneAuthentication(String phoneNo) async {
    print(phoneNo);
    await _auth.verifyPhoneNumber(
        phoneNumber: '+977 98-61698983',
        verificationCompleted: (credential
            ) async {      await _auth.signInWithCredential(credential);
    },
    verificationFailed: (e) {
    if (e.code == 'invalid-phone-number'){
      print(
      'the provided no is not valid'
      );

  } else {
      print('Something Went Wrong. Try Again');
  }


  }, codeSent: (verificationId,resendToken) async {
        print('The Code has been sent.......');
        this.verificationId.value=verificationId;
        // await verifyOTP('123456');
        }, codeAutoRetrievalTimeout: (verificationId){
      print('The Code retrieval timout.......');

      this.verificationId.value = verificationId;
        }
  );
  }
  // Future<bool>verifyOTP(String otp) async {
  //   print(verificationId.value);
  //   print('------');
  // var credentials = await _auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId.value, smsCode: otp));
  // return credentials.user != null ? true:false;
  }


