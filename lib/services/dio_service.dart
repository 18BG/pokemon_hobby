import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class DioService {
  DioService();

  final _dio = Dio();

  Future<Response?> fetch(String path) async {
    try {
      Response response = await _dio.get(path);
      return response;
    } catch (e) {
      debugPrint(e.toString());
    }
    return null;
  }
}
