import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TambahLokasi extends StatefulWidget {
  const TambahLokasi({Key? key}) : super(key: key);
  @override
  State<TambahLokasi>  createState() => _TambahLokasi();
}

class _TambahLokasi extends State<TambahLokasi> {
  final formKey = GlobalKey<FormState>();
  String namaLokasi = '';
  String provinsiLokasi = '';
  String alamatLokasi = '';
  String nomor = '';

  static List<String> hourList = List<String>.generate(24, (int index) {
    if (index < 10){
      return '0$index.00';}
    else{
      return '$index.00';}
  });
  List<DropdownMenuItem> hourItemList = hourList
      .map((val) => DropdownMenuItem(value: val, child: Text(val)))
      .toList();
  String jamBuka = hourList[0];
  String jamTutup = hourList[0];
  bool flag = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("Tambah Lokasi"),
          backgroundColor: Colors.indigo,
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
            children: [
              inputNama(),
              const SizedBox(height: 16),
              inputProvinsi(),
              const SizedBox(height: 16),
              inputAlamat(),
              const SizedBox(height: 16),
              inputJamBuka(),
              inputJamTutup(),
              inputNomor(),
              const SizedBox(height: 16),
              inputTombol(),
            ],
          ),
        ),
      );
  Widget inputNama() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Nama Lokasi',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter anything';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => namaLokasi = value!),
      );

  Widget inputProvinsi() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Provinsi Lokasi',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter anything';
          } else {
            return null;
          }
        },
        maxLength: 30,
        onSaved: (value) => setState(() => provinsiLokasi = value!),
      );

  Widget inputAlamat() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Alamat Lokasi',
          border: OutlineInputBorder(),
        ),
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter anything';
          } else {
            return null;
          }
        },
        maxLength: 200,
        onSaved: (value) => setState(() => alamatLokasi = value!),
      );

  Widget inputJamBuka() => InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        counter: Container(
          height: 10,
        ),
      ),
      child: DropdownButton<dynamic>(
        value: jamBuka,
        onChanged: (val) => setState(() => jamBuka = (val.toString())),
        items: hourItemList,
      ));

  Widget inputJamTutup() => InputDecorator(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        counter: Container(
          height: 10,
        ),
      ),
      child: DropdownButton<dynamic>(
        value: jamTutup,
        onChanged: (val) => setState(() => jamTutup = (val.toString())),
        items: hourItemList,
      ));

  Widget inputNomor() => TextFormField(
        decoration: InputDecoration(
          labelText: 'Nomor Lokasi',
          border: OutlineInputBorder(),
        ),
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        validator: (value) {
          if (value!.isEmpty) {
            return 'Enter anything';
          } else {
            return null;
          }
        },
        maxLength: 15,
        onSaved: (value) => setState(() => nomor = value!),
      );

  Widget inputTombol() => ElevatedButton(
      child: Text("Tambah Lokasi"),
      onPressed: () async {
        final isValid = formKey.currentState!.validate();
        if (isValid) {
          formKey.currentState!.save();
        }
        {
          const url = "https://slowlab-core.herokuapp.com/lokasi/add_data/";
          final response = await http.post(Uri.parse(url),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{
                'nama': namaLokasi,
                'provinsi': provinsiLokasi,
                'alamat': alamatLokasi,
                'jam_buka': jamBuka,
                'jam_tutup': jamTutup,
                'nomor': nomor,
              }));
          Map<String, dynamic> tes = jsonDecode(response.body);
          if (tes['hasil'] == 'lokasi gagal') {
            showDialog(context: context, builder: (BuildContext context){
            return AlertDialog(
              title: Text("Gagal menambahkan lokasi"),
              content: Text("Nama atau Alamat lokasi telah terdaftar"),
            );})
            ;
          } else {
            Navigator.pop(context);
          }
        }
      },
      style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
          textStyle: const TextStyle(
            color: Colors.white,
          )));
}
