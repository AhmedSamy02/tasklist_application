class Media {
  String? id;
  String? name;
  String? mediaLink;
  Media({
    required this.id,
    required this.name,
    required this.mediaLink,
  });
  factory Media.fromJson(Map<String, dynamic> json) {
    return Media(
      id: json['id'],
      name: json['name'],
      mediaLink: json['mediaLink'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mediaLink': mediaLink,
    };
  }
}
