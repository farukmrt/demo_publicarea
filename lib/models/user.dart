class UserModel {
  final String uid;
  final String email;
  final String username;
  final String name;
  final String surname;
  final String building;
  final String apartmentId;
  final String buildingId;
  final String imageUrl;
  final String phoneNumber;

  UserModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.name,
    required this.surname,
    required this.building,
    required this.apartmentId,
    required this.buildingId,
    required this.imageUrl,
    required this.phoneNumber,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      username: map['username'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      building: map['building'] ?? '',
      apartmentId: map['apartmentId'] ?? '',
      buildingId: map['buildingId'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
    );
  }
  factory UserModel.fromFirestore(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      username: map['username'],
      name: map['name'],
      surname: map['surname'],
      building: map['building'],
      apartmentId: map['apartmentId'],
      buildingId: map['buildingId'],
      imageUrl: map['imageUrl'],
      phoneNumber: map['phoneNumber'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'username': username,
      'name': name,
      'surname': surname,
      'building': building,
      'apartmentId': apartmentId,
      'buildingId': buildingId,
      'imageUrl': imageUrl,
      'phoneNumber': phoneNumber,
    };
  }

  UserModel copyWith({
    String? uid,
    String? email,
    String? username,
    String? name,
    String? surname,
    String? building,
    String? apartmentId,
    String? buildingId,
    String? imageUrl,
    String? phoneNumber,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      username: username ?? this.username,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      building: building ?? this.building,
      apartmentId: apartmentId ?? this.apartmentId,
      buildingId: buildingId ?? this.buildingId,
      imageUrl: imageUrl ?? this.imageUrl,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}
