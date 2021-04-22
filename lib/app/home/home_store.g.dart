// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$HomeStore on _HomeStoreBase, Store {
  final _$breedsAtom = Atom(name: '_HomeStoreBase.breeds');

  @override
  List<Breed> get breeds {
    _$breedsAtom.reportRead();
    return super.breeds;
  }

  @override
  set breeds(List<Breed> value) {
    _$breedsAtom.reportWrite(value, super.breeds, () {
      super.breeds = value;
    });
  }

  final _$loadingAtom = Atom(name: '_HomeStoreBase.loading');

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

  final _$didLoadAtom = Atom(name: '_HomeStoreBase.didLoad');

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

  final _$errorMessageAtom = Atom(name: '_HomeStoreBase.errorMessage');

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

  final _$loadTenNewBreedsAsyncAction =
      AsyncAction('_HomeStoreBase.loadTenNewBreeds');

  @override
  Future<bool> loadTenNewBreeds() {
    return _$loadTenNewBreedsAsyncAction.run(() => super.loadTenNewBreeds());
  }

  @override
  String toString() {
    return '''
breeds: ${breeds},
loading: ${loading},
didLoad: ${didLoad},
errorMessage: ${errorMessage}
    ''';
  }
}
