import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:slowlabapp/widgets/drawer_navigation.dart';
import 'package:http/http.dart' as http;

Future<Provinsi> getData(int i) async {
  final response =
      await http.get(Uri.parse('https://slowlab-core.herokuapp.com/getData/'));
  if (response.statusCode == 200) {
    // print(jsonDecode(response.body)[i]['fields']['name']);
    return Provinsi.fromJson(jsonDecode(response.body)[i]['fields']);
  } else {
    throw Exception('Failed to load provinsi');
  }
}

Future<List<Provinsi>> makeList() async {
  List<Provinsi> list = [];
  Provinsi temp;
  for (var i = 0; i < 34; i++) {
    temp = await getData(i);
    list.add(temp);
  }
  return Future.value(list);
}

class Provinsi {
  final String name;
  final String totalKasus;
  final String meninggal;
  final String sembuh;
  final String kasusAktif;
  final String lastDate;
  final String penambahanTK;
  final String penambahanM;
  final String penambahanS;
  final String penambahanKA;

  Provinsi({
    required this.name,
    required this.totalKasus,
    required this.meninggal,
    required this.sembuh,
    required this.kasusAktif,
    required this.lastDate,
    required this.penambahanTK,
    required this.penambahanM,
    required this.penambahanS,
    required this.penambahanKA,
  });

  factory Provinsi.fromJson(Map<String, dynamic> json) {
    // print(json);
    return Provinsi(
      name: json['name'],
      totalKasus: json['total_kasus'],
      meninggal: json['meninggal'],
      sembuh: json['sembuh'],
      kasusAktif: json['kasus_aktif'],
      lastDate: json['last_date'],
      penambahanTK: json['penambahan_tk'],
      penambahanM: json['penambahan_m'],
      penambahanS: json['penambahan_s'],
      penambahanKA: json['penambahan_ka'],
    );
  }
}

void main() => runApp(const HomePage());

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Provinsi>> futureProvinsi;
  Provinsi? _selected;
  String txt_T = 'jumlah';
  String txt_A = 'jumlah';
  String txt_S = 'jumlah';
  String txt_M = 'jumlah';

  @override
  void initState() {
    super.initState();
    futureProvinsi = makeList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
      ),
      drawer: DrawerNavigation(),
      body: SingleChildScrollView(
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/product-list');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 300,
                        child: Column(
                          children: const [
                            Expanded(
                              flex: 3,
                              child: Icon(
                                Icons.category,
                                size: 150,
                                color: Colors.green,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Product List',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Kami menawarkan layanan test-covid yang beragam untuk anda',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/lokasi-tes');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 300,
                        child: Column(
                          children: const [
                            Expanded(
                              flex: 3,
                              child: Icon(
                                Icons.place,
                                size: 150,
                                color: Colors.red,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Location',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Temukan lab kami yang terdekat dengan lokasi anda',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/forum');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 300,
                        child: Column(
                          children: const [
                            Expanded(
                              flex: 3,
                              child: Icon(
                                Icons.format_list_bulleted,
                                size: 150,
                                color: Colors.blue,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Forum',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Tanya jawab secara online dengan tim pakar kami',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: const EdgeInsets.all(10),
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, '/cek-hasil');
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        height: 300,
                        child: Column(
                          children: const [
                            Expanded(
                              flex: 3,
                              child: Icon(
                                Icons.grading,
                                size: 150,
                                color: Colors.yellow,
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Cek Hasil',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Sudah pernah menggunakan jasa kami? Cek hasil tes anda di sini',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.only(
                      left: 5,
                      right: 0,
                    ),
                    height: 30,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color.fromRGBO(0, 29, 61, 1)),
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromRGBO(0, 29, 61, 1)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Data Covid-19 Provinsi',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        // TODO: Diganti filter/search dropdown
                        // TODO: Basically semua yang kaya di django monkaS
                        Expanded(
                          child: FutureBuilder<List<Provinsi>>(
                            future: futureProvinsi,
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: DropdownButton(
                                    isExpanded: true,
                                    hint: Text(
                                      'Pilih Provinsi',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    value: _selected,
                                    icon: Icon(Icons.arrow_drop_down),
                                    elevation: 16,
                                    style: TextStyle(color: Colors.white),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _selected = newValue as Provinsi;
                                        txt_T = newValue.totalKasus;
                                        txt_A = newValue.kasusAktif;
                                        txt_S = newValue.sembuh;
                                        txt_M = newValue.meninggal;
                                      });
                                    },
                                    items: snapshot.data
                                        ?.map<DropdownMenuItem<Provinsi>>(
                                            (Provinsi value) {
                                      return DropdownMenuItem<Provinsi>(
                                        value: value,
                                        child: Text(
                                          value.name,
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                );
                              } else if (snapshot.hasError) {
                                return Text("${snapshot.error}");
                              }
                              return Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white,
                                  ),
                                  child: Text('Loading...'));
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.redAccent,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Terkonfirmasi',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            txt_T,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.yellow[300],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Kasus aktif',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            txt_A,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green[400],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Sembuh',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            txt_S,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 10,
                      right: 10,
                      bottom: 10,
                    ),
                    padding: const EdgeInsets.all(5),
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[400],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            'Meninggal',
                          ),
                        ),
                        Expanded(
                          child: Text(
                            txt_M,
                            style: TextStyle(
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
