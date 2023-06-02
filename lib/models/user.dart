class User {
  final String uid;
  final String username;
  final String email;
  // final String? name;
  // final String? surname;
  // final String? building;
  //final String dob;

  User({
    required this.uid,
    required this.email,
    required this.username,
    // this.name,
    // this.surname,
    // this.building,
    //required this.dob,
  });

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
    );
  }
}
