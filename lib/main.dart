import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:slowlabapp/CookieRequest.dart';
import 'package:slowlabapp/routes.dart';

void main() {
  runApp(Provider(
      create: (_) {
        CookieRequest request = CookieRequest();

        return request;
      },
      child: MaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        onGenerateRoute: RouteGenerator.generateRoute,
      )));
}
