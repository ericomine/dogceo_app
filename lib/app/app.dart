import 'package:flutter/material.dart';

import 'router.gr.dart';
import 'theme_builder.dart';

class App extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Dog CEO",
      debugShowCheckedModeBanner: false,
      theme: ThemeBuilder.build(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
