class MessageModel {
  final List<Message> chat;

  MessageModel({this.chat = const []});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    var dataList = json['msg'] as List? ?? [];
    List<Message> data = dataList.map((e) => Message.fromJson(e)).toList();
     data.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return MessageModel(chat: data);
  }

  Map<String, dynamic> toMap() {
    return {
      "msg": chat.map((item) => item.toJson()).toList(),
    };
  }
}

class Message {
  final String id;
  final Sender sender;
  final String content;
  final String receiver;
  final Chat chat;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<dynamic> readBy;
  final int v;

  Message({
    required this.id,
    required this.sender,
    required this.content,
    required this.receiver,
    required this.chat,
    required this.createdAt,
    required this.updatedAt,
    required this.readBy,
    required this.v,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        id: json["_id"] ?? "",
        sender: Sender.fromJson(json["sender"]),
        content: json["content"] ?? "",
        receiver: json["receiver"] ?? "",
        chat: Chat.fromJson(json["chat"]),
        createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
        readBy: List<dynamic>.from(json["readBy"] ?? []),
        v: json["__v"] ?? 0,
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "readBy": List<dynamic>.from(readBy.map((x) => x)),
        "__v": v,
      };
}

class Chat {
  final String id;
  final String chatName;
  final bool isGroupChat;
  final List<Sender> users;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String? latestMessage; // Nullable field

  Chat({
    required this.id,
    required this.chatName,
    required this.isGroupChat,
    required this.users,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    this.latestMessage, // Make it nullable
  });

  factory Chat.fromJson(Map<String, dynamic> json) => Chat(
        id: json["_id"] ?? "",
        chatName: json["chatName"] ?? "",
        isGroupChat: json["isGroupChat"] ?? false,
        users: List<Sender>.from(json["users"]?.map((x) => Sender.fromJson(x)) ?? []),
        createdAt: DateTime.parse(json["createdAt"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(json["updatedAt"] ?? DateTime.now().toIso8601String()),
        v: json["__v"] ?? 0,
        latestMessage: json["latestMessage"] as String?, // Handle null
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "latestMessage": latestMessage, // Ensure it's a String or null
      };
}

class Sender {
  final String id;
  final String name;
  final String rollno;
  final String dp;
  final String department;
  final bool certified;
  final String fcmtoken;

  Sender({
    required this.id,
    required this.name,
    required this.rollno,
    required this.dp,
    required this.department,
    required this.certified,
    required this.fcmtoken,
  });

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"] ?? "",
        name: json["name"] ?? "",
        rollno: json["rollno"]?.toString() ?? "",
        dp: json["dp"] ?? "",
        department: json["department"] ?? "",
        certified: json["certified"] ?? false,
        fcmtoken: json["fcmtoken"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "rollno": rollno,
        "dp": dp,
        "department": department,
        "certified": certified,
        "fcmtoken": fcmtoken,
      };
}
