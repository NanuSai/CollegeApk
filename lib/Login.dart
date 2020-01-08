class Login {
  String username;
  String password;

  Login({this.username = "Anonymous", this.password = ""});


  factory Login.fromJson(Map<String, dynamic> json) {
    return Login(username: json['username'] ?? "none", password: json['password']) ?? "none";
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
