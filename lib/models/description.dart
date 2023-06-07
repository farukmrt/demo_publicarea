class Description {
  final String? build_uid;
  final String titlee;
  final String subtitlee;

  const Description({
    this.build_uid,
    required this.titlee,
    required this.subtitlee,
  });

  Map<String, dynamic> toMap() {
    return {
      'build': build_uid,
      'titlee': titlee,
      'subtitlee': subtitlee,
    };
  }

  factory Description.fromMap(Map<String, dynamic> map) {
    return Description(
      build_uid: map['build_uid'] ?? '',
      titlee: map['titlee'] ?? '',
      subtitlee: map['subtitlee'] ?? '',
    );
  }
}
