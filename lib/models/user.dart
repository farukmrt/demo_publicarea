// class User {
//   final String uid;
//   final String username;
//   final String email;
//   final String name;
//   final String surname;
//   final String building;
//   final String apartmentId;
//   final String buildingId;
//   final String imageUrl;

//   User(
//       {required this.uid,
//       required this.email,
//       required this.username,
//       required this.name,
//       required this.surname,
//       required this.building,
//       required this.apartmentId,
//       required this.buildingId,
//       required this.imageUrl});

//   Map<String, dynamic> toMap() {
//     return {
//       'uid': uid,
//       'username': username,
//       'email': email,
//       'name': name,
//       'surname': surname,
//       'building': building,
//       'apartmentId': apartmentId,
//       'buildingId': buildingId,
//       'imageUrl': imageUrl,
//     };
//   }

//   factory User.fromMap(Map<String, dynamic> map) {
//     return User(
//       uid: map['uid'] ?? '',
//       username: map['username'] ?? '',
//       email: map['email'] ?? '',
//       name: map['name'] ?? '',
//       surname: map['surname'] ?? '',
//       building: map['building'] ?? '',
//       apartmentId: map['apartmentId'] ?? '',
//       buildingId: map['buildingId'] ?? '',
//       imageUrl: map['imageUrl'] ?? '',
//     );
//   }

//   // static User initial() {
//   //   return User(
//   //     uid: '',
//   //     email: '',
//   //     username: '',
//   //     name: '',
//   //     surname: '',
//   //     building: '',
//   //     apartmentId: '',
//   //     buildingId: '',
//   //     imageUrl: '',
//   //   );
//   // }
// }

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
    );
  }
}
