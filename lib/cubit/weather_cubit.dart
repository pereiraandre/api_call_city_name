import 'package:api_call_city_name/model/weather_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../service/weather.dart';
import '../data_provider.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final TempDataProvider tempDataProvider;

  WeatherCubit(this.tempDataProvider) : super(WeatherInitial());


  void getLastValues() async {
    emit(WeatherLoading());
    final String? lastCity =
    await tempDataProvider.getTempData(DataTypes.name);
    final String? lastTemp =
    await tempDataProvider.getTempData(DataTypes.temperature);
    emit(WeatherLoaded(lastCity: lastCity, lastTemp: lastTemp));

  }

  Future<void> getWeather(String city) async {
    var lastState = state;

    emit(WeatherLoading());
    try {
      final WeatherModel weather = await WeatherServices().getCityWeather(city);
      final String? lastCity =
          await tempDataProvider.getTempData(DataTypes.name);
      final String? lastTemp =
          await tempDataProvider.getTempData(DataTypes.temperature);
      emit(WeatherLoaded(
          weather: weather, lastCity: lastCity, lastTemp: lastTemp));
      tempDataProvider.setTempData(DataTypes.name, weather.name);
      tempDataProvider.setTempData(
          DataTypes.temperature, weather.temp.toString());
    } catch (e) {
      emit(WeatherError(errorMessage: e.toString()));
      emit(lastState);
    }
  }
}
