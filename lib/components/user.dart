class User {
  static final User _user = User();

  String surname;
  String lastname;
  String matricNumber;
  String college;
  String department;
  String level;
  String avatarURL;
  String email;
  String password;

  User(
      {this.surname = "",
      this.lastname = "",
      this.matricNumber = "",
      this.level = "",
      this.college = "",
      this.department = "",
      this.avatarURL = "",
      this.email = "",
      this.password = ""});

  static User getUser() {
    return _user;
  }
}
