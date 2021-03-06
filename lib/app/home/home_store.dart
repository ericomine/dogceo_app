import 'package:mobx/mobx.dart';

import '../../domain/models/breed.dart';
import '../../domain/repositories/breed_repository.dart';
import '../../shared/result.dart';

part 'home_store.g.dart';

class HomeStore = _HomeStoreBase with _$HomeStore;

abstract class _HomeStoreBase with Store {
  final _breedRepository = BreedRepository();

  @observable
  ObservableList<Breed> breeds = ObservableList<Breed>();

  @observable
  ObservableMap<String, String> images = ObservableMap<String, String>();

  @observable
  bool loading = false;

  @observable
  bool didLoad = false;

  @observable
  String errorMessage = "";

  @action
  Future<bool> loadTenNewBreeds() async {
    if (loading == true) {
      return false;
    }

    loading = true;
    final breedNames = breeds.map((breed) => breed.name).toList();
    final newBreedsResult = await _breedRepository.getTenNewBreeds(breedNames);

    if (newBreedsResult is Failure) {
      loading = false;
      didLoad = true;
      errorMessage = newBreedsResult.message!;
      return false;
    }

    final newBreeds = newBreedsResult.value!;
    for (final breed in newBreeds) {
      images[breed.name] = await breed.imagePath;
    }

    loading = false;
    didLoad = true;
    breeds.addAll(newBreeds);
    return true;
  }
}
