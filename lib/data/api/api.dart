import 'dart:io';

import 'package:dio/dio.dart';

import '../../shared/result.dart';

abstract class AbstractDogAPI {
  Future<Result<List<String>>> getBreeds(int count);
  Future<Result<List<String>>> getImages(String breedPath, int count);
}

class DogAPI implements AbstractDogAPI {
  late final Dio _dio;

  DogAPI() {
    _dio = Dio();
    _dio.options.baseUrl = "https://dog.ceo/api";
    _dio.options.connectTimeout = 5000;
    _dio.options.receiveTimeout = 3000;
  }

  @override
  Future<Result<List<String>>> getBreeds(int amountToGet) async {
    try {
      final response = await _dio.get("/breeds/list/random/$amountToGet");

      if (response.statusCode != HttpStatus.ok) {
        return Result.failure("Error getting breed list");
      }

      return Result.success(response.data["message"].cast<String>());
    } catch (error) {
      return Result.failure("Error getting breed list: ${error.toString()}");
    }
  }

  @override
  Future<Result<List<String>>> getImages(String breedPath, int count) async {
    try {
      final response = await _dio.get("/breed/$breedPath/images/random/$count");

      if (response.statusCode != HttpStatus.ok) {
        return Result.failure("Error getting breed images");
      }

      final List<String> result = response.data["message"].cast<String>();
      return Result.success(result);
    } catch (error) {
      return Result.failure("Error getting breed images: ${error.toString()}");
    }
  }
}
