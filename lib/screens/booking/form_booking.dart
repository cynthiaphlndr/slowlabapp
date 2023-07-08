import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FormBookingPage extends StatefulWidget {
  const FormBookingPage({Key? key}) : super(key: key);

  @override
  State<FormBookingPage> createState() => _FormBookingPageState();
}

class _FormBookingPageState extends State<FormBookingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("FormBooking"),
        ),
        body: Column(
          children: const [
            Expanded(
                child: WebView(
                    javascriptMode: JavascriptMode.unrestricted,
                    initialUrl:
                        "https://slowlab-core.herokuapp.com/booking/booking-form")),
          ],
        ));
  }
}
