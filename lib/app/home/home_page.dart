import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../shared/responsive_builder.dart';
import 'home_store.dart';
import 'widgets/breed_card.dart';
import 'widgets/breed_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomeStore store;
  late ScrollController scrollCtrl;

  @override
  void initState() {
    super.initState();

    store = HomeStore();
    store.loadTenNewBreeds();

    scrollCtrl = ScrollController();
    scrollCtrl.addListener(scrollListener);
  }

  void scrollListener() {
    if (scrollCtrl.position.pixels == scrollCtrl.position.maxScrollExtent) {
      store.loadTenNewBreeds();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Breeds")),
      body: Builder(
        builder: (context) {
          if (store.errorMessage.isNotEmpty) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(store.errorMessage)));
          }

          return ResponsiveBuilder(
            mobile: MobileContent(store: store, scrollCtrl: scrollCtrl),
            desktop: DesktopContent(store: store, scrollCtrl: scrollCtrl),
          );
        },
      ),
    );
  }
}

class MobileContent extends StatelessWidget {
  final HomeStore store;
  final ScrollController scrollCtrl;

  const MobileContent({Key? key, required this.store, required this.scrollCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          if (store.loading) return LinearProgressIndicator();
          return SizedBox(height: 1);
        }),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Observer(
              builder: (context) {
                return ListView.builder(
                  controller: scrollCtrl,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: store.breeds.length,
                  itemBuilder: (context, index) {
                    final breed = store.breeds[index];
                    return BreedTile(
                        breed: breed, image: store.images[breed.name]);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class DesktopContent extends StatelessWidget {
  final HomeStore store;
  final ScrollController scrollCtrl;

  const DesktopContent(
      {Key? key, required this.store, required this.scrollCtrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Observer(builder: (_) {
          if (store.loading) return LinearProgressIndicator();
          return SizedBox(height: 1);
        }),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Observer(
              builder: (context) {
                return GridView.builder(
                  controller: scrollCtrl,
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10),
                  itemCount: store.breeds.length,
                  itemBuilder: (context, index) {
                    final breed = store.breeds[index];
                    return BreedCard(
                        breed: breed, image: store.images[breed.name]);
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
