import 'dart:convert';
import 'package:flutter/services.dart';

class MockDataService {
  static final MockDataService _instance = MockDataService._internal();
  factory MockDataService() => _instance;
  MockDataService._internal();

  Map<String, dynamic>? _cachedData;

  Future<Map<String, dynamic>> _loadData() async {
    if (_cachedData != null) {
      return _cachedData!;
    }
    final jsonString = await rootBundle.loadString('assets/mock/mock_data.json');
    _cachedData = json.decode(jsonString) as Map<String, dynamic>;
    return _cachedData!;
  }

  Future<Map<String, dynamic>> getUser() async {
    final data = await _loadData();
    return Map<String, dynamic>.from(data['user'] as Map);
  }

  Future<List<Map<String, dynamic>>> getMeters() async {
    final data = await _loadData();
    final list = data['meters'] as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<List<Map<String, dynamic>>> getNotifications() async {
    final data = await _loadData();
    final list = data['notifications'] as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<List<Map<String, dynamic>>> getRechargeHistory() async {
    final data = await _loadData();
    final list = data['recharge_history'] as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<List<Map<String, dynamic>>> getUsageRecords() async {
    final data = await _loadData();
    final list = data['usage_records'] as List;
    return list.map((e) => Map<String, dynamic>.from(e as Map)).toList();
  }

  Future<Map<String, dynamic>> getUsageChart() async {
    final data = await _loadData();
    return Map<String, dynamic>.from(data['usage_chart'] as Map);
  }
}
