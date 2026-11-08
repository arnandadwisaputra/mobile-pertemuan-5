import '../models/post.dart';

/// Kontrak/Interface abstraksi untuk operasi data Post.
abstract class PostRepository {
  /// Mengambil daftar semua postingan dari data source.
  Future<List<Post>> getPosts();
}
