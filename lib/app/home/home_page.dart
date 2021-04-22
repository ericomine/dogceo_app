import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import 'home_store.dart';

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

          return Column(
            children: [
              Observer(builder: (_) {
                if (store.loading) return LinearProgressIndicator();
                return SizedBox(height: 1);
              }),
              Expanded(
                child: Observer(
                  builder: (context) {
                    return ListView.builder(
                      controller: scrollCtrl,
                      physics: AlwaysScrollableScrollPhysics(),
                      itemCount: store.breeds.length,
                      itemBuilder: (context, index) {
                        return Text(store.breeds[index].name);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
