import 'dart:convert';
import 'package:http/http.dart' as http;

class TodoService {
  final String apiUrl = 'http://127.0.0.1:8000/api/todos/';

  Future<List<dynamic>> fetchTodos() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load todos');
    }
  }

  Future<void> addTodo(String title, String description) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'title': title, 'description': description}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add todo');
    }
  }
}
