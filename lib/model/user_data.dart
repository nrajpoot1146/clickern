import 'dart:convert';

class UserData {
  String firstName;
  String lastName;
  String username;
  String email;
  String mobileNumber;

  UserData({
    this.firstName = "",
    this.lastName = "",
    this.username = "",
    this.email = "",
    this.mobileNumber = "",
  });

  UserData copyWith({
    String? firstName,
    String? lastName,
    String? username,
    String? email,
    String? mobileNumber,
  }) {
    return UserData(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      username: username ?? this.username,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'user_name': username,
      'email': email,
      'mob_no': mobileNumber,
    };
  }

  factory UserData.fromMap(Map<String, dynamic> map) {
    return UserData(
      firstName: map['first_name'],
      lastName: map['last_name'],
      username: map['user_name'],
      email: map['email'],
      mobileNumber: map['mob_no'],
    );
  }

  String toJson() => json.encode(toMap());

  factory UserData.fromJson(String source) =>
      UserData.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserData(firstName: $firstName, lastName: $lastName, username: $username, email: $email, mobileNumber: $mobileNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserData &&
        other.firstName == firstName &&
        other.lastName == lastName &&
        other.username == username &&
        other.email == email &&
        other.mobileNumber == mobileNumber;
  }

  @override
  int get hashCode {
    return firstName.hashCode ^
        lastName.hashCode ^
        username.hashCode ^
        email.hashCode ^
        mobileNumber.hashCode;
  }
}
