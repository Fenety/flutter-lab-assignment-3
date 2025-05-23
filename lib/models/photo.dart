import 'package:equatable/equatable.dart';

class Photo extends Equatable {
  final int id;
  final int albumId;
  final String title;
  final String url;
  final String thumbnailUrl;
  final DateTime? dateTaken;

  const Photo({
    required this.id,
    required this.albumId,
    required this.title,
    required this.url,
    required this.thumbnailUrl,
    this.dateTaken,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'] as int,
      albumId: json['albumId'] as int,
      title: json['title'] as String,
      url: json['url'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      dateTaken: DateTime.now(), // Since the API doesn't provide this
    );
  }

  @override
  List<Object?> get props => [id, albumId, title, url, thumbnailUrl, dateTaken];
}
