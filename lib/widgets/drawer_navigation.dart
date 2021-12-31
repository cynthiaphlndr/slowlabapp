// ignore_for_file: implementation_imports, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:slowlabapp/CookieRequest.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String login_check(request) {
  if (request.loggedIn) {
    return "Profile";
  } else {
    return "Login";
  }
}

Future<List> getuname(String uname) async {
  String url = "https://slowlab-core.herokuapp.com/auth/flutter/get_province";
  var response = await http.get(Uri.parse(url));

  List provinceLst;
  provinceLst = json.decode(response.body)['allprovince'].toList();

  return provinceLst;
}


class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Drawer(
      child: ListView(
        children: [
          const UserAccountsDrawerHeader(
            accountName: Text("Reyhan Ariq Syahalam"),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://pbs.twimg.com/profile_images/1451093046976651266/lTGfergv_400x400.jpg"),
            ),
            accountEmail: Text("ariq.syahalam@gmail.com"),
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.person,
            title: login_check(request),
            onTilePressed: () {
              Navigator.pop(context);
              if (request.loggedIn) {
                Navigator.pushNamed(context, '/profile');
              } else {
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.bookmarks,
            title: "Booking",
            onTilePressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/booking');
            },
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.grading,
            title: "Cek Hasil",
            onTilePressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/cek-hasil');
            },
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.format_list_bulleted,
            title: "Forum",
            onTilePressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/forum');
            },
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.place,
            title: "Lokasi Tes",
            onTilePressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/lokasi-tes');
            },
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.category,
            title: "Product List",
            onTilePressed: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/product-list');
            },
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  final IconData iconData;
  final String title;
  final VoidCallback onTilePressed;

  const DrawerListTile({
    Key? key,
    required this.iconData,
    required this.title,
    required this.onTilePressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTilePressed,
      dense: true,
      leading: Icon(iconData),
      title: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
