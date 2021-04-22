import '../../shared/result.dart';
import '../repositories/breed_repository.dart';

class Breed {
  final _breedRepository = BreedRepository();

  final String name;
  String _imagePath = "";

  Breed({
    required this.name,
  });

  Future<String> get imagePath async {
    if (_imagePath.isEmpty) {
      final getImageResult = await _breedRepository.getImage(name);
      if (getImageResult is Success) {
        return getImageResult.value!;
      }
    }
    return _imagePath;
  }

  Breed copyWith({
    String? name,
  }) {
    return Breed(
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
    };
  }

  @override
  String toString() => 'Breed(name: $name, imagePath: $_imagePath)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breed && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
