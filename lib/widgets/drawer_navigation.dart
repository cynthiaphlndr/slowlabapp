import 'package:flutter/material.dart';

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
            onTilePressed: () {},
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.grading,
            title: "Cek Hasil",
            onTilePressed: () {},
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.format_list_bulleted,
            title: "Forum",
            onTilePressed: () {},
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.place,
            title: "Lokasi Tes",
            onTilePressed: () {},
          ),
          DrawerListTile(
            key: null,
            iconData: Icons.category,
            title: "Product List",
            onTilePressed: () {},
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
