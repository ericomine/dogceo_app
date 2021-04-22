import 'package:flutter/material.dart';

import '../../../domain/models/breed.dart';

class BreedCard extends StatelessWidget {
  final Breed breed;
  final String? image;

  const BreedCard({Key? key, required this.breed, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (image != null)
          Container(
            constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: ClipOval(
              child: AspectRatio(
                aspectRatio: 1,
                child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder: AssetImage("assets/graphics/paw.png"),
                  image: NetworkImage(image!),
                ),
              ),
            ),
          ),
        Text(breed.name)
      ],
    );
  }
}
