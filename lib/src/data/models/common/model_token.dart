class Token {
  Token(
      {this.token,
      this.refreshToken,
      this.expiration,
      this.refreshTokenExpiration,
      this.id});

  String? token;
  String? refreshToken;
  String? expiration;
  String? refreshTokenExpiration;
  String? id;

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        token: json["Token"],
        refreshToken: json["RefreshToken"],
        expiration: json["Expiration"],
        refreshTokenExpiration: json["RefreshTokenExpiration"],
        id: json["Id"],
      );

  Map<String, dynamic> toJson() => {
        "Token": token,
        "RefreshToken": refreshToken,
        "Expiration": expiration,
        "RefreshTokenExpiration": refreshTokenExpiration,
        "Id": id
      };
}
