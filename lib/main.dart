// import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:FlutterMedia/util/route_generator.dart';

void main() {
  runApp(FlutterMedia());
}

class FlutterMedia extends StatelessWidget {
  const FlutterMedia({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}
