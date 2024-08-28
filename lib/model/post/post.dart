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
  final String pdfUrl;
  final String id;
  final String name;
  final String dp;
  final List<String> imageUrl;
  final String description;
  final String title;
  final String myClass;
  final String certified;
  final String senderId;
  final DateTime? createdAT;

  Data({
    this.pdfUrl = "",
    this.id = "",
    this.name = "",
    this.dp = "",
    this.imageUrl = const [],
    this.description = "",
    this.title = "",
    this.myClass = "",
    this.certified = "",
    this.senderId = "",
    this.createdAT,
  });

  factory Data.fromMap(Map<String, dynamic> json) {
    return Data(
      pdfUrl: json['pdfUrl'] ?? '', // Handle null with default value
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      dp: json['dp'] ?? '',
      imageUrl: json['image_url'] != null
          ? List<String>.from(json['image_url'])
          : [],
      description: json['description'] ?? '',
      title: json['title'] ?? '',
      myClass: json['myClass'] ?? '',
      certified: json['certified'] ?? '',
      senderId: json['senderId'] ?? '',
      createdAT: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt']) // Safely parse DateTime
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'pdfUrl': pdfUrl,
      'id': id,
      'name': name,
      'dp': dp,
      'image_url': imageUrl,
      'description': description,
      'title': title,
      'myClass': myClass,
      'certified': certified,
      'senderId': senderId,
      'createdAt': createdAT?.toIso8601String(), // Handle null values
    };
  }
}
