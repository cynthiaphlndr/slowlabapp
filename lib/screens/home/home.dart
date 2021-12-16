import 'package:flutter/material.dart';
import 'package:slowlabapp/widgets/drawer_navigation.dart';
import '../auth/auth.dart';
import '../booking/booking.dart';
import '../cek_hasil/cek_hasil.dart';
import '../forum/forum.dart';
import '../lokasi_tes/lokasi_tes.dart';
import '../product_list/product_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Home"),
        ),
        drawer: DrawerNavigation(),
        body: Center(child: Text("Home Page")));
  }
}
