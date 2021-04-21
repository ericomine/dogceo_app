import 'package:dogceo_app/shared/result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dogceo_app/data/api/api.dart';
import 'package:dogceo_app/domain/repositories/breed_repository.dart';

import 'breed_repository_test.mocks.dart';

@GenerateMocks([DogAPI])
void main() {
  group("Tests for Breed Repository:", () {
    final api = MockDogAPI();
    final sut = BreedRepository(api);

    test("Should get ten new breeds.", () async {
      final oldBreedNames = [
        "african",
        "bouvier",
        "bullterrier",
        "chihuahua",
        "cockapoo",
        "cotondetulear",
        "doberman",
        "groenendael",
        "rottweiler",
        "springer",
      ];

      // "bullterrier" and "chihuahua" are already in list
      // so after first attempt it will still needs 2 new breeds
      final firstAttempt = [
        "bulldog",
        "bullterrier",
        "cattledog",
        "chihuahua",
        "chow",
        "finnish",
        "spaniel",
        "vizsla",
        "whippet",
        "wolfhound"
      ];

      final secondAttempt = [
        "basenji",
        "cockapoo",
        "frise",
        "mountain",
        "pitbull",
        "pug",
        "retriever",
        "sheepdog",
        "waterdog",
        "whippet"
      ];

      when(api.getBreeds(10))
          .thenAnswer((_) async => Result<List<String>>.success(firstAttempt));
      when(api.getBreeds(4))
          .thenAnswer((_) async => Result<List<String>>.success(secondAttempt));

      final newBreedsResult = await sut.getTenNewBreeds(oldBreedNames);

      if (newBreedsResult is Failure) {
        fail(newBreedsResult.message!);
      }

      final newBreeds = newBreedsResult.value!;
      final newBreedNames = newBreeds.map((breed) => breed.name).toList();
      verify(api.getBreeds(10));
      verify(api.getBreeds(4));
      expect(
          newBreedNames,
          equals([
            "bulldog",
            "cattledog",
            "chow",
            "finnish",
            "spaniel",
            "vizsla",
            "whippet",
            "wolfhound",
            "basenji",
            "frise"
          ]));
      expect(newBreeds.length, equals(10));
    });

    test("Should get ten new images", () async {
      final oldImages = [
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_12785.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1505.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1854.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1923.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_3614.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_367.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_3799.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_6992.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_5936.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_7454.jpg"
      ];

      final firstAttempt = [
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_11836.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1602.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1757.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_269.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_2763.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1643.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_4678.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_5733.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_5936.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_7454.jpg"
      ];

      final secondAttempt = [
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_11836.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1602.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_1757.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_269.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_2763.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_3614.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_4678.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_5733.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_6575.jpg",
        "https:\/\/images.dog.ceo\/breeds\/bullterrier-staffordshire\/n02093256_7830.jpg"
      ];

      final breedPath = "bullterrier";

      when(api.getImages(breedPath, 10))
          .thenAnswer((_) async => Result<List<String>>.success(firstAttempt));
      when(api.getImages(breedPath, 4))
          .thenAnswer((_) async => Result<List<String>>.success(secondAttempt));

      final newImagesResult = await sut.getTenNewImages(breedPath, oldImages);
      if (newImagesResult is Failure) {
        fail(newImagesResult.message!);
      }

      final newImages = newImagesResult.value!;
      expect(newImages.length, equals(10));
    });
  });
}
