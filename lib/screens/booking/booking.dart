import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:slowlabapp/screens/booking/form_booking.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final String url = "https://slowlab-core.herokuapp.com/booking/get-booking/";
  List? data;

  void initState() {
    _getRefreshData();
    super.initState();
  }

  Future<void> _getRefreshData() async {
    this.getJsonData(context);
  }

  Future<void> getJsonData(BuildContext context) async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "aplication/json"});

    print(response.body);
    setState(() {
      var convertDataToJson = jsonDecode(response.body);

      data = convertDataToJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Booking"),
        ),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(16),
              child: Column(children: [
                data == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data!.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              padding: EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Row(
                                        children: [
                                          Column(children: [
                                            Text(data![index]["fields"]
                                                ["email"]),
                                            Text(data![index]["fields"]
                                                ["lokasi"]),
                                            Text(data![index]["fields"]
                                                ["tanggal"]),
                                            Text(data![index]["fields"]
                                                ["jenis"]),
                                            // Text(data!.toString()),
                                          ])
                                        ],
                                      )),
                                  Divider()
                                ],
                              ));
                        })
              ])),
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const FormBookingPage()));
            // Navigator.pushNamed(context, '/booking-form');
          },
          icon: Icon(Icons.add),
          label: Text('Reservasi'),
        ));
  }
}
