class UserDetailsModel {
  final String name;
  final String email;
  const UserDetailsModel({
    required this.name,
    required this.email,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }

  factory UserDetailsModel.fromMap(Map<String, dynamic> map) {
    return UserDetailsModel(
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}
