import 'package:equatable/equatable.dart';

abstract class AlbumEvent extends Equatable {
  const AlbumEvent();

  @override
  List<Object?> get props => [];
}

class LoadAlbums extends AlbumEvent {}

class LoadAlbumDetail extends AlbumEvent {
  final int albumId;

  const LoadAlbumDetail(this.albumId);

  @override
  List<Object?> get props => [albumId];
}

class RetryLoadAlbums extends AlbumEvent {}
