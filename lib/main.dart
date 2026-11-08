import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'config/app_config.dart';
import 'config/dependency_injector.dart';
import 'screens/post_list_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Muat file .env
  await dotenv.load(fileName: ".env");

  // Periksa konfigurasi
  if (!AppConfig.isConfigured()) {
    print('⚠️ Konfigurasi .env tidak lengkap. Periksa file .env Anda.');
  }

  runApp(
    // Membungkus seluruh aplikasi menggunakan DependencyInjector ke dalam widget tree
    DependencyInjector(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RPL & Keamanan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Builder(
        builder: (context) {
          // Menyediakan dependency secara dinamis melalui InheritedWidget context
          final injector = DependencyInjector.of(context);
          return PostListScreen(postRepository: injector.postRepository);
        },
      ),
    );
  }
}
