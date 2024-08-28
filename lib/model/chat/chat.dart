class ChatModel {
  final List<GetChat> chat;

  ChatModel({this.chat = const []});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['msg'] as List? ?? [];
    List<GetChat> data = dataList.map((e) => GetChat.fromJson(e)).toList();
    return ChatModel(chat: data);
  }

  Map<String, dynamic> toMap() {
    return {"msg": chat.map((item) => item.toJson()).toList()};
  }
}

class GetChat {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<Sender> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final LatestMessage? latestMessage;

  GetChat({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    this.latestMessage,
  });

  factory GetChat.fromJson(Map<String, dynamic> json) {
    return GetChat(
      id: json["_id"],
      chatName: json["chatName"],
      isGroupChat: json["isGroupChat"],
      users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
      createdAt: DateTime.parse(json["createdAt"]),
      updatedAt: DateTime.parse(json["updatedAt"]),
      latestMessage: json["latestMessage"] != null
          ? LatestMessage.fromJson(json["latestMessage"])
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "latestMessage": latestMessage?.toJson(),
      };
}

class LatestMessage {
  final String id;
  final Sender sender;
  final String content;
  final String receiver;
  final String chat;
  final List<String> readBy;
  final DateTime createdAt;
  final DateTime updatedAt;

  LatestMessage({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.readBy,
    required this.createdAt,
    required this.updatedAt,
  });

  factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
        readBy: List<String>.from(json["readBy"] ?? []),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat,
        "readBy": List<dynamic>.from(readBy),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}
class Sender {
  final String id;
  final String name;
  final int rollno;
  final int credit;
  final String dp;
  final String department;
  final String studentclass;
  final String year;
  final String bio;
  final bool certified;
  final String fcmtoken;
  final bool blocked;
  final List<String> followers;
  final List<String> following;

  Sender({
    required this.id,
    required this.name,
    required this.rollno,
    required this.credit,
    required this.dp,
    required this.department,
    required this.studentclass,
    required this.year,
    required this.bio,
    required this.certified,
    required this.fcmtoken,
    required this.blocked,
    required this.followers,
    required this.following,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        rollno: json["rollno"] ?? 0, // Provide a default value if null
        credit: json["credit"] ?? 0, // Provide a default value if null
        dp: json["dp"] ?? "",
        department: json["department"] ?? "",
        studentclass: json["Studentclass"] ?? "",
        year: json["year"] ?? "",
        bio: json["bio"] ?? "",
        certified: json["certified"] ?? false,
        fcmtoken: json["fcmtoken"] ?? "",
        blocked: json["blocked"] ?? false,
        followers: List<String>.from(json["followers"] ?? []),
        following: List<String>.from(json["following"] ?? []),
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "rollno": rollno,
        "credit": credit,
        "dp": dp,
        "department": department,
        "Studentclass": studentclass,
        "year": year,
        "bio": bio,
        "certified": certified,
        "fcmtoken": fcmtoken,
        "blocked": blocked,
        "followers": List<dynamic>.from(followers),
        "following": List<dynamic>.from(following),
      };
}
