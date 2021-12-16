import 'package:flutter/material.dart';
import 'package:slowlabapp/screens/booking/booking.dart';
import 'package:slowlabapp/screens/cek_hasil/cek_hasil.dart';
import 'package:slowlabapp/screens/forum/forum.dart';
import 'package:slowlabapp/screens/lokasi_tes/lokasi_tes.dart';
import 'package:slowlabapp/screens/product_list/product_list.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({Key? key}) : super(key: key);

  @override
  _DrawerNavigationState createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {
  @override
  Widget build(BuildContext context) {
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
