import 'package:flutter/material.dart';
import 'package:slowlabapp/routes.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primarySwatch: Colors.green,
    ),
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
