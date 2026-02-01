class ClothesRequestModel {
  final int? limit;
  final int? skip;
  final String? select;
  ClothesRequestModel({this.limit, this.skip, this.select});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'limit': limit, 'skip': skip, 'select': select};
  }

  factory ClothesRequestModel.fromMap(Map<String, dynamic> map) {
    return ClothesRequestModel(
      limit: map['limit'] != null ? map['limit'] as int : null,
      skip: map['skip'] != null ? map['skip'] as int : null,
      select: map['select'] != null ? map['select'] as String : null,
    );
  }
}
