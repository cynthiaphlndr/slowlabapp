// ignore_for_file: dead_code
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Products {
  String model = "";
  int pk = 0;
  Map<String, dynamic> fields = {};

  Products(this.model, this.pk, this.fields);

  Products.fromJson(Map<String, dynamic> json) {
    model = json['model'];
    pk = json['pk'];
    fields = json['fields'];
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({Key? key}) : super(key: key);
  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  List<Products> _Product = <Products>[];

  Future<List<Products>> fetchProduct() async {
    var url = 'http://slowlab-core.herokuapp.com/product-list/json';
    var response = await http.get(Uri.parse(url));

    var prod = <Products>[];

    if (response.statusCode == 200) {
      var prodsJson = json.decode(response.body);
      for (var prodJson in prodsJson) {
        prod.add(Products.fromJson(prodJson));
      }
    }
    return prod;
  }

  void movePage() {
    Navigator.pop(context);
    Navigator.pushNamed(context, '/booking');
  }

  @override
  void initState() {
    fetchProduct().then((value) {
      setState(() {
        _Product.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("ProductList"),
        ),
        body: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Apa yang kami tawarkan",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 50),
                ),
                Padding(padding: EdgeInsets.symmetric(vertical: 20.0)),
                ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Card(
                          child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _Product[index].fields['name'],
                              style: TextStyle(
                                  fontSize: 22, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Rp" + _Product[index].fields['price'].toString(),
                              style: TextStyle(color: Colors.grey.shade600),
                            ),
                            Padding(
                                padding: EdgeInsets.symmetric(vertical: 10.0)),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Color(0xFFFFC300),
                                  onPrimary: Colors.white,
                                ),
                                onPressed: movePage,
                                child: Text("Pesan sekarang"))
                          ],
                        ),
                      ));
                    },
                    itemCount: _Product.length)
              ],
            )));
  }
}
