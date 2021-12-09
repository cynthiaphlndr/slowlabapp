import 'package:flutter/material.dart';

class LokasiTesPage extends StatefulWidget {
  const LokasiTesPage({Key? key}) : super(key: key);
  @override
  State<LokasiTesPage> createState() => _LokasiTesPageState();
}

class _LokasiTesPageState extends State<LokasiTesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("LokasiTes"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: const <Widget>[Text("LokasiTes")],
          ),
        ),
      ),
    );
  }
}
