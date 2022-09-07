class User {
  static User? _user;

  String email;
  bool admin;
  String token;

  User({this.email = "", this.token = "", this.admin = false});

  static User? getUser() {
    return _user;
  }

  static void setUser(User? user) {
    _user = user;
  }
}
