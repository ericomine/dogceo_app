import 'package:flutter/material.dart';

import '../../../domain/models/breed.dart';
import '../../widgets/circle_network_image.dart';

class BreedCard extends StatelessWidget {
  final Breed breed;
  final String? image;
  final void Function()? onTap;

  const BreedCard({
    Key? key,
    required this.breed,
    this.image,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          if (image != null)
            Container(
              constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
              child: CircleNetworkImage(imagePath: image!),
            ),
          SizedBox(height: 10),
          Text(breed.name, style: Theme.of(context).textTheme.headline6)
        ],
      ),
    );
  }
}
