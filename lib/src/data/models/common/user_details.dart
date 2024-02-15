import 'model_token.dart';
import 'model_user.dart';

class UserDetail {
  UserDetail({
    this.token,
    this.user,
  });

  Token? token;
  User? user;

  factory UserDetail.fromJson(Map<String, dynamic> json) => UserDetail(
    token: Token.fromJson(json["token"]),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token!.toJson(),
    "user": user!.toJson(),
  };
}