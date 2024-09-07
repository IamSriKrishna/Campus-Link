class PostModel {
  List<Data> data;
  
  PostModel({this.data = const []});

  factory PostModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List;
    List<Data> data = dataList.map((i) => Data.fromMap(i)).toList();
    return PostModel(data: data);
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.map((item) => item.toMap()).toList(),
    };
  }
}

class Data {
  final String id;
  final List<String> imageUrl;
  final String description;
  final String title;
  final String link;
  final Sender sender;
  final String pdfUrl;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int version;
  final int reportCount;
  final bool sensitive;
  final List<dynamic> reporters;
  final List<Like> likes;
  final List<Comment> comments;

  Data({
    this.id = '',
    this.imageUrl = const [],
    this.description = '',
    this.title = '',
    this.link = '',
    required this.sender,
    this.pdfUrl = '',
    this.createdAt,
    this.updatedAt,
    this.version = 0,
    this.reportCount = 0,
    this.reporters = const [],
    this.sensitive = false,
    this.likes = const [],
    this.comments = const [],
  });

  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(
      id: json['_id'] ?? '',
      imageUrl: json['image_url'] != null ? List<String>.from(json['image_url']) : [],
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      link: json['link'] ?? '',
      sender: Sender.fromMap(json['senderId']),
      pdfUrl: json['pdfUrl'] ?? '',
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      version: json['__v'] ?? 0,
      reportCount: json['reportCount'] ?? 0,
      reporters: json['reporters'] != null ? List<dynamic>.from(json['reporters']) : [],
      sensitive: json['sensitive'] ?? false,
      likes: json['likes'] != null 
        ? (json['likes'] as List).map((i) => Like.fromMap(i)).toList() 
        : [],
      comments: json['comments'] != null 
        ? (json['comments'] as List).map((i) => Comment.fromMap(i)).toList() 
        : [],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'image_url': imageUrl,
      'description': description,
      'title': title,
      'link': link,
      'senderId': sender.toMap(),
      'pdfUrl': pdfUrl,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': version,
      'reportCount': reportCount,
      'reporters': reporters,
      'sensitive': sensitive,
      'likes': likes.map((item) => item.toMap()).toList(),
      'comments': comments.map((item) => item.toMap()).toList(),
    };
  }
}

class Sender {
  final String id;
  final String name;
  final String dp;
  final bool certified;

  Sender({
    this.id = '',
    this.name = '',
    this.dp = '',
    this.certified = false,
  });

  factory Sender.fromMap(Map<String, dynamic> json) {
    return Sender(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      dp: json['dp'] ?? '',
      certified: json['certified'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'dp': dp,
      'certified': certified,
    };
  }
}

class Like {
  final String id;
  final String name;
  final String dp;

  Like({
    this.id = '',
    this.name = '',
    this.dp = '',
  });

  factory Like.fromMap(Map<String, dynamic> json) {
    return Like(
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      dp: json['dp'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      '_id': id,
      'name': name,
      'dp': dp,
    };
  }
}

class Comment {
  final String studentId;
  final String content;
  final String id;
  final DateTime createdAt;

  Comment({
    this.studentId = '',
    this.content = '',
    this.id = '',
    required this.createdAt,
  });

  factory Comment.fromMap(Map<String, dynamic> json) {
    return Comment(
      studentId: json['studentId'] ?? '',
      content: json['content'] ?? '',
      id: json['_id'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'studentId': studentId,
      'content': content,
      '_id': id,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
