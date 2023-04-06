class Profile {
  String password = '';
  String email = '';
  String confirm = '';
  void set_password(String password) => this.password = password;
  void set_email(String email) => this.email = email;
  void set_confirm(String confirm) => this.confirm = confirm;
  String get get_password => password;
  String get get_email => email;
  String get get_confirm => confirm;
}
