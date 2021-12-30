import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);
  @override
  State<ForumPage> createState() => _ForumPageState();
}

class GetForum {
  int id = 0;
  String nama = "";
  String pertanyaan = "";
  String namaAdmin = "";
  String jawaban = "";

  GetForum(this.id, this.nama, this.pertanyaan, this.namaAdmin, this.jawaban);

  GetForum.fromJSON(Map<String, dynamic> json) {
    id = json['id'];
    nama = json['nama'];
    pertanyaan = json['pertanyaan'];
    namaAdmin = json['nama_admin'];
    jawaban = json['jawaban'];

    if (nama.isEmpty) {
      nama = "Anonim";
    }
  }
}

class _ForumPageState extends State<ForumPage> {
  final _forums = <GetForum>[];

  Future<List<GetForum>> fetchForum() async {
    var url = Uri.parse('https://slowlab-core.herokuapp.com/forum/getForum/');
    var response = await http.get(url);

    List<GetForum> forums = [];
    if (response.statusCode == 200) {
      var forumsJson = json.decode(response.body);
      for (var forumJson in forumsJson['forum']) {
        if (forumJson != null) {
          forums.add(GetForum.fromJSON(forumJson));
        }
      }
    }
    return forums;
  }

  @override
  void initState() {
    fetchForum().then((value) {
      setState(() {
        _forums.addAll(value);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Forum"),
        ),
        body:
        ListView.builder(
          itemBuilder: (context, index) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 3,
              margin: EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.chat_rounded,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            padding: new EdgeInsets.only(right: 13.0),
                            child: Text(
                              _forums[index].pertanyaan,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          _forums[index].nama,
                          style: TextStyle(color: Colors.grey.shade500),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.mark_chat_read_rounded,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            padding: EdgeInsets.only(right: 13.0),
                            child: Text(
                              _forums[index].jawaban,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Text(_forums[index].pertanyaan,
                    // style: TextStyle(
                    //   fontSize: 18,
                    // )),
                    // Text("- " + _forums[index].nama),
                    // Text(_forums[index].jawaban,
                    // style: TextStyle(
                    //   fontSize: 18,
                    // )),
                    // Text("- " + _forums[index].namaAdmin),
                  ],
                ),
              ),
            );
          },
          itemCount: _forums.length,
        ));
  }
}
