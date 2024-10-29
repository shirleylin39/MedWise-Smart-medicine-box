import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectProvider extends ChangeNotifier {
  String? deviceId;
  bool isPaired = false;
  String? serialNumber;
  String? takerName;
  String? boxMode;
  String? carerName;
  int? intakeTimes;


  void addDevice(String id) {
    deviceId = id;
    notifyListeners();
  }

  void setPaired(bool paired) {
    isPaired = paired;
    notifyListeners();
  }

  void setSerialNumber(String? serial) {
    serialNumber = serial;
    notifyListeners();
  }

  void setTakerName(String name) {
    takerName = name;
    notifyListeners();
  }

  void setBoxMode(String mode) {
    boxMode = mode;
    notifyListeners();
  }

  void setCarerName(String name) {
    carerName = name;
    notifyListeners();
  }

  void setIntakeTimes(int times) {
    intakeTimes = times;
    notifyListeners();
  }

  Map<String, dynamic> getDeviceInfo() {
    return {
      'device_id': deviceId,
      'isPaired': isPaired,
      'serial_number': serialNumber,
      'taker_name': takerName,
      'box_mode': boxMode,
      'carer_name': carerName,
      'intake_times': intakeTimes,
    };
  }
}

