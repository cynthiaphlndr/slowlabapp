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
  String? keyword;

  @override
  void initState() {
    _getRefreshData();
    super.initState();
  }

  Future<void> _getRefreshData() async {
    getJsonData(context);
  }

  Future<void> getJsonData(BuildContext context) async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "aplication/json"});

    setState(() {
      var convertDataToJson = jsonDecode(response.body);
      data = convertDataToJson;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Booking"), actions: const []),
        body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(16),
              child: Column(children: [
                const TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Search',
                  ),
                ),
                ElevatedButton(onPressed: () {}, child: Text("Search")),
                SizedBox(
                  height: 24.0,
                ),
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
                                  Column(
                                    children: [
                                      Column(children: [
                                        Text(data![index]["fields"]
                                            ["nama_lengkap"]),
                                        Text(data![index]["fields"]["lokasi"]),
                                        Text(data![index]["fields"]["tanggal"]),
                                        Text(data![index]["fields"]["jenis"]),
                                        // Text(data!.toString()),
                                      ]),
                                    ],
                                  ),
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
