
import 'package:flutter/material.dart';
import 'package:serializable_pagination/screens/home_page.dart';
import 'package:serializable_pagination/screens/house.dart';
import 'package:serializable_pagination/screens/main_page.dart';

class GarryApp extends StatelessWidget {
  const GarryApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(useMaterial3: true,),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: const MainPage(),
    );
  }
}
