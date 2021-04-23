import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../domain/models/breed.dart';
import '../shared/responsive_builder.dart';
import '../widgets/circle_network_image.dart';
import 'breed_gallery_store.dart';

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
      mobile: MobileContent(
          breed: widget.breed,
          imagePath: widget.imagePath,
          store: store,
          scrollCtrl: scrollCtrl),
      desktop: DesktopContent(
          breed: widget.breed,
          imagePath: widget.imagePath,
          store: store,
          scrollCtrl: scrollCtrl),
    );
  }
}

class MobileContent extends StatelessWidget {
  final Breed breed;
  final String imagePath;
  final BreedGalleryStore store;
  final ScrollController scrollCtrl;

  const MobileContent({
    Key? key,
    required this.breed,
    required this.imagePath,
    required this.store,
    required this.scrollCtrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: scrollCtrl,
        physics: AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverAppBar(
            title:
                Text(breed.name, style: Theme.of(context).textTheme.headline6),
            flexibleSpace: Hero(
              tag: imagePath,
              child: Image.network(imagePath, fit: BoxFit.cover),
            ),
            expandedHeight: 200,
            floating: true,
            pinned: true,
          ),
          GridContent(store: store),
        ],
      ),
    );
  }
}

class DesktopContent extends StatelessWidget {
  final Breed breed;
  final String imagePath;
  final BreedGalleryStore store;
  final ScrollController scrollCtrl;

  const DesktopContent({
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
          DesktopSidebar(
            breed: breed,
            imagePath: imagePath,
            store: store,
            scrollCtrl: scrollCtrl,
          ),
          Expanded(
            child: CustomScrollView(
              controller: scrollCtrl,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [GridContent(store: store)],
            ),
          )
        ],
      ),
    );
  }
}

class DesktopSidebar extends StatelessWidget {
  final Breed breed;
  final String imagePath;
  final BreedGalleryStore store;
  final ScrollController scrollCtrl;

  const DesktopSidebar({
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

class GridContent extends StatelessWidget {
  final BreedGalleryStore store;

  const GridContent({Key? key, required this.store}) : super(key: key);

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
                child: CircleNetworkImage(imagePath: store.images[index]),
              )),
          childCount: store.images.length,
        ),
      );
    });
  }
}
