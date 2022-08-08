class User {
  static User? _user;

  String surname;
  String lastname;
  String matricNumber;
  String college;
  String department;
  String level;
  String avatarURL;
  String email;
  String password;
  String telephone;

  User(
      {this.surname = "",
      this.lastname = "",
      this.matricNumber = "",
      this.level = "",
      this.college = "",
      this.department = "",
      this.avatarURL = "",
      this.email = "",
      this.password = "",
      this.telephone = ""});

  static User? getUser() {
    return _user;
  }

  static void setUser(User? user) {
    _user = user;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    User user = User();
    user.surname = json["firstName"];
    user.lastname = json["lastName"];
    user.level = json["level"];
    user.college = json["college"];
    user.department = json["department"];
    user.matricNumber = json["matricNumber"];
    user.telephone = json["telephone"];
    user.avatarURL = json["avatarURL"];
    return user;
  }

  Map<String, dynamic> toJson() {
    return {
      "firstName": surname,
      "lastName": lastname,
      "level": level,
      "college": college,
      "department": department,
      "matricNumber": matricNumber,
      "telephone" : telephone,
      "avatarURL" : avatarURL
    };
  }
}
