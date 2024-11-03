import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class DataService {
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000'));

      if (response.statusCode == 200) {
        print('Response from Node.js: ${response.body}');
      } else {
        print('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}


class DeviceService {
  Future<List<dynamic>> fetchDevices() async {
    final url = Uri.parse('http://10.0.2.2:3000/devices'); // Use your backend URL
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        // Parse the JSON response and return the list of devices
        return json.decode(response.body) as List<dynamic>;
      } else {
        print('Failed to load devices: ${response.statusCode}');
        return []; // Return an empty list on failure
      }
    } catch (e) {
      print('Error: $e');
      return []; // Return an empty list on error
    }
  }

  Future<void> submitDevice(BuildContext context, Map<String, dynamic> deviceData) async {
    final url = Uri.parse('http://10.0.2.2:3000/devices');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deviceData),
    );

    if (response.statusCode == 200) {
      print('Data sent successfully: ${response.body}');
    } else {
      print('Failed to send data: ${response.statusCode}');
    }
  }
}
