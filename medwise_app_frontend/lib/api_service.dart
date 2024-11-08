import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

final logger = Logger();

class DataService {
  Future<void> fetchData() async {
    try {
      final response = await http.get(Uri.parse('http://10.0.2.2:3000'));

      if (response.statusCode == 200) {
        logger.i('Response from Node.js: ${response.body}');
      } else {
        logger.w('Failed to load data: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error: $e');
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
        logger.w('Failed to load devices: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      logger.e('Error: $e');
      return [];
    }
  }

  Future<void> submitDevice(BuildContext context, Map<String, dynamic> deviceData) async {
    final url = Uri.parse('http://10.0.2.2:3000/devices');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(deviceData),
      );

      if (response.statusCode == 200) {
        logger.i('Data sent successfully: ${response.body}');
      } else {
        logger.w('Failed to send data: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error during submitDevice: $e');
    }
  }

  Future<void> updateDevice(BuildContext context, String id, deviceData) async {
    final url = Uri.parse('http://10.0.2.2:3000/devices/$id');

    try {
      final response = await http.put(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(deviceData),
      );

      if (response.statusCode == 200) {
        logger.i('Data updated successfully: ${response.body}');
      } else {
        logger.e('Failed to update data: ${response.statusCode}');
      }
    } catch (e) {
      logger.e('Error during updateDevice: $e');
    }
  }

  Future<Map<String, dynamic>> fetchDeviceById(String id, Map<String, dynamic> originalData) async {
    final url = Uri.parse('http://10.0.2.2:3000/devices/$id');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        logger.w('Failed to fetch device: ${response.statusCode}');
        return originalData;
      }
    } catch (e) {
      logger.e('Error: $e');
      return originalData;
    }
  }
}

