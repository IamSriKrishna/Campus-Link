import 'dart:convert';

class Post {
  final String id;
  final String name;
  final String dp;
  final List<String> image_url;
  final List<String> likes;
  final String description;
  final String title;
  final String link;
  final DateTime createdAt;
  final String pdfUrl;
  final String senderId;
  final String myClass;
  final String certified;

  Post({
    required this.id,
    required this.name,
    required this.dp,
    required this.image_url,
    required this.senderId,
    required this.pdfUrl,
    required this.likes,
    required this.description,
    required this.title,
    required this.createdAt,
    required this.myClass,
    required this.certified,
    required this.link,
  });

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['_id'] ?? '',
      name: map['name'] ?? '',
      senderId: map['senderId'] ?? '',
      myClass: map['myClass'] ?? '',
      certified: map['certified'] ?? '',
      dp: map['dp'] ?? '',
      image_url: List<String>.from(map['image_url']),
      likes: List<String>.from(map['likes']),
      pdfUrl: map['pdfUrl'] ?? '',
      description: map['description'] ?? '',
      title: map['title'] ?? '',
      createdAt: DateTime.parse(map['createdAt']),
      link: map['link'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dp': dp,
      'senderId': senderId,
      'myClass': myClass,
      'image_url': image_url,
      'pdfUrl': pdfUrl,
      'likes': likes,
      'certified': certified,
      'description': description,
      'title': title,
      'link': link,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  String toJson() => json.encode(toMap());
  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  Post copyWith({
    String? id,
    String? name,
    List<String>? image,
    String? title,
    String? senderId,
    List<String>? likes,
    String? dp,
    String? pdfUrl,
    String? myClass,
    String? certified,
    String? description,
    String? link,
    DateTime? createdAt,
  }) {
    return Post(
        id: id ?? this.id,
        name: name ?? this.name,
        pdfUrl: pdfUrl??this.pdfUrl,
        myClass: myClass ?? this.myClass,
        certified: certified ?? this.certified,
        dp: dp ?? this.dp,
        senderId: senderId ?? this.senderId,
        image_url: image ?? this.image_url,
        likes: likes ?? this.likes,
        description: description ?? this.description,
        title: title ?? this.title,
        createdAt: createdAt ?? this.createdAt,
        link: link ?? this.link);
  }
}
