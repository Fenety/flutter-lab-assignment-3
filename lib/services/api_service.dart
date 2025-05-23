import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album.dart';
import '../models/photo.dart';

class ApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<Album>> getAlbums() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/albums'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Album.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load albums');
      }
    } catch (e) {
      throw Exception('Failed to fetch albums: $e');
    }
  }

  Future<List<Photo>> getPhotosByAlbumId(int albumId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/photos?albumId=$albumId'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => Photo.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load photos');
      }
    } catch (e) {
      throw Exception('Failed to fetch photos: $e');
    }
  }

  Future<List<Photo>> getFirstPhotoOfAlbums(List<Album> albums) async {
    try {
      final List<Photo> firstPhotos = [];
      for (var album in albums) {
        final photos = await getPhotosByAlbumId(album.id);
        if (photos.isNotEmpty) {
          firstPhotos.add(photos.first);
        }
      }
      return firstPhotos;
    } catch (e) {
      throw Exception('Failed to fetch first photos: $e');
    }
  }
}
