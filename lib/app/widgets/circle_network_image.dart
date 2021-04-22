import 'package:flutter/material.dart';

class CircleNetworkImage extends StatelessWidget {
  final String imagePath;
  final String placeholderPath;

  const CircleNetworkImage({
    Key? key,
    required this.imagePath,
    this.placeholderPath = "assets/graphics/paw.png",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: AspectRatio(
        aspectRatio: 1,
        child: Hero(
          tag: imagePath,
          child: FadeInImage(
            fit: BoxFit.cover,
            placeholder: AssetImage(placeholderPath),
            image: NetworkImage(imagePath),
          ),
        ),
      ),
    );
  }
}
