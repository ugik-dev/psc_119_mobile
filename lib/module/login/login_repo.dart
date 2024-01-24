import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginRepo {
  Future<http.Response> login(String name, String phone) async {
    try {
      final response = await http.post(
        Uri.parse('http://192.168.18.83:8000/api/login'),
        headers: <String, String>{
          'Content-Type':
              'application/json; charset=UTF-8', // Updated content type
        },
        body: jsonEncode({
          'name': name,
          'phone': phone,
        }),
      );

      // You can add additional logic here if needed
// debu
      return response;
    } catch (error) {
      print('Error during login: $error');
      throw error; // Re-throw the error to handle it in the calling code
    }
  }
}
