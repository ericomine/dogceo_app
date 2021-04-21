import 'package:dogceo_app/shared/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:dogceo_app/data/api/api.dart';
import 'package:dogceo_app/domain/repositories/breed_repository.dart';

import 'breed_repository_test.mocks.dart';

@GenerateMocks([DogAPI])
void main() {
  group("Tests for Breed Repository", () {
    final api = MockDogAPI();

    test("Should get ten new breeds", () async {
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

      final sut = BreedRepository(api);
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
  });
}
