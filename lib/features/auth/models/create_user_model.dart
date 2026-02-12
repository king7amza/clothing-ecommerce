class CreateUserModel {
  final String id;
  final String name;
  final String email;
  final String createdAt;

  const CreateUserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'createdAt': createdAt,
    };
  }

  factory CreateUserModel.fromMap(Map<String, dynamic> map) {
    return CreateUserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      createdAt: map['createdAt'] as String,
    );
  }
}
