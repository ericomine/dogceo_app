import 'package:flutter/material.dart';

import 'home/home_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dog CEO",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
