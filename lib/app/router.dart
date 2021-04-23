import 'package:auto_route/auto_route.dart';

import 'breed_gallery/breed_gallery_page.dart';
import 'home/home_page.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: HomePage, initial: true),
    AutoRoute(page: BreedGalleryPage),
  ],
)
class $AppRouter {}
