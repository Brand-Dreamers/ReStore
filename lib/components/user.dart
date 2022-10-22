class User {
  static User? _user;

  String email;
  bool admin;
  String token;
  String id;
  String surname;
  String lastname;
  String matricNumber;
  String college;
  String department;
  String level;
  String telephone;

  User({
    this.email = "",
    this.token = "",
    this.id = "",
    this.surname = "",
    this.lastname = "",
    this.matricNumber = "",
    this.college = "",
    this.department = "",
    this.level = "",
    this.telephone = "",
    this.admin = false,
  });

  @override
  String toString() {
    return "User { email: $email token: $token id: $id}";
  }

  static User? getUser() {
    return _user;
  }

  static void setUser(User? user) {
    _user = user;
  }
}
