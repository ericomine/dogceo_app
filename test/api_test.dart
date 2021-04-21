import 'package:dogceo_app/data/api/api.dart';
import 'package:dogceo_app/shared/result.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("API Tests", () {
    test("Should get 10 random dog breeds and subbreeds if any", () async {
      final sut = DogAPI();
      final breedsResult = await sut.getBreeds(10);

      if (breedsResult is Failure) {
        fail(breedsResult.message!);
      }

      final breeds = breedsResult.value;
      if (breeds == null) {
        fail("Returned null, which is unexpected");
      }

      expect(breeds.length, equals(10));
    });

    test("Should get 10 random bullterrier images (URIs)", () async {
      final sut = DogAPI();
      final imagesResult = await sut.getImages("bullterrier", 10);

      if (imagesResult is Failure) {
        fail(imagesResult.message!);
      }

      final images = imagesResult.value;
      if (images == null) {
        fail("Returned null, which is unexpected");
      }

      expect(images.length, equals(10));
    });
  });
}
