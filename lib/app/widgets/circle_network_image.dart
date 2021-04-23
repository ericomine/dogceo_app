import 'package:cached_network_image/cached_network_image.dart';
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
          child: FittedBox(
            fit: BoxFit.cover,
            child: CachedNetworkImage(
              imageUrl: imagePath!,
              placeholder: (_, __) => Image.asset("assets/graphics/paw.png"),
            ),
          ),
        ),
      ),
    );
  }
}
