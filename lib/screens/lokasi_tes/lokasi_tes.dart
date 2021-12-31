import 'package:flutter/material.dart';
import 'tambah_lokasi.dart';

import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

class LokasiTesPage extends StatefulWidget {
  const LokasiTesPage({Key? key}) : super(key: key);
  @override
  State<LokasiTesPage> createState() => _LokasiTesPageState();
}

class _LokasiTesPageState extends State<LokasiTesPage> {
  final formKey = GlobalKey<FormState>();
  final _lokasiController = TextEditingController();
  List<dynamic> hasilSearch = [];

  void fetchLokasi() async {
    var result = await http.get(
        Uri.parse("https://slowlab-core.herokuapp.com/lokasi/get-lokasi/"));
    var hasilDecode = json.decode(result.body);
    hasilSearch.clear();

    for (int i = 0; i < hasilDecode.length; i++) {
      var fields = hasilDecode[i]['fields'];

      var lokasi = fields['provinsi'].toLowerCase();
      var lokasiControl = _lokasiController.text.toLowerCase();
      if (lokasi.contains(lokasiControl)) {
        setState(() {
          hasilSearch.add(fields);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lokasi Tes"),
      ),
      body: Form(
          key: formKey,
          child: ListView(
            children: [
              judulDisplay(),
              inputBox(),
              tombol(),
              kartu(),
              Container(
                  alignment: Alignment.center,
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(100, 10, 150, 10),
                  child: ElevatedButton(
                      child: const Text('Tambah Lokasi'),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TambahLokasi()));
                      },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.amber,
                          textStyle: const TextStyle(
                            color: Colors.indigo,
                          )))),
            ],
          )),
    );
  }

  Widget judulDisplay() => Container(
        alignment: Alignment.center,
        child: const Text("Cari Lokasi Tes Covid-19",
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            )),
      );

  Widget inputBox() => Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.fromLTRB(100, 10, 150, 10),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: 'Masukkan Provinsi Lokasi',
            border: OutlineInputBorder(),
            contentPadding:
                EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          ),
          validator: (value) {
            if (value!.isEmpty) {
              return 'Enter anything';
            } else {
              return null;
            }
          },
          controller: _lokasiController,
          maxLength: 30,
        ),
      );

  Widget tombol() => Container(
      alignment: Alignment.center,
      height: 50,
      padding: const EdgeInsets.fromLTRB(100, 10, 150, 10),
      child: ElevatedButton(
          child: const Text('Cari'),
          onPressed: () {
            fetchLokasi();
          },
          style: ElevatedButton.styleFrom(
              primary: Colors.indigo,
              textStyle: const TextStyle(
                color: Colors.white,
              ))));

  Widget kartu() => SingleChildScrollView(
    physics: ScrollPhysics(),
    child: Column(
      children: <Widget>[
    ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: hasilSearch.length,
      itemBuilder: (BuildContext context, int index) {
        return buildCard(hasilSearch[index]);
      })]));

  Widget buildCard(data) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: <Widget>[
          Card(
              child: Container(
            color: Colors.indigo,
            padding: const EdgeInsets.fromLTRB(0, 30, 0, 10),
            alignment: Alignment.center,
            width: 200,
            child: Column(
              children: [
                Text(data['nama'],
                    style: TextStyle(
                      backgroundColor: Colors.amber,
                      color: Colors.indigo,
                    )),
                Container(
                    padding: const EdgeInsets.fromLTRB(7, 20, 7, 10),
                    alignment: Alignment.centerLeft,
                    child: Text('Alamat : ${data['alamat']}',
                        style: TextStyle(
                          height: 1,
                          color: Colors.white,
                        ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(7, 20, 7, 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                        'Jam Operasional : ${data['jam_buka']} - ${data['jam_tutup']}',
                        style: TextStyle(
                          height: 1,
                          color: Colors.white,
                        ))),
                Container(
                    padding: const EdgeInsets.fromLTRB(7, 20, 7, 10),
                    alignment: Alignment.centerLeft,
                    child: Text('No. Telepon : ${data['nomor']}',
                        style: TextStyle(
                          height: 1,
                          color: Colors.white,
                        ))),
              ],
            ),
          )),
        ],
      ),
    );
  }
}
