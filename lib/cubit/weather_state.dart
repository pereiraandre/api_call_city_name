part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;
  String? keepWeather;

  WeatherLoaded({required this.weather, this.keepWeather});
}

class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError({required this.errorMessage});
}
