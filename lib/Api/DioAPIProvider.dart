import 'dart:io';

import 'package:dio/dio.dart';
import 'package:gestion/Api/APIProvider.dart';

class DioAPIProvider extends HTTPProvider {
  Dio dio = Dio();
  DioAPIProvider({required String baseUrl}) : super(baseUrl: baseUrl) {
    dio.options.baseUrl = baseUrl;
  }
  @override
  Future<Map<String, dynamic>> get({required String endPoint, Map<String, String>? queryParameters}) async {
    try {
      if (!await isInternetAvailable()) {
        throw const SocketException("No Internet");
      }
      final response = await dio.get(endPoint, queryParameters: queryParameters);
      return _processResponse(response);
    } catch (e) {
      handleError(e as Exception);
      rethrow;
    }
  }
  @override
  Future<Map<String, dynamic>> post({required String endPoint, Map<String, dynamic>? data, Map<String, dynamic>? files}) async {
    try {
      if (!await isInternetAvailable()) {
        throw SocketException("No Internet");
      }
      FormData formData = FormData.fromMap(data ?? {});
      if (files != null) {
        files.forEach((key, value) async {
          formData.files.add(MapEntry(key, await MultipartFile.fromFile(value)));
        });
      }
      final response = await dio.post(endPoint, data: formData);
      return _processResponse(response);
    } catch (e) {
      handleError(e as Exception);
      rethrow;
    }
  }
  @override
  Future<Map<String, dynamic>> put({required String endPoint, Map<String, dynamic>? data, Map<String, dynamic>? files}) async {
    throw const HttpException('Something went wrong');
  }
  @override
  Future<Map<String, dynamic>> patch({required String endPoint, Map<String, dynamic>? data, Map<String, dynamic>? files}) async {
    throw const HttpException('Something went wrong');
  }
  @override
  Future<Map<String, dynamic>> delete({required String endPoint, Map<String, String>? queryParameters}) async {
   throw const HttpException('Something went wrong');
  }
  Map<String, dynamic> _processResponse(Response response) {
    final Map<String, dynamic> responseBody = response.data;
    if (response.statusCode! >= 200 && response.statusCode! < 300) {
      return responseBody;
    } else {
      throw HttpException(responseBody['message'] ?? 'Something went wrong');
    }
  }
}