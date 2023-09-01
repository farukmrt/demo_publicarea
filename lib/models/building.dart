class BuildingModel {
  final String buildName;
  final String buildingId;
  final String country;
  final String town;
  final String imageUrl;

  BuildingModel({
    required this.buildName,
    required this.buildingId,
    required this.country,
    required this.town,
    required this.imageUrl,
  });

  factory BuildingModel.fromFirestore(Map<String, dynamic> map) {
    return BuildingModel(
      buildName: map["buildName"],
      buildingId: map['buildingId'],
      country: map["country"],
      imageUrl: map['imageUrl'],
      town: map["town"],
    );
  }
}
