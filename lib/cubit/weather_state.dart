part of 'weather_cubit.dart';

@immutable
abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  WeatherLoaded({required this.weather});
}

class WeatherError extends WeatherState {
  final String errorMessage;

  WeatherError({required this.errorMessage});
}
