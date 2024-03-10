class Weather {
  final String cityName;
  final double temperature;
  final String mainCondition;

  Weather(
      {required this.cityName,
      required this.temperature,
      required this.mainCondition});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'cityName': cityName,
      'temperature': temperature,
      'mainCondition': mainCondition,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    return Weather(
      cityName: map['name'],
      temperature: map['main']['temp'].toDouble(),
      mainCondition: map['weather'][0]['main'],
    );
  }
}
