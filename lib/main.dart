import 'package:flutter/material.dart';
import 'package:slowlabapp/routes.dart';

void main() {
  runApp(MaterialApp(
    onGenerateRoute: RouteGenerator.generateRoute,
  ));
}
