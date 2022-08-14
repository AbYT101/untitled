class User {
   final String id;
  final String username;
  final String accessToken;
  final String refreshToken;


  const User({required this.id, required this.username, required this.accessToken, required this.refreshToken});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
        accessToken: json['accessToken'],
        refreshToken: json['refreshToken']

    );

  }

}