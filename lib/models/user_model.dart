class UserModel {
  final String? id;
  final String username;
  final String email;
  final String password;
  final bool isVendor;

  UserModel(
      {this.id,
      required this.username,
      required this.email,
      required this.isVendor,
      required this.password});

  toJson() {
    return {
      "username": username,
      "email": email,
      "isVendor": isVendor,
      "password": password,
    };
  }
}
