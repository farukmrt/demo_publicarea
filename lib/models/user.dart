class User {
  final String uid;
  final String username;
  final String email;
  final String name;
  final String surname;
  final String building;
  final String apartmentId;
  final String buildingId;

  User({
    required this.uid,
    required this.email,
    required this.username,
    required this.name,
    required this.surname,
    required this.building,
    required this.apartmentId,
    required this.buildingId,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      'name': name,
      'surname': surname,
      'building': building,
      'apartmentId': apartmentId,
      'buildingId': buildingId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      surname: map['surname'] ?? '',
      building: map['building'] ?? '',
      apartmentId: map['apartmentId'] ?? '',
      buildingId: map['buildingId'] ?? '',
    );
  }
}
