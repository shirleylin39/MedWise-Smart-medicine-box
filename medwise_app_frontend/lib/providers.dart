import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectProvider extends ChangeNotifier {
  bool isPaired = false;
  String? serialNumber;
  String? takerName;
  String? boxMode;
  String? carerName;
  int? intakeTimes;

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

  void reset() {
    isPaired = false;
    serialNumber = null;
    takerName = null;
    boxMode = null;
    carerName = null;
    intakeTimes = null;
    notifyListeners();
  }

  Map<String, dynamic> getDeviceInfo() {
    return {
      'is_paired': isPaired,
      'serial_number': serialNumber,
      'taker_name': takerName,
      'box_mode': boxMode,
      'carer_name': carerName,
      'intake_times': intakeTimes,
    };
  }
}

