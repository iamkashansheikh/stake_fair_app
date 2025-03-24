import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/menu_model.dart';

class ApiService {
  static Future<MenuModel?> getMenuData() async {
    try {
      final response = await http.post(
        Uri.parse("https://eka247.com/api/navigation/menuList"), // ✅ Replace with your API URL
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "yourKey": "yourValue" // ✅ Add required POST parameters if any
        }),
      );

      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");

      if (response.statusCode == 200) {
        return MenuModel.fromJson(jsonDecode(response.body));
      } else {
        print("Failed to fetch data: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      print("API Error: $e");
      return null;
    }
  }
}
