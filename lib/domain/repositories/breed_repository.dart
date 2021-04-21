import 'dart:math';

import '../../data/api/api.dart';
import '../../shared/result.dart';
import '../models/breed.dart';

abstract class AbstractBreedRepository {
  Future<Result<List<Breed>>> getTenNewBreeds(List<String> oldBreedNames);
  //Future<Result<List<String>>> getTenNewImages(List<String> currentImages);
}

class BreedRepository implements AbstractBreedRepository {
  late DogAPI _api;
  BreedRepository(this._api);

  Future<Result<List<Breed>>> getTenNewBreeds(
      List<String> oldBreedNames) async {
    final int amountToGet = 10;
    final int attemptsLeft = 5;

    try {
      final getNewBreedsResult =
          await getNewBreeds(oldBreedNames, [], amountToGet, attemptsLeft);

      if (getNewBreedsResult is Failure) {
        return Result.failure(getNewBreedsResult.message!);
      }

      final newBreedNames = getNewBreedsResult.value!;
      final newBreeds = newBreedNames.map((name) => Breed(name: name)).toList();
      return Result.success(newBreeds);
    } catch (error) {
      return Result.failure("Error getting new breeds");
    }
  }

  Future<Result<List<String>>> getNewBreeds(List<String> oldBreedNames,
      List<String> accBreeds, int amountLeft, int attemptsLeft) async {
    if (amountLeft == 0 || attemptsLeft == 0) {
      return Result.success(accBreeds);
    }

    // It will attempt to fetch the double of missing elements,
    // or if this is greater than 10, it will fetch 10 elements.
    // This is to avoid requesting data from the API because
    // it has returned breeds that are already in the list.
    // This problem would occur on an API with real pagination.
    final amountToGetFromAPI = min(amountLeft * 2, 10);
    final getBreedsResult = await _api.getBreeds(amountToGetFromAPI);
    if (getBreedsResult is Success) {
      final namesFromAPI = getBreedsResult.value!;

      final newNames = namesFromAPI
          .where((name) => !oldBreedNames.contains(name))
          .where((name) => !accBreeds.contains(name))
          .take(amountLeft)
          .toList();

      return getNewBreeds(
        oldBreedNames,
        [...accBreeds, ...newNames],
        amountLeft - newNames.length,
        attemptsLeft - 1,
      );
    }

    return getNewBreeds(oldBreedNames, accBreeds, amountLeft, attemptsLeft - 1);
  }
}
