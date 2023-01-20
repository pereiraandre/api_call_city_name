import '../model/weather_model.dart';
import 'networkhelper.dart';

const apiKey = '69bdcf592dddb1852a6b57abf8b2737d';
const openWeatherMapURL = 'http://api.openweathermap.org/data/2.5/weather';

class WeatherServices {

  Future<dynamic> getCityWeather(String cityName) async {
    NetworkHelper networkHelper = NetworkHelper(
        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
    var weatherMap = await networkHelper.getData();
    if(weatherMap == null){
      return null;
    }
    WeatherModel weatherModel = WeatherModel.fromJson(weatherMap);
    return weatherModel;

  }
}
