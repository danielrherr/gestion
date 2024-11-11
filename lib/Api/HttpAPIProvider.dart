import 'dart:convert';
import 'dart:io';

import 'package:gestion/Api/APIProvider.dart';
import 'package:http/http.dart' as http;

class HttpAPIProvider extends HTTPProvider {

  HttpAPIProvider({required String baseUrl}) : super(baseUrl: baseUrl);
  @override
  Future<Map<String, dynamic>> get(
      {required String endPoint, Map<String, String>? queryParameters}) async {
    try {
      if (!await isInternetAvailable()) {
        throw SocketException("No Internet");
      }
      final response = await http.get(
        Uri.parse('$baseUrl$endPoint')
            .replace(queryParameters: queryParameters),
      );
      return _processResponse(response);
    } catch (e) {
      handleError(e as Exception);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> post(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? files}) async {
    try {
      if (!await isInternetAvailable()) {
        throw const SocketException("No Internet");
      }
      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$endPoint'));
      if (data != null) {
        request.fields
            .addAll(data.map((key, value) => MapEntry(key, value.toString())));
      }
      if (files != null) {
        files.forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value));
        });
      }
      var response = await request.send();
      return _processResponse(await http.Response.fromStream(response));
    } catch (e) {
      handleError(e as Exception);
      rethrow;
    }
  }

  @override
  Future<Map<String, dynamic>> put(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? files}) async {
   throw const HttpException('Something went wrong');
  }
  @override
  Future<Map<String, dynamic>> patch(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? files}) async {
    throw const HttpException('Something went wrong');
  }
  @override
  Future<Map<String, dynamic>> delete(
      {required String endPoint, Map<String, String>? queryParameters}) async {
    throw const HttpException('Something went wrong');
  }
  Map<String, dynamic> _processResponse(http.Response response) {
    final Map<String, dynamic> responseBody = json.decode(response.body);
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return responseBody;
    } else {
      throw HttpException(responseBody['message'] ?? 'Something went wrong');
    }
  }
}
