import 'package:flutter/material.dart';

import '../../../domain/models/breed.dart';
import '../breed_gallery_store.dart';
import 'gallery_desktop_sidebar.dart';
import 'gallery_grid_content.dart';

class GalleryDesktopContent extends StatelessWidget {
  final Breed breed;
  final String imagePath;
  final BreedGalleryStore store;
  final ScrollController scrollCtrl;

  const GalleryDesktopContent({
    Key? key,
    required this.breed,
    required this.imagePath,
    required this.store,
    required this.scrollCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          GalleryDesktopSidebar(
            breed: breed,
            imagePath: imagePath,
            store: store,
            scrollCtrl: scrollCtrl,
          ),
          Expanded(
            child: CustomScrollView(
              controller: scrollCtrl,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [GalleryGridContent(store: store)],
            ),
          )
        ],
      ),
    );
  }
}
