import 'package:flutter/material.dart';
import 'package:flutter_wioso/const.dart';
import 'package:flutter_wioso/screens/mapScreen.dart';
import 'package:flutter_wioso/screens/singScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Wioso',
      theme: ThemeData(
        primaryColor: primaryColor,
        colorScheme: ThemeData().colorScheme.copyWith(
              primary: primaryColor,
            ),
      ),
      home: const MapScreen(),
    );
  }
}
