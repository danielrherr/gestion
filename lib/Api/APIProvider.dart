// ignore_for_file: file_names

import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

abstract class APIProvider {
  final String baseUrl;
  APIProvider({required this.baseUrl});
  Future<Map<String, dynamic>> get(
      {required String endPoint, Map<String, String>? queryParameters});
  Future<Map<String, dynamic>> post(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? files});
  Future<Map<String, dynamic>> put(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? files});
  Future<Map<String, dynamic>> patch(
      {required String endPoint,
      Map<String, dynamic>? data,
      Map<String, dynamic>? files});
  Future<Map<String, dynamic>> delete(
      {required String endPoint, Map<String, String>? queryParameters});
  Future<bool> isServerAvailable();
  Future<bool> isInternetAvailable();

  void handleError(Exception e);
}

abstract class HTTPProvider implements APIProvider {
  @override
  final String baseUrl;
  HTTPProvider({required this.baseUrl});
  @override
  Future<bool> isInternetAvailable() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }
    return true;
  }

  @override
  Future<bool> isServerAvailable() async {
    try {
      final response = await get(endPoint: baseUrl);
      return response['status'] == 200;
    } catch (e) {
      return false;
    }
  }

  @override
  void handleError(Exception e) {
    if (e is SocketException) {
      debugPrint("Please check your internet connection.");
    } else {
      debugPrint("An error occurred: $e");
    }
  }
}
