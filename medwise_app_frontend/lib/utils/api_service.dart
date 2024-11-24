import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';

final logger = Logger();
const String baseUrl = 'http://10.0.2.2:3000/api';
Uri getUrl(String endpoint) => Uri.parse('$baseUrl/$endpoint');


Future<List<dynamic>> fetchDevices() async {
  try {
    final response = await http.get(getUrl('medwises'));
    if (response.statusCode == 200) {
      logger.i('fetchDevices success');
      return json.decode(response.body) as List<dynamic>;
    } else {
      logger.w('Failed during fetchDevices: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    logger.e('fetchDevices Error: $e');
    return [];
  }
}

Future<void> submitDevice(BuildContext context, Map<String, dynamic> deviceData) async {
  try {
    final response = await http.post(getUrl('medwises'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deviceData),
    );

    if (response.statusCode == 200) {
      logger.i('submitDevice successfully: ${response.body}');
    } else {
      logger.w('Failed submitDevice: ${response.statusCode}');
    }
  } catch (e) {
    logger.e('Error during submitDevice: $e');
  }
}

Future<void> updateDevice(BuildContext context, String id, deviceData) async {
  try {
    final response = await http.put(
      getUrl('medwises/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(deviceData),
    );

    if (response.statusCode == 200) {
      logger.i('updateDevice successfully: ${response.body}');
    } else {
      logger.e('Failed updateDevice ${response.statusCode}');
    }
  } catch (e) {
    logger.e('Error during updateDevice: $e');
  }
}

Future<Map<String, dynamic>> fetchDeviceById(String id, Map<String, dynamic> originalData) async {
  try {
    final response = await http.get(getUrl('medwises/$id'));
    if (response.statusCode == 200) {
      logger.i('Success fetchDeviceById');
      return json.decode(response.body);
    } else {
      logger.w('Failed fetchDeviceById: ${response.statusCode}');
      return originalData;
    }
  } catch (e) {
    logger.e('Error fetchDeviceById: $e');
    return originalData;
  }
}


Future<List<dynamic>> fetchBacklogs() async {
  try {
    final response = await http.get(getUrl('backlogs'));
    if (response.statusCode == 200) {
      logger.i('Backlogs fetched successfully');
      return json.decode(response.body) as List<dynamic>;
    } else {
      logger.w('Failed to fetch backlogs: ${response.statusCode}');
      return [];
    }
  } catch (e) {
    logger.e('Error fetching backlogs: $e');
    return [];
  }
}

Future<List<dynamic>> fetchBacklogByDevice(String deviceId) async {
        try {

        final response = await http.get(getUrl('backlogs/$deviceId'));
        if (response.statusCode == 200) {
        logger.i('Backlogs for device $deviceId fetched successfully');
        return json.decode(response.body) as List<dynamic>;
        } else if (response.statusCode == 404) {
        logger.w('No backlogs found for device $deviceId');
        return [];
        } else {
        logger.w('Failed to fetch backlogs for device $deviceId: ${response.statusCode}');
        return [];
        }
        } catch (e) {
      logger.e('Error fetching backlogs by device ID: $e');
    return [];
  }
}

