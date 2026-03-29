import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> syncMonitoring(Map<String, dynamic> payload) async {
    final uri = Uri.parse('$baseUrl/api/sync_monitoring.php');
    final response = await http.post(uri, body: jsonEncode(payload), headers: {'Content-Type': 'application/json'}).timeout(const Duration(seconds: 15));
    return jsonDecode(response.body) as Map<String, dynamic>;
  }
}
