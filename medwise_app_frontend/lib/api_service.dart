import 'package:http/http.dart' as http;

Future<void> fetchData() async {
  try {
    final response = await http.get(Uri.parse('http://localhost:3000'));

    if (response.statusCode == 200) {
      print('Response from Node.js: ${response.body}');
    } else {
      print('Failed to load data');
    }
  } catch (e) {
    print('Error: $e');
  }
}