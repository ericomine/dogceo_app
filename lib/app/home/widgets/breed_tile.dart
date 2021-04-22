import 'package:flutter/material.dart';

import '../../../domain/models/breed.dart';

class BreedTile extends StatelessWidget {
  final Breed breed;
  final String? image;

  const BreedTile({Key? key, required this.breed, this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Row(
        children: [
          if (image != null)
            Container(
              constraints: BoxConstraints(maxWidth: 50, maxHeight: 50),
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
          SizedBox(width: 15),
          Expanded(
              flex: 10,
              child: Text(breed.name,
                  style: Theme.of(context).textTheme.bodyText1)),
          Expanded(flex: 1, child: Icon(Icons.chevron_right)),
        ],
      ),
    );
  }
}