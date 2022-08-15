class Acctuator {
  final String identifier;
  final String status;


  const Acctuator({ required this.identifier, required this.status, });

  factory Acctuator.fromJson(Map<String, dynamic> json) {
    return Acctuator(
        identifier: json['username'],
        status: json['accessToken'],

    );

  }

}