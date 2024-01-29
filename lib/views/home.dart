import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Razorpay razorpay;
  TextEditingController textEditingController = new TextEditingController();

  @override
  void initState() {
    super.initState();

    razorpay = new Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlerPaymentSuccess);
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlerErrorFailure);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handlerExternalWallet);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    razorpay.clear();
  }

  void openCheckout() {
    var options = {
      "key": "rzp_test_HkIjTO2MvKikuV",
      "order_id": "order_NUKeH4x6imGGoF",
      "amount": num.parse(textEditingController.text) * 100,
      "name": "Sample App",
      "modal": {"confirm_close": true, "escape": true},
      "description": "Payment for the some random product",
      "prefill": {"contact": "+918258011598", "email": "shdjsdh@gmail.com"},
    };

    try {
      razorpay.open(options);
    } catch (e) {
      print(e.toString());
    }
  }

  void handlerPaymentSuccess(PaymentSuccessResponse event) {
    event.paymentId;
    print("Pament success");
  }

  void handlerErrorFailure(PaymentFailureResponse event) {
    print("Pament error");
  }

  void handlerExternalWallet() {
    print("External Wallet");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Razor Pay Tutorial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: textEditingController,
              decoration: InputDecoration(hintText: "amount to pay"),
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: Text(
                "Donate Now",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                openCheckout();
              },
            )
          ],
        ),
      ),
    );
  }
}
