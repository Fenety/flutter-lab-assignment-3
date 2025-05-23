import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'services/api_service.dart';
import 'bloc/album_bloc.dart';
import 'views/album_list_screen.dart';
import 'views/album_detail_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  static final apiService = ApiService();
  static final albumBloc = AlbumBloc(apiService: apiService);
  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          pageBuilder:
              (context, state) => CustomTransitionPage(
                key: state.pageKey,
                child: BlocProvider.value(
                  value: albumBloc,
                  child: const AlbumListScreen(),
                ),
                transitionsBuilder: (
                  context,
                  animation,
                  secondaryAnimation,
                  child,
                ) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
        ),
        GoRoute(
          path: '/album/:id',
          pageBuilder: (context, state) {
            final albumId = int.parse(state.pathParameters['id'] ?? '0');
            return CustomTransitionPage(
              key: state.pageKey,
              child: BlocProvider.value(
                value: albumBloc,
                child: AlbumDetailScreen(albumId: albumId),
              ),
              transitionsBuilder: (
                context,
                animation,
                secondaryAnimation,
                child,
              ) {
                return SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(1.0, 0.0),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                );
              },
            );
          },
        ),
      ],
    );
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Photo Albums',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        scaffoldBackgroundColor: Colors.white,
        cardColor: const Color(0xFFF5EBE0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFFD5BDAF),
          foregroundColor: Colors.black87,
        ),
      ),
      routerConfig: router,
    );
  }
}
