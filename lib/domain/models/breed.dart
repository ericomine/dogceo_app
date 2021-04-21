import 'dart:convert';

class Breed {
  final String name;

  Breed({
    required this.name,
  });

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

  factory Breed.fromMap(Map<String, dynamic> map) {
    return Breed(
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Breed.fromJson(String source) => Breed.fromMap(json.decode(source));

  @override
  String toString() => 'Breed(name: $name)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Breed && other.name == name;
  }

  @override
  int get hashCode => name.hashCode;
}
