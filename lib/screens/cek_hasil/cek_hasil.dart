import 'package:flutter/material.dart';

class CekHasilPage extends StatefulWidget {
  const CekHasilPage({Key? key}) : super(key: key);
  @override
  State<CekHasilPage> createState() => _CekHasilPageState();
}

class _CekHasilPageState extends State<CekHasilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("CekHasil"),
        ),
        body: Center(child: Text("Cek Hasil Page")));
  }
}
