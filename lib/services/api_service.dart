import 'dart:convert';
import '../models/place.dart';

class ApiService {
  // API getAllPlace để load dữ liệu động cho home page
  static Future<List<Place>> getAllPlace() async {
    try {
      // Giả lập API call - trong thực tế sẽ gọi API thật
      await Future.delayed(Duration(seconds: 2));

      // Dữ liệu mẫu thay cho API response
      List<Map<String, dynamic>> mockData = [
        {
          'id': 1,
          'name': 'New York',
          'image': 'https://images.unsplash.com/photo-1496442226666-8d4d0e62e6e9?w=400',
          'category': 'Hotels',
          'isFavorite': false,
        },
        {
          'id': 2,
          'name': 'Big Ben',
          'image': 'https://images.unsplash.com/photo-1513635269975-59663e0ac1ad?w=400',
          'category': 'Flights',
          'isFavorite': true,
        },
        {
          'id': 3,
          'name': 'Paris',
          'image': 'https://images.unsplash.com/photo-1502602898536-47ad22581b52?w=400',
          'category': 'Hotels',
          'isFavorite': false,
        },
        {
          'id': 4,
          'name': 'Tokyo',
          'image': 'https://images.unsplash.com/photo-1540959733332-eab4deabeeaf?w=400',
          'category': 'All',
          'isFavorite': true,
        },
        {
          'id': 5,
          'name': 'Sydney',
          'image': 'https://images.unsplash.com/photo-1506905925346-21bda4d32df4?w=400',
          'category': 'Flights',
          'isFavorite': false,
        },
        {
          'id': 6,
          'name': 'Rome',
          'image': 'https://images.unsplash.com/photo-1515542622106-78bda8ba0e5b?w=400',
          'category': 'Hotels',
          'isFavorite': true,
        },
      ];

      return mockData.map((json) => Place.fromJson(json)).toList();

    } catch (e) {
      print('Error loading places: $e');
      throw Exception('Failed to load places');
    }
  }
}