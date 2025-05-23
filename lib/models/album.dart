import 'package:equatable/equatable.dart';

class Album extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String? thumbnailUrl;
  final DateTime? dateTaken;
  final String? photographerName;

  const Album({
    required this.id,
    required this.userId,
    required this.title,
    this.thumbnailUrl,
    this.dateTaken,
    this.photographerName,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      // I'm setting defaults
      dateTaken: DateTime.now(),
      photographerName: 'Unknown Photographer',
    );
  }

  @override
  List<Object?> get props => [
    id,
    userId,
    title,
    thumbnailUrl,
    dateTaken,
    photographerName,
  ];
}
