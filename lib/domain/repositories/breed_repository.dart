import 'dart:math';

import '../../data/api/api.dart';
import '../../shared/result.dart';
import '../models/breed.dart';

abstract class AbstractBreedRepository {
  Future<Result<List<Breed>>> getTenNewBreeds(List<String> oldBreedNames);
  Future<Result<List<String>>> getTenNewImages(
      String breedPath, List<String> oldImages);
  Future<Result<String>> getImage(String breedPath);
}

class BreedRepository implements AbstractBreedRepository {
  late AbstractDogAPI _api;
  BreedRepository([AbstractDogAPI? api]) {
    _api = api ?? DogAPI();
  }

  Future<Result<List<Breed>>> getTenNewBreeds(
      List<String> oldBreedNames) async {
    final int amountToGet = 10;
    final int attemptsLeft = 5;

    try {
      final getNewBreedsResult =
          await _getNewBreeds(oldBreedNames, [], amountToGet, attemptsLeft);

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

  Future<Result<List<String>>> _getNewBreeds(List<String> oldBreedNames,
      List<String> accBreeds, int amountLeft, int attemptsLeft) async {
    if (amountLeft == 0 || attemptsLeft == 0) {
      return Result.success(accBreeds);
    }

    // It will attempt to fetch the double of missing elements,
    // or if this is greater than 10, it will fetch 10 elements.
    // This is to avoid requesting data from the API because
    // it has returned breeds that are already in the list.
    // This problem would not occur on an API with real pagination.
    final amountToGetFromAPI = min(amountLeft * 2, 10);
    final getBreedsResult = await _api.getBreeds(amountToGetFromAPI);
    if (getBreedsResult is Success) {
      final namesFromAPI = getBreedsResult.value!;

      final newNames = namesFromAPI
          .where((name) => !oldBreedNames.contains(name))
          .where((name) => !accBreeds.contains(name))
          .take(amountLeft)
          .toSet()
          .toList();

      return _getNewBreeds(
        oldBreedNames,
        [...accBreeds, ...newNames],
        amountLeft - newNames.length,
        attemptsLeft - 1,
      );
    }

    return _getNewBreeds(
        oldBreedNames, accBreeds, amountLeft, attemptsLeft - 1);
  }

  Future<Result<List<String>>> getTenNewImages(
      String breedPath, List<String> oldImages) async {
    final int amountToGet = 10;
    final int attemptsLeft = 5;

    try {
      final getNewImagesResult = await _getNewImages(
          breedPath, oldImages, [], amountToGet, attemptsLeft);

      if (getNewImagesResult is Failure) {
        return Result.failure(getNewImagesResult.message!);
      }

      final newImages = getNewImagesResult.value!;
      return Result.success(newImages);
    } catch (error) {
      return Result.failure("Error getting new images");
    }
  }

  Future<Result<List<String>>> _getNewImages(
      String breedPath,
      List<String> oldImages,
      List<String> accImages,
      int amountLeft,
      int attemptsLeft) async {
    if (amountLeft == 0 || attemptsLeft == 0) {
      return Result.success(accImages);
    }

    // See comment above for _getNewBreeds.
    final amountToGetFromAPI = min(amountLeft * 2, 10);
    final getBreedsResult = await _api.getImages(breedPath, amountToGetFromAPI);
    if (getBreedsResult is Success) {
      final namesFromAPI = getBreedsResult.value!;

      final newImages = namesFromAPI
          .where((name) => !oldImages.contains(name))
          .where((name) => !accImages.contains(name))
          .take(amountLeft)
          .toList();

      return _getNewImages(
        breedPath,
        oldImages,
        [...accImages, ...newImages],
        amountLeft - newImages.length,
        attemptsLeft - 1,
      );
    }

    return _getNewImages(
        breedPath, oldImages, accImages, amountLeft, attemptsLeft - 1);
  }

  Future<Result<String>> getImage(String breedPath) async {
    try {
      final getNewImagesResult = await _api.getImages(breedPath, 1);

      if (getNewImagesResult is Failure) {
        return Result.failure(getNewImagesResult.message!);
      }

      final newImages = getNewImagesResult.value!;
      return Result.success(newImages.first);
    } catch (error) {
      return Result.failure("Error getting image.");
    }
  }
}
