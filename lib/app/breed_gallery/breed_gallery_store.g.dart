// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breed_gallery_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$BreedGalleryStore on _BreedGalleryStoreBase, Store {
  final _$imagesAtom = Atom(name: '_BreedGalleryStoreBase.images');

  @override
  ObservableList<String> get images {
    _$imagesAtom.reportRead();
    return super.images;
  }

  @override
  set images(ObservableList<String> value) {
    _$imagesAtom.reportWrite(value, super.images, () {
      super.images = value;
    });
  }

  final _$loadingAtom = Atom(name: '_BreedGalleryStoreBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$didLoadAtom = Atom(name: '_BreedGalleryStoreBase.didLoad');

  @override
  bool get didLoad {
    _$didLoadAtom.reportRead();
    return super.didLoad;
  }

  @override
  set didLoad(bool value) {
    _$didLoadAtom.reportWrite(value, super.didLoad, () {
      super.didLoad = value;
    });
  }

  final _$errorMessageAtom = Atom(name: '_BreedGalleryStoreBase.errorMessage');

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  final _$loadTenNewImagesAsyncAction =
      AsyncAction('_BreedGalleryStoreBase.loadTenNewImages');

  @override
  Future<bool> loadTenNewImages() {
    return _$loadTenNewImagesAsyncAction.run(() => super.loadTenNewImages());
  }

  @override
  String toString() {
    return '''
images: ${images},
loading: ${loading},
didLoad: ${didLoad},
errorMessage: ${errorMessage}
    ''';
  }
}
