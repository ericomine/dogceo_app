import 'package:flutter/material.dart';

import 'home/home_page.dart';
import 'theme_builder.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Dog CEO",
      debugShowCheckedModeBanner: false,
      theme: ThemeBuilder.build(),
      home: HomePage(),
    );
  }
}
