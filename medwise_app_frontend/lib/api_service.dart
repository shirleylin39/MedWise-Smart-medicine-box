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
    final url = Uri.parse('http://10.0.2.2:3000/devices');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body) as List<dynamic>;
      } else {
        print('Failed to load devices: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      print('Error: $e');
      return [];
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

  Future<void> updateDevice(BuildContext context, String? id, deviceData) async {
    final url = Uri.parse('http://10.0.2.2:3000/devices/$id');

    final response = await http.put(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deviceData),
    );

    if (response.statusCode == 200) {
      print('Data updated successfully: ${response.body}');
    } else {
      print('Failed to update data: ${response.statusCode}');
    }
  }

  Future<Map<String, dynamic>?> fetchDeviceById(String? id) async {
    final url = Uri.parse('http://10.0.2.2:3000/devices/$id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        print('Failed to fetch device: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}

