// ignore_for_file: implementation_imports, unused_import

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:slowlabapp/CookieRequest.dart';

import 'dart:convert';

import 'package:slowlabapp/screens/auth/register.dart';
import 'package:slowlabapp/screens/forum/forum.dart';
import 'package:slowlabapp/screens/home/home.dart';

import 'login.dart';
import 'profile.dart';

Future<http.Response> editUserProfile(String fullname, String bod, String phone,
    String province, String address) {
  return http.post(
    Uri.parse('https://slowlab-core.herokuapp.com/auth/flutter/profile/edit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8'
    },
    body: jsonEncode(<String, String>{
      'fullname': fullname,
      'bod': bod,
      'phone': phone,
      'province': province,
      'address': address,
    }),
  );
}

Future<List> getprovince(String uname) async {
  String url = "https://slowlab-core.herokuapp.com/auth/flutter/get_province";
  var response = await http.get(Uri.parse(url));
  // print(response.body);
  List provinceLst;
  provinceLst = json.decode(response.body)['allprovince'].toList();

  return provinceLst;
}

class ProfileData {
  late final String fullname;
  late final String bod;
  late final String phone;
  late final String province;
  late final String address;

  ProfileData({
    required this.fullname,
    required this.bod,
    required this.phone,
    required this.province,
    required this.address,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    String nama = "none";
    String tgllhr = "2002-12-24";
    String notlp = "none";
    String provinsi = "Aceh";
    String alamat = "none";

    if (json["fullname"] != null) {
      nama = json["fullname"];
    }
    if (json["bod"] != null) {
      tgllhr = json["bod"];
    }
    if (json["phone"] != null) {
      notlp = json["phone"];
    }
    if (json["province"] != null) {
      provinsi = json["province"];
    }
    if (json["address"] != null) {
      alamat = json["address"];
    }

    return ProfileData(
      fullname: nama,
      bod: tgllhr,
      phone: notlp,
      province: provinsi,
      address: alamat,
    );
  }
}

class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({Key? key}) : super(key: key);
  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();

