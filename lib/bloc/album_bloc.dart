import 'package:flutter_bloc/flutter_bloc.dart';
import '../services/api_service.dart';
import 'album_event.dart';
import 'album_state.dart';

class AlbumBloc extends Bloc<AlbumEvent, AlbumState> {
  final ApiService apiService;

  AlbumBloc({required this.apiService}) : super(AlbumInitial()) {
    on<LoadAlbums>(_onLoadAlbums);
    on<LoadAlbumDetail>(_onLoadAlbumDetail);
    on<RetryLoadAlbums>(_onRetryLoadAlbums);
  }

  Future<void> _onLoadAlbums(LoadAlbums event, Emitter<AlbumState> emit) async {
    try {
      emit(AlbumLoading());
      final albums = await apiService.getAlbums();
      final firstPhotos = await apiService.getFirstPhotoOfAlbums(albums);
      emit(AlbumLoaded(albums: albums, firstPhotos: firstPhotos));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> _onLoadAlbumDetail(
    LoadAlbumDetail event,
    Emitter<AlbumState> emit,
  ) async {
    try {
      emit(AlbumLoading());
      final albums = await apiService.getAlbums();
      final album = albums.firstWhere((album) => album.id == event.albumId);
      final photos = await apiService.getPhotosByAlbumId(event.albumId);
      emit(AlbumDetailLoaded(album: album, photos: photos));
    } catch (e) {
      emit(AlbumError(e.toString()));
    }
  }

  Future<void> _onRetryLoadAlbums(
    RetryLoadAlbums event,
    Emitter<AlbumState> emit,
  ) async {
    await _onLoadAlbums(LoadAlbums(), emit);
  }
}
