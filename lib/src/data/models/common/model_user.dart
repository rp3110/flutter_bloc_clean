class User {
  User(
      {this.id,
      this.firstName = "",
      this.lastName = "",
      this.email = "",
      this.profileUrl,
      this.profileImageData});

  String? id;
  String? firstName = "";
  String? lastName = "";
  String? email = "";
  String? profileUrl;
  String? profileImageData;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["Id"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        email: json["Email"],
        profileUrl: json["ProfileUrl"],
        profileImageData: json["ProfileImageData"],
      );

  Map<String, dynamic> toJson() => {
        "Id": id,
        "FirstName": firstName,
        "LastName": lastName,
        "Email": email,
        "ProfileUrl": profileUrl,
        "ProfileImageData": profileImageData
      };
}
