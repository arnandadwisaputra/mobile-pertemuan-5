import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../repositories/user_repository.dart';
import '../repositories/user_repository_impl.dart';
import '../repositories/post_repository.dart';
import '../repositories/post_repository_impl.dart';

/// Komponen kontainer Dependency Injection berbasis [InheritedWidget].
class DependencyInjector extends InheritedWidget {
  final ApiService apiService;
  final UserRepository userRepository;
  final PostRepository postRepository;

  DependencyInjector({
    super.key,
    required super.child,
  })  : apiService = ApiService(), // Diinstansiasi sekali (Singleton Pattern)
        userRepository = UserRepositoryImpl(),
        postRepository = PostRepositoryImpl(ApiService());

  /// Metode statis helper untuk mengambil instansi dependensi dari widget tree.
  static DependencyInjector of(BuildContext context) {
    final DependencyInjector? injector =
        context.dependOnInheritedWidgetOfExactType<DependencyInjector>();
    assert(injector != null, 'DependencyInjector tidak ditemukan di Context widget tree');
    return injector!;
  }

  @override
  bool updateShouldNotify(DependencyInjector oldWidget) => false;
}
