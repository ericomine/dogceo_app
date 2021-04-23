import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../breed_gallery_store.dart';
import 'actionable_image.dart';

class GalleryGridContent extends StatelessWidget {
  final BreedGalleryStore store;
  final void Function(String)? onTapImage;

  const GalleryGridContent({Key? key, required this.store, this.onTapImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (_) {
      return SliverGrid(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 300,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => Container(
            constraints: BoxConstraints(maxWidth: 200, maxHeight: 200),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ActionableImage(
                  onShareImage: onTapImage, imagePath: store.images[index]),
            ),
          ),
          childCount: store.images.length,
        ),
      );
    });
  }
}
