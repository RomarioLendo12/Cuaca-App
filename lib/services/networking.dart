import 'dart:convert';
import 'package:http/http.dart' as http;

// Kelas yang berfungsi sebagai interface terhadap API
class Networking {
  final String url;
  // Membuat konstruktor dari kelas Networking
  Networking({required this.url});
  // Function getData sebagai fungsi untuk menghubungkan ke API
  // Function Future tanpa tipe data atau tanpa <> sama dengan Function yang
  // mengembalikan value bertipe data dynamic
  Future getData() async {
    // 1 Koneksi ke API
    http.Response response = await http.get(
      Uri.parse(url),
    );
    // 2 Jika berhasil maka terkoneksi maka hasil akan dimasukan ke variable data
    // dan dikembalikan dalam jsondDecode(data)
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
