class UserModel {
  final int userID;
  final String email;
  final int statusCode;
  final String username;
  UserModel(
      {required this.userID,
      required this.username,
      required this.email,
      required this.statusCode});

  factory UserModel.fromJson(Map<String, dynamic> data) {
    final userID = data['id'] as int;
    final email = data['email'] as String;
    final statusCode = data['status'] as int;
    final username = data['username'] as String;

    return UserModel(
        email: email,
        userID: userID,
        username: username,
        statusCode: statusCode);
  }
}
