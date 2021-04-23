import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../domain/models/breed.dart';
import '../../widgets/circle_network_image.dart';
import '../breed_gallery_store.dart';

class GalleryDesktopSidebar extends StatelessWidget {
  final Breed breed;
  final String imagePath;
  final BreedGalleryStore store;
  final ScrollController scrollCtrl;

  const GalleryDesktopSidebar({
    Key? key,
    required this.breed,
    required this.imagePath,
    required this.store,
    required this.scrollCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 100, maxWidth: 200),
      padding: const EdgeInsets.all(20),
      color: Theme.of(context).primaryColor,
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text("${breed.name}",
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(color: Theme.of(context).accentColor)),
        ),
        CircleNetworkImage(
          heroTag: imagePath,
          imagePath: imagePath,
        ),
        ListTile(
          title: Text("go back"),
          trailing: Icon(Icons.chevron_left),
          onTap: () => AutoRouter.of(context).pop(),
        ),
      ]),
    );
  }
}
