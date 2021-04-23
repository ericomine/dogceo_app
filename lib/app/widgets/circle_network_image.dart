import 'package:flutter/material.dart';

import 'maybe_hero.dart';

class CircleNetworkImage extends StatelessWidget {
  final String? heroTag;
  final String? imagePath;
  final String placeholderPath;

  const CircleNetworkImage({
    Key? key,
    this.heroTag,
    this.imagePath,
    this.placeholderPath = "assets/graphics/paw.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaybeHero(
      heroTag: heroTag,
      child: ClipOval(
        child: AspectRatio(
          aspectRatio: 1,
          child: imagePath != null
              ? Image.network(imagePath!, fit: BoxFit.cover,
                  loadingBuilder: (_, child, progress) {
                  if (progress == null) return child;
                  return Image.asset("assets/graphics/paw.png");
                })
              : Image.asset("assets/graphics/paw.png"),
        ),
      ),
    );
  }
}
