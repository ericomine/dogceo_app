import 'package:flutter/material.dart';

import '../../domain/models/breed.dart';
import '../widgets/circle_network_image.dart';
import 'breed_gallery_store.dart';

class BreedGalleryPage extends StatefulWidget {
  final Breed breed;

  const BreedGalleryPage({Key? key, required this.breed}) : super(key: key);

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
    return Scaffold(
      body: CustomScrollView(
        controller: scrollCtrl,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            title: Text(widget.breed.name,
                style: Theme.of(context).textTheme.headline6),
            flexibleSpace: CircleNetworkImage(
              imagePath: widget.breed.name,
            ),
          ),
          SliverGrid.count(
            crossAxisCount: 2,
            crossAxisSpacing: 200,
            childAspectRatio: 1,
            children: [],
          ),
        ],
      ),
    );
  }
}
