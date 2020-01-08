class User {
  String username;
  String password;

  User({this.username = "Anonymous", this.password = ""});


  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        username: json['username'] ?? "none", password: json['password']) ??
        "none";
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map['username'] = username;
    map['password'] = password;

    return map;
  }

  @override
  String toString() {
    return this.username;
  }
}
