class Description {
  final String titlee;
  final String subtitlee;

  const Description({
    required this.titlee,
    required this.subtitlee,
  });

  Map<String, dynamic> toMap() {
    return {
      'titlee': titlee,
      'subtitlee': subtitlee,
    };
  }

  factory Description.fromMap(Map<String, dynamic> map) {
    return Description(
      titlee: map['titlee'] ?? '',
      subtitlee: map['subtitlee'] ?? '',
    );
  }
}
