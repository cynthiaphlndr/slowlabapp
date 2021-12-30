import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CekHasilPage extends StatefulWidget {
  const CekHasilPage({Key? key}) : super(key: key);
  @override
  State<CekHasilPage> createState() => _CekHasilPageState();
}

class _CekHasilPageState extends State<CekHasilPage> {
  @override
  String _name="";
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Result> _results = [];
  List<Result> _resultsForDisplay = [];

  fetchData() async {
    const url = 'https://slowlab-core.herokuapp.com/cek-hasil/api/result/';
    final response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    List<Result> results = [];

    for (var u in jsonData) {
      Result result = Result(u['cek_no_test'], u['status'], u['nama'], u['no_ktp'], u['tanggal_tes']);
      results.add(result);
    }
    return results;
  }

  @override
  void initState() {
    fetchData().then((value) {
      setState((){
        _results.addAll(value);
        _resultsForDisplay = _results;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text("Cek Hasil Pemeriksaan Covid-19"),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return index == 0 ? _searchBar() : _listItem(index-1);
        },
        itemCount: _resultsForDisplay.length+1,
      )
    );
  }

  _searchBar() {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15)
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Masukkan nomor pemeriksaan...',
          border: InputBorder.none,
          suffixIcon: Icon(Icons.search),
          // color: Colors.grey, 
          // fontSize:17,
          contentPadding: EdgeInsets.all(15)
        ),

        onChanged: (text) {
          setState(() {
            _resultsForDisplay = _results.where((result) {
              var resultID = result.cek_no_test.toString();
              return resultID.contains(text);
            }).toList();
          });
        },
      ),
    );
  }

  _listItem(index) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft:  Radius.circular(10), bottomRight:  Radius.circular(10))),
      child: Padding(
        padding: const EdgeInsets.only(top: 25.0, bottom: 25.0, left: 16.0, right: 16.0),
        child: Column(
          children: <Widget>[ 
            Text(
              _resultsForDisplay[index].status,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Divider(
              color: Colors.black,
            ),
            Text(
              _resultsForDisplay[index].nama,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),  
            Text(
              'No KTP: ' + (_resultsForDisplay[index].no_ktp.toString()),
              style: TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              'Tanggal Tes: ' + (_resultsForDisplay[index].tanggal_tes.toString()),
              style: TextStyle(
                fontSize: 15,
              ),
              
            ),
          ],
        ),  
      )
    );
  }
}

class Result {
  final String status, nama, tanggal_tes;
  final int cek_no_test, no_ktp;

  Result(this.cek_no_test, this.status, this.nama, this.no_ktp, this.tanggal_tes);
}