  ProfileData profileData =
      ProfileData(fullname: "", bod: "", phone: "", province: "", address: "");

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final request = Provider.of<CookieRequest>(context, listen: false);
      request
          .get('https://slowlab-core.herokuapp.com/auth/flutter/profile')
          .then((value) {
        super.setState(() {
          profileData = ProfileData.fromJson(value);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = "Aceh";
    String fullname = "";
    String bod = "";
    String phone = "";
    String province = "";
    String address = "";

    return Scaffold(
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: SafeArea(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 730,
                          decoration: BoxDecoration(
                            color: Color(0xFF003566),
                            borderRadius: BorderRadius.circular(20),
                            shape: BoxShape.rectangle,
                          ),
                          alignment: AlignmentDirectional(0, 0),
                          child: Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(2, 0, 0, 0),
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      16, 5, 16, 10),
                                  child: Text(
                                    "Edit Profile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 32),
                                  ),
                                ),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Text("Full Name",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16))),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: TextFormField(
                                      initialValue: profileData.fullname,
                                      cursorColor: Color(0xFF003566),
                                      decoration: InputDecoration(
                                        hintText: "Full Name",
                                        hintStyle:
                                            TextStyle(color: Color(0xFF003566)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.person,
                                          color: Color(0xFF003566),
                                        ),
                                      ),
                                      validator: (fullNameEntry) {
                                        if (fullNameEntry!.isEmpty) {
                                          return 'Nama Tidak boleh kosong';
                                        }
                                        fullname = fullNameEntry;
                                        return null;
                                      },
                                    )),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Text("Tanggal Lahir",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16))),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: TextFormField(
                                      initialValue: profileData.bod,
                                      cursorColor: Color(0xFF003566),
                                      decoration: InputDecoration(
                                        hintText: "YYYY-MM-DD",
                                        hintStyle:
                                            TextStyle(color: Color(0xFF003566)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.calendar_today,
                                          color: Color(0xFF003566),
                                        ),
                                      ),
                                      validator: (tglLhrEntry) {
                                        if (tglLhrEntry!.isEmpty) {
                                          return 'Tanggal Lahir Tidak boleh kosong';
                                        }
                                        bod = tglLhrEntry;
                                        return null;
                                      },
                                    )),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Text("Phone",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16))),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: TextFormField(
                                      initialValue: profileData.phone,
                                      cursorColor: Color(0xFF003566),
                                      decoration: InputDecoration(
                                        hintText: "No Telephone",
                                        hintStyle:
                                            TextStyle(color: Color(0xFF003566)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.phone,
                                          color: Color(0xFF003566),
                                        ),
                                      ),
                                      validator: (phoneEntry) {
                                        if (phoneEntry!.isEmpty) {
                                          return 'Phone Tidak boleh kosong';
                                        }
                                        phone = phoneEntry;
                                        return null;
                                      },
                                    )),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Text("Province",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16))),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      20, 5, 20, 5),
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: DropdownButton<String>(
                                        value: dropdownValue,
                                        underline: SizedBox(),
                                        onChanged: (String? newValue) {
                                          setState(() {
                                            dropdownValue = newValue!;
                                          });
                                        },
                                        items: <String>[
                                          "Aceh",
                                          "Sumatera Utara",
                                          "Sumatera Selatan",
                                          "Sumatera Barat",
                                          "Bengkulu",
                                          "Riau",
                                          "Kepulauan Riau",
                                          "Jambi",
                                          "Lampung",
                                          "Bangka Belitung",
                                          "Kalimantan Barat",
                                          "Kalimantan Timur",
                                          "Kalimantan Selatan",
                                          "Kalimantan Tengah",
                                          "Kalimantan Utara",
                                          "Banten",
                                          "DKI Jakarta",
                                          "Jawa Barat",
                                          "Jawa Tengah",
                                          "DI Yogyakarta",
                                          "Jawa Timur",
                                          "Bali",
                                          "Nusa Tenggara Timur",
                                          "Nusa Tenggara Barat",
                                          "Gorontalo",
                                          "Sulawesi Barat",
                                          "Sulawesi Tengah",
                                          "Sulawesi Utara",
                                          "Sulawesi Tenggara",
                                          "Sulawesi Selatan",
                                          "Maluku Utara",
                                          "Maluku",
                                          "Papua Barat",
                                          "Papua"
                                        ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList()),
                                  ),
                                ),

                                // Padding(
                                //   padding: EdgeInsetsDirectional.fromSTEB(
                                //       20, 5, 20, 5),
                                //   child: DropdownButton<String>(
                                //     value: dropdownValue,
                                //     icon: const Icon(Icons.arrow_downward),
                                //     elevation: 16,
                                //     style: const TextStyle(
                                //         color: Colors.deepPurple),
                                //     underline: Container(
                                //       height: 2,
                                //       color: Colors.deepPurpleAccent,
                                //     ),
                                //     onChanged: (String? newValue) {
                                //       setState(() {
                                //         dropdownValue = newValue!;
                                //       });
                                //     },
                                //     items: <String>[
                                //       'Aceh',
                                //       'Sumatera Utara',
                                //       'Sumatera Selatan',
                                //       'Sumatera Barat',
                                //       'Bengkulu',
                                //       'Riau',
                                //       'Kepulauan Riau',
                                //       'Jambi',
                                //       'Lampung',
                                //       'Bangka Belitung',
                                //       'Kalimantan Barat',
                                //       'Bangka Belitung',
                                //       'Kalimantan Barat',
                                //       'Kalimantan Timur',
                                //       'Kalimantan Selatan',
                                //       'Kalimantan Tengah',
                                //       'Kalimantan Utara',
                                //       'Banten',
                                //       'DKI Jakarta',
                                //       'Jawa Barat',
                                //       'Jawa Tengah',
                                //       'DI Yogyakarta',
                                //       'Jawa Timur',
                                //       'Bali',
                                //       'Nusa Tenggara Timur',
                                //       'Nusa Tenggara Barat',
                                //       'Gorontalo',
                                //       'Sulawesi Barat',
                                //       'Sulawesi Tengah',
                                //       'Sulawesi Utara',
                                //       'Sulawesi Tenggara',
                                //       'Sulawesi Selatan',
                                //       'Maluku Utara',
                                //       'Maluku',
                                //       'Papua Barat',
                                //       'Papua'
                                //      ].map<DropdownMenuItem<String>>(
                                //         (String value) {
                                //       return DropdownMenuItem<String>(
                                //         value: value,
                                //         child: Text(value),
                                //       );
                                //     }).toList(),
                                //   ),
                                // child: FlutterFlowDropDown(
                                //   options: [
                                //     'Option 1dwdwa',
                                //     'dwadawd',
                                //     'dwadad'
                                //   ].toList(),
                                //   onChanged: (val) =>
                                //       setState(() => dropDownValue = val),
                                //   width: double.infinity,
                                //   height: 50,
                                //   textStyle:
                                //       FlutterFlowTheme.bodyText1.override(
                                //     fontFamily: 'Poppins',
                                //     color: Color(0xFF003566),
                                //   ),
                                //   icon: Icon(
                                //     Icons.location_city,
                                //     color: Color(0xFF003566),
                                //     size: 15,
                                //   ),
                                //   fillColor: Colors.white,
                                //   elevation: 2,
                                //   borderColor: Colors.transparent,
                                //   borderWidth: 0,
                                //   borderRadius: 20,
                                //   margin: EdgeInsetsDirectional.fromSTEB(
                                //       12, 4, 12, 4),
                                //   hidesUnderline: true,
                                // ),
                                // ),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Text("Address",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16))),
                                Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: TextFormField(
                                      initialValue: profileData.address,
                                      cursorColor: Color(0xFF003566),
                                      decoration: InputDecoration(
                                        hintText: "Address",
                                        hintStyle:
                                            TextStyle(color: Color(0xFF003566)),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.white,
                                            width: 1,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                        filled: true,
                                        fillColor: Colors.white,
                                        prefixIcon: Icon(
                                          Icons.home,
                                          color: Color(0xFF003566),
                                        ),
                                      ),
                                      validator: (addressEntry) {
                                        if (addressEntry!.isEmpty) {
                                          return 'Address Tidak boleh kosong';
                                        }
                                        address = addressEntry;
                                        return null;
                                      },
                                    )),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: SizedBox(
                                      height: 40, //height of button
                                      width: double.infinity, //width of button
                                      child: ElevatedButton(
                                          child: Text(
                                            "Confirm Edit",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xFFFFC300),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          onPressed: () async {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              _formKey.currentState!.save();
                                              final request =
                                                  Provider.of<CookieRequest>(
                                                      context,
                                                      listen: false);
                                              request
                                                  .post(
                                                      "https://slowlab-core.herokuapp.com/auth/flutter/profile/edit",
                                                      jsonEncode(<String,
                                                          String>{
                                                        'fullname': fullname,
                                                        'bod': bod,
                                                        'phone': phone,
                                                        'province': province,
                                                        'address': address,
                                                      }))
                                                  .then(
                                                      (value) => Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        ProfilePage()),
                                                          ));
                                            }
                                          }),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 20, 20, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 0, 0, 0),
                                          child: SizedBox(
                                            height: 30, //height of button
                                            width: 100, //width of button
                                            child: ElevatedButton(
                                                child: Text(
                                                  "Back",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                    primary: Color(0xFFFFC300),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20))),
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) {
                                                        return ProfilePage();
                                                      },
                                                    ),
                                                  );
                                                }),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )))));
  }
}
