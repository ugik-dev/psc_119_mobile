class User {
  String id_user;
  String nama;
  String email;
  String token;

  // User({this.id = 0, this.name = "", this.email = "", this.token = ""});
  User({this.id_user = "", this.nama = "", this.email = "",this.token = ""});
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id_user: json['id_user'],
      nama: json['nama'],
      email: json['email'],
      token: json['token'],
    );
  }
}
