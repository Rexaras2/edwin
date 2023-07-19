import 'package:http/http.dart' as http;

class ApiService {
  static const baseUrl = 'https://reqres.in/api';

  Future<http.Response> getUsers(int page) async {
    final response = await http.get(Uri.parse('$baseUrl/users?page=$page'));
    return response;
  }

  Future<http.Response> getUserDetails(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId'));
    return response;
  }
}
