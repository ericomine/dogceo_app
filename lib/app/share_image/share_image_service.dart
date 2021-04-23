import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

import '../../shared/result.dart';

class ShareImageService extends ValueNotifier<bool> {
  static final _dio = new Dio();

  ShareImageService() : super(false);

  Future<Result<void>> shareImageFromUrl(String imageUrl) async {
    try {
      final isMobile = Platform.isAndroid || Platform.isIOS;
      if (!isMobile) {
        return Result.failure("Sharing is only available for android and iOS");
      }

      value = true;
      notifyListeners();

      final tempDir = await getTemporaryDirectory();
      final fileName = imageUrl.split("/").last;
      final tempFile = tempDir.path + fileName;

      final saveResult = await _saveTempFile(imageUrl, tempFile);
      if (saveResult is Failure) {
        return saveResult;
      }

      await Share.shareFiles([tempFile],
          text: "Look at this dog!", subject: "K9 frenzy");

      value = false;
      notifyListeners();

      return Result.success(null);
    } catch (error) {
      print(error);
      return Result.failure(error.toString());
    }
  }

  Future<Result<void>> _saveTempFile(String url, String savePath) async {
    Response response = await _dio.get(url,
        options: Options(
            responseType: ResponseType.bytes,
            followRedirects: false,
            validateStatus: (status) {
              return status! < 500;
            }));
    File file = File(savePath);
    final raf = file.openSync(mode: FileMode.write)
      ..writeFromSync(response.data);
    await raf.close();

    return Result.success(null);
  }
}
