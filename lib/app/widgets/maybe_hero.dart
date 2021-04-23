import 'package:flutter/material.dart';

class MaybeHero extends StatelessWidget {
  final String? heroTag;
  final Widget child;

  const MaybeHero({Key? key, this.heroTag, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (heroTag == null) return child;
    return Hero(tag: heroTag!, child: child);
  }
}
