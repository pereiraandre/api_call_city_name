class WeatherModel {
  final String? name;
  final double? temp;

  WeatherModel(this.name, this.temp);

  WeatherModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        temp = json['main']['temp'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'main': {'temp': temp}
      };
}
