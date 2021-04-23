// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

import 'package:auto_route/auto_route.dart' as _i1;
import 'package:dogceo_app/app/breed_gallery/breed_gallery_page.dart' as _i3;
import 'package:dogceo_app/app/home/home_page.dart' as _i2;
import 'package:dogceo_app/domain/models/breed.dart' as _i5;
import 'package:flutter/material.dart' as _i4;

class AppRouter extends _i1.RootStackRouter {
  AppRouter();

  @override
  final Map<String, _i1.PageFactory> pagesMap = {
    HomeRoute.name: (entry) {
      return _i1.AdaptivePage(entry: entry, child: _i2.HomePage());
    },
    BreedGalleryRoute.name: (entry) {
      var args = entry.routeData.argsAs<BreedGalleryRouteArgs>();
      return _i1.AdaptivePage(
          entry: entry,
          child: _i3.BreedGalleryPage(
              key: args.key, breed: args.breed, imagePath: args.imagePath));
    }
  };

  @override
  List<_i1.RouteConfig> get routes => [
        _i1.RouteConfig(HomeRoute.name, path: '/'),
        _i1.RouteConfig(BreedGalleryRoute.name, path: '/breed-gallery-page')
      ];
}

class HomeRoute extends _i1.PageRouteInfo {
  const HomeRoute() : super(name, path: '/');

  static const String name = 'HomeRoute';
}

class BreedGalleryRoute extends _i1.PageRouteInfo<BreedGalleryRouteArgs> {
  BreedGalleryRoute(
      {_i4.Key? key, required _i5.Breed breed, required String imagePath})
      : super(name,
            path: '/breed-gallery-page',
            args: BreedGalleryRouteArgs(
                key: key, breed: breed, imagePath: imagePath));

  static const String name = 'BreedGalleryRoute';
}

class BreedGalleryRouteArgs {
  const BreedGalleryRouteArgs(
      {this.key, required this.breed, required this.imagePath});

  final _i4.Key? key;

  final _i5.Breed breed;

  final String imagePath;
}
