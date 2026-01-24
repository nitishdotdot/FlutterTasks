import 'package:dio/dio.dart';

class TodoDatacource {
  final Dio dio;
  TodoDatacource(this.dio);
  Future<dynamic> addthisTodo(String url, String body) async {
    final response = dio.post(url, data: body);
    return response;
  }

  Future<dynamic> deletethisTodo(String url, String body) async {
    final response = dio.delete(url, data: body);
    return response;
  }

  Future<dynamic> getthisTodo(String url) async {
    final response = dio.get(url);
    return response;
  }

  Future<dynamic> editthisTodo(String body, String url) async {
    final response = dio.patch(url, data: body);
    return response;
  }
}
