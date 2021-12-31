// ignore_for_file: unused_import, implementation_imports, unused_local_variable

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/src/provider.dart';
import 'package:slowlabapp/CookieRequest.dart';

import 'dart:convert';

import 'package:slowlabapp/screens/auth/register.dart';
import 'package:slowlabapp/screens/forum/forum.dart';
import 'package:slowlabapp/screens/home/home.dart';

import 'login.dart';
import 'profile_edit.dart';

class ProfileData {
  final String fullname;
  final String bod;
  final String phone;
  final String province;
  final String address;

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

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    Size size = MediaQuery.of(context).size;
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: Center(
            child: SingleChildScrollView(
                child: Form(
                    key: _formKey,
                    child: SafeArea(
                      child: Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: 450,
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
                                    "Profile",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 32),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30, //height of button
                                          width: 120, //width of button
                                          child: Text(
                                            "Nama Lengkap",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            profileData.fullname,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30, //height of button
                                          width: 120, //width of button
                                          child: Text(
                                            "Tanggal Lahir",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            profileData.bod,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30, //height of button
                                          width: 120, //width of button
                                          child: Text(
                                            "Phone",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            profileData.phone,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30, //height of button
                                          width: 120, //width of button
                                          child: Text(
                                            "Province",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            profileData.province,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 30, //height of button
                                          width: 120, //width of button
                                          child: Text(
                                            "address",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        ),
                                        Flexible(
                                          child: Text(
                                            profileData.address,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 5, 20, 5),
                                    child: SizedBox(
                                      height: 30, //height of button
                                      width: double.infinity, //width of button
                                      child: ElevatedButton(
                                          child: Text(
                                            "Edit Profile",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xFFFFC300),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return ProfileEditPage();
                                                },
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        20, 15, 20, 5),
                                    child: SizedBox(
                                      height: 30, //height of button
                                      width: double.infinity, //width of button
                                      child: ElevatedButton(
                                          child: Text(
                                            "Logout",
                                            style:
                                                TextStyle(color: Colors.black),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                              primary: Color(0xFFff4400),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20))),
                                          onPressed: () {
                                            request.loggedIn = false;
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) {
                                                  return HomePage();
                                                },
                                              ),
                                            );
                                          }),
                                    ),
                                  ),
                                ),
                                // Align(
                                //   alignment: AlignmentDirectional(0, 0),
                                //   child: Padding(
                                //     padding: EdgeInsetsDirectional.fromSTEB(
                                //         20, 20, 20, 0),
                                //     child: Row(
                                //       mainAxisSize: MainAxisSize.max,
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       crossAxisAlignment:
                                //           CrossAxisAlignment.center,
                                //       children: [
                                //         Text(
                                //           "Don't have an account?  ",
                                //           style: TextStyle(color: Colors.white),
                                //         ),
                                //         Padding(
                                //           padding:
                                //               EdgeInsetsDirectional.fromSTEB(
                                //                   20, 0, 0, 0),
                                //           child: SizedBox(
                                //             height: 30, //height of button
                                //             width: 100, //width of button
                                //             child: ElevatedButton(
                                //                 child: Text(
                                //                   "Sign up",
                                //                   style: TextStyle(
                                //                       color: Colors.black),
                                //                 ),
                                //                 style: ElevatedButton.styleFrom(
                                //                     primary: Color(0xFFFFC300),
                                //                     shape:
                                //                         RoundedRectangleBorder(
                                //                             borderRadius:
                                //                                 BorderRadius
                                //                                     .circular(
                                //                                         20))),
                                //                 onPressed: () {
                                //                   Navigator.push(
                                //                     context,
                                //                     MaterialPageRoute(
                                //                       builder: (context) {
                                //                         return RegisterPage();
                                //                       },
                                //                     ),
                                //                   );
                                //                 }),
                                //           ),
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )))));
  }
}
