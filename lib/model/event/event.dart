class Event {
  final bool isAmount;
  final double amount;
  final String id;
  final String title;
  final String image;
  final String link;
  final String description;
  final String createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastDate;
  final List<String> views;

  Event({
    required this.isAmount,
    required this.amount,
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.createdBy,
    required this.link,
    required this.createdAt,
    required this.updatedAt,
    required this.lastDate,
    required this.views,
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      isAmount: json['isAmount'] ?? false,
      amount: json['amount']?.toDouble() ?? 0.0,
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      image: json['image'] ?? '',
      description: json['description'] ?? '',
      link: json['link'] ?? "",
      createdBy: json['createdBy'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      lastDate: DateTime.parse(json['lastDate']),
      views: List<String>.from(json['views'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isAmount': isAmount,
      'amount': amount,
      '_id': id,
      'title': title,
      'image': image,
      'description': description,
      "link": link,
      "lastDate": lastDate,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'views': views,
    };
  }
}

class EventResponse {
  final String status;
  final int length;
  final List<Event> data;

  EventResponse({
    this.status = "no-status",
    this.length = 0,
    this.data = const [],
  });

  factory EventResponse.fromJson(Map<String, dynamic> json) {
    return EventResponse(
      status: json['status'] ?? '',
      length: json['length'] ?? 0,
      data: List<Event>.from(
        json['data']?.map((item) => Event.fromJson(item)) ?? [],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'length': length,
      'data': data.map((event) => event.toJson()).toList(),
    };
  }
}
