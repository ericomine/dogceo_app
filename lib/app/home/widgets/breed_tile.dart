import 'package:flutter/material.dart';

import '../../../domain/models/breed.dart';
import '../../widgets/circle_network_image.dart';

class BreedTile extends StatelessWidget {
  final Breed breed;
  final String? image;
  final void Function(Breed)? onTap;

  const BreedTile({Key? key, required this.breed, this.image, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap?.call(breed),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Row(
          children: [
            Container(
              constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
              child: CircleNetworkImage(heroTag: image, imagePath: image),
            ),
            SizedBox(width: 15),
            Expanded(
                flex: 10,
                child: Text(breed.name,
                    style: Theme.of(context).textTheme.bodyText1)),
            Expanded(flex: 1, child: Icon(Icons.chevron_right)),
          ],
        ),
      ),
    );
  }
}
