import 'package:flutter_test/flutter_test.dart';
import 'package:secure_http/utils/validators.dart'; // Sesuaikan jika nama package Anda berbeda

void main() {
  group('Validators Unit Test - Kelompok Pengujian Keamanan Input', () {
    
    // a) Uji coba isValidEmail()
    test('Pengujian isValidEmail() dengan berbagai skenario format input', () {
      expect(Validators.isValidEmail('mahasiswa@amikom.ac.id'), true);
      expect(Validators.isValidEmail('://salah.com'), false);
      expect(Validators.isValidEmail('test@domain'), false);
    });

    // b) Uji coba sanitize() - SUDAH DIPERBAIKI
    test('Pengujian sanitize() untuk membersihkan elemen input HTML/XSS berbahaya', () {
      const String inputMalicious = "<script>alert('xss_attack');</script>";
      final String secureResult = Validators.sanitize(inputMalicious);
      
      expect(secureResult.contains('<'), false);
      expect(secureResult.contains('>'), false);
      // Memastikan ekspektasi mencocokkan konversi kutip satu menjadi &#x27;
      expect(secureResult, equals("&lt;script&gt;alert(&#x27;xss_attack&#x27;);&lt;/script&gt;"));
    });

    // c) Uji coba validateText()
    test('Pengujian validateText() berdasarkan batasan panjang karakter minimal dan maksimal', () {
      // Uji String Kosong
      expect(Validators.validateText(''), equals('Field tidak boleh kosong'));
      
      // Uji String Kurang dari batas minLength
      expect(
        Validators.validateText('abc', fieldName: 'Nama', minLength: 5),
        equals('Nama harus antara 5-100 karakter'),
      );
      
      // Uji String Valid memenuhi batas aturan panjang
      expect(Validators.validateText('Informatika Amikom Yogyakarta', minLength: 5), isNull);
    });

    // Pengujian Validasi Keamanan Password Ketat
    test('Pengujian validatePassword() berdasarkan kriteria kombinasi karakter aman', () {
      expect(Validators.validatePassword('weak'), contains('minimal harus memiliki panjang 8 karakter'));
      expect(Validators.validatePassword('nopasswordcap1!'), contains('huruf kapital'));
      expect(Validators.validatePassword('SecurePass123!'), isNull); // Lolos validasi penuh
    });
  });
}
