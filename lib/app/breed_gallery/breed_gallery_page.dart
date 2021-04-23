import 'package:flutter/material.dart';

import '../../domain/models/breed.dart';
import '../shared/responsive_builder.dart';
import 'breed_gallery_store.dart';
import 'widgets/gallery_desktop_content.dart';
import 'widgets/gallery_mobile_content.dart';

class BreedGalleryPage extends StatefulWidget {
  final Breed breed;
  final String imagePath;

  const BreedGalleryPage(
      {Key? key, required this.breed, required this.imagePath})
      : super(key: key);

  @override
  _BreedGalleryPageState createState() => _BreedGalleryPageState();
}

class _BreedGalleryPageState extends State<BreedGalleryPage> {
  late final BreedGalleryStore store;
  late final ScrollController scrollCtrl;

  @override
  void initState() {
    super.initState();

    store = BreedGalleryStore(breed: widget.breed);
    store.loadTenNewImages();

    scrollCtrl = ScrollController();
    scrollCtrl.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent) {
      store.loadTenNewImages();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      mobile: GalleryMobileContent(
          breed: widget.breed,
          imagePath: widget.imagePath,
          store: store,
          scrollCtrl: scrollCtrl),
      desktop: GalleryDesktopContent(
          breed: widget.breed,
          imagePath: widget.imagePath,
          store: store,
          scrollCtrl: scrollCtrl),
    );
  }
}
