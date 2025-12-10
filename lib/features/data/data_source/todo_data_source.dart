import 'package:http/http.dart' as http;

class TodoDatacource {
  final http.Client client;
  TodoDatacource(this.client);
  Future<dynamic> addthisTodo(String url, String body) async {
    final response = client.post(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "Application/Json"},
    );
    return response;
  }

  Future<dynamic> deletethisTodo(String url, String body) async {
    final response = client.delete(
      Uri.parse(url),
      body: body,
      headers: {"Content-Type": "Application/Json"},
    );
    return response;
  }

  Future<dynamic> getthisTodo(String url) async {
    final response = client.post(Uri.parse(url));
    return response;
  }
}
