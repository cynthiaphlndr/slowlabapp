import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:slowlabapp/screens/booking/booking.dart';
import 'package:slowlabapp/screens/cek_hasil/cek_hasil.dart';
import 'package:slowlabapp/screens/forum/forum.dart';
import 'package:slowlabapp/screens/home/home.dart';
import 'package:slowlabapp/screens/lokasi_tes/lokasi_tes.dart';
import 'package:slowlabapp/screens/product_list/product_list.dart';

class RouteGenerator {
  String selectedUrl = 'https://flutter.io';
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/booking':
        return MaterialPageRoute(builder: (_) => BookingPage());
      case '/cek-hasil':
        return MaterialPageRoute(builder: (_) => CekHasilPage());
      case '/forum':
        return MaterialPageRoute(builder: (_) => ForumPage());
      case '/lokasi-tes':
        return MaterialPageRoute(builder: (_) => LokasiTesPage());
      case '/product-list':
        return MaterialPageRoute(builder: (_) => ProductListPage());
      case '/booking-form':
        return MaterialPageRoute(
            builder: (_) => WebviewScaffold(
                  url: 'https://flutter.io',
                  mediaPlaybackRequiresUserGesture: false,
                  appBar: AppBar(
                    title: const Text('Widget WebView'),
                  ),
                  withZoom: true,
                  withLocalStorage: true,
                  hidden: true,
                  initialChild: Container(
                    color: Colors.redAccent,
                    child: const Center(
                      child: Text('Waiting.....'),
                    ),
                  ),
                ));
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: Text("Error")),
        body: Center(child: Text('Error page')),
      );
    });
  }
}
