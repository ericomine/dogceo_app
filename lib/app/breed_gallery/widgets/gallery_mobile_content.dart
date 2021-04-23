import 'package:flutter/material.dart';

import '../../../domain/models/breed.dart';
import '../../share_image/share_image_service.dart';
import '../breed_gallery_store.dart';
import 'gallery_grid_content.dart';

class GalleryMobileContent extends StatelessWidget {
  final Breed breed;
  final String imagePath;
  final BreedGalleryStore store;
  final ScrollController scrollCtrl;

  final _shareImageService = ShareImageService();

  GalleryMobileContent({
    Key? key,
    required this.breed,
    required this.imagePath,
    required this.store,
    required this.scrollCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<bool>(
          valueListenable: _shareImageService,
          builder: (context, status, _) {
            return CustomScrollView(
              controller: scrollCtrl,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverAppBar(
                  title: Text(breed.name,
                      style: Theme.of(context).textTheme.headline6),
                  flexibleSpace: Hero(
                      tag: imagePath,
                      child: Image.network(imagePath, fit: BoxFit.cover)),
                  expandedHeight: 200,
                  floating: true,
                  pinned: true,
                ),
                if (status)
                  SliverToBoxAdapter(child: LinearProgressIndicator()),
                GalleryGridContent(
                  store: store,
                  onTapImage:
                      !status ? _shareImageService.shareImageFromUrl : null,
                ),
              ],
            );
          }),
    );
  }
}
