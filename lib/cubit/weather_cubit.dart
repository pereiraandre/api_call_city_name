import 'package:api_call_city_name/model/weather_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());

 var keepCityName = '';

  Future<void> getWeather(String city) async {

      var lastState = state;
      emit(WeatherLoading());
      Future.delayed(const Duration(seconds: 3), () async {
        try {
          emit(WeatherLoaded(weather: await WeatherServices().getCityWeather(city), keepWeather: keepCityName));
          if(state is WeatherLoaded){
            keepCityName = city;
          }
        } catch (e) {
          emit(WeatherError(errorMessage: e.toString()));
          emit(lastState);
        }
      },);
    }
}
