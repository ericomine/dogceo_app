import 'package:mobx/mobx.dart';

import '../../domain/models/breed.dart';
import '../../domain/repositories/breed_repository.dart';
import '../../shared/result.dart';

part 'breed_gallery_store.g.dart';

class BreedGalleryStore extends _BreedGalleryStoreBase
    with _$BreedGalleryStore {
  BreedGalleryStore({required Breed breed}) : super(breed);
}

abstract class _BreedGalleryStoreBase with Store {
  final _breedRepository = BreedRepository();

  final Breed breed;
  _BreedGalleryStoreBase(this.breed);

  @observable
  ObservableList<String> images = ObservableList<String>();

  @observable
  bool loading = false;

  @observable
  bool didLoad = false;

  @observable
  String errorMessage = "";

  @action
  Future<bool> loadTenNewImages() async {
    if (loading == true) {
      return false;
    }

    loading = true;
    final newImagesResult =
        await _breedRepository.getTenNewImages(breed.name, images);

    if (newImagesResult is Failure) {
      loading = false;
      didLoad = true;
      errorMessage = newImagesResult.message!;
      return false;
    }

    loading = false;
    didLoad = true;
    final newImages = newImagesResult.value!;
    images.addAll(newImages);
    return true;
  }
}
