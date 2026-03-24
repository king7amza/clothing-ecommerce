class UserAssetsModel {
  final String? id;
  final String? profileImage;

  UserAssetsModel({this.id, this.profileImage});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'profileImage': profileImage};
  }

  factory UserAssetsModel.fromMap(Map<String, dynamic> map) {
    return UserAssetsModel(
      id: map['id'] != null ? map['id'] as String : null,
      profileImage: map['profileImage'] != null
          ? map['profileImage'] as String
          : null,
    );
  }
}
