import 'package:api_call_city_name/model/weather_model.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../service/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit() : super(WeatherInitial());



  Future<void> getWeather(String city) async {
    emit(WeatherLoading());

      var lastState = state;
      emit(WeatherLoading());
      Future.delayed(const Duration(seconds: 3), () async {
        try {
          emit(WeatherLoaded(weather: await WeatherServices().getCityWeather(city)));
        } catch (e) {
          emit(WeatherError(errorMessage: e.toString()));
          emit(lastState);
        }
      },);
    }
}
