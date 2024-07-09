import 'package:mongo_dart/mongo_dart.dart';

class Media {
  Media({
    required this.id,
    required this.userId,
    required this.link,
  });
  factory Media.fromMap(Map<String, dynamic> map) {
    return Media(
      id: map['_id'] as ObjectId,
      userId: map['user_id'] as String,
      link: map['link'] as String,
    );
  }

  Map<String, String> toMap() {
    return {
      'id': id.oid,
      'user_id': userId,
      'link': link,
    };
  }

  final ObjectId id;
  final String userId;
  final String link;
}
