class FetchedData {
  final String humidity;
  final int temperature;
  final String motion;
  final String light1;


  const FetchedData({ required this.humidity, required this.temperature, required this.motion, required this.light1});

  factory FetchedData.fromJson(Map<String, dynamic> json) {
    return FetchedData(
      humidity: json['humiity'],
      temperature: json['temperature'],
      motion: json['motion'],
      light1: json['light1'].toString(),


    );

  }

}
