import 'networking.dart';
import 'location.dart';

const apiKey = '4372d30787ce8a8b9035ed729003b5c8';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';

// Kelas yang berisi function untuk mengambil data dari API
class Weather {
  // Function yang berfungsi untuk mengambil data dari OpenWeatherMapAPI

  Future<dynamic> getCityWeather(String cityName) async {
    Networking networking = Networking(
        url: '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networking.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    // 1 Membuat objek dari kelas location.dart
    Location location = Location();
    // 2 Menggunakan function future getCurrentLocation milik kelas location.dart
    await location.getCurrentLocation();

    // 3 Membuat objek dari kelas networking sekaligus memasukan value pada constructornya
    Networking networkHelper = Networking(
        url:
            '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
    // 4 Memasukan hasil kembalian dari function getData yang ada didalam kelas network ke variabel weatherData
    var weatherData = await networkHelper.getData();
    // 5 Mengembalikan weatherData sebagai kembalian dari function getLocationWeather
    return weatherData;
  }
}
