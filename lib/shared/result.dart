abstract class Result<T> {
  const Result();
  factory Result.success(T value) => Success<T>(value);
  factory Result.failure(String message) => Failure<T>(message);

  T? get value => (this as Success).value;
  String? get message => (this as Failure).message;
}

class Success<T> extends Result<T> {
  final T value;
  const Success(this.value);
}

class Failure<T> extends Result<T> {
  final String message;
  const Failure(this.message);
}
