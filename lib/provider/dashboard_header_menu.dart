import 'package:flutter/foundation.dart';

class DashboardHeaderMenu {
  List<Map<String, Object>> headerMenu = [
    {
      'key': 'Doctor',
      'value': ['Doctor']
    },
    {
      'key': 'Clinics',
      'value': ['Clinics']
    },
    {
      'key': 'Hospitals',
      'value': ['Hospitals']
    },
    {
      'key': 'Homecare',
      'value': ['Homecare']
    },
    {
      'key': 'Fitness',
      'value': ['Fitness']
    },
  ];

  List<Map<String, Object>> getMenu() {
    return [...headerMenu];
  }
}
