import 'dart:convert';

List<GetChats> getChatsFromJson(String str) => List<GetChats>.from(json.decode(str).map((x) => GetChats.fromJson(x)));

String getChatsToJson(List<GetChats> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetChats {
    final String id;
    final String chatName;
    final bool isGroupChat;
    final List<Sender> users;
    final DateTime createdAt;
    final DateTime updatedAt;
    //final LatestMessage latestMessage;

    GetChats({
        required this.id,
        required this.chatName,
        required this.isGroupChat,
        required this.users,
        required this.createdAt,
        required this.updatedAt,
        //required this.latestMessage,
    });

     factory GetChats.fromJson(Map<String, dynamic> json) {
        // Check if "latestMessage" is null in the JSON data and provide a default value if it is.
        

        return GetChats(
            id: json["_id"],
            chatName: json["chatName"],
            isGroupChat: json["isGroupChat"],
            users: List<Sender>.from(json["users"].map((x) => Sender.fromJson(x))),
            createdAt: DateTime.parse(json["createdAt"]),
            updatedAt: DateTime.parse(json["updatedAt"]),
            //latestMessage: LatestMessage.fromJson(latestMessageJson),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "chatName": chatName,
        "isGroupChat": isGroupChat,
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        //"latestMessage": latestMessage.toJson() ,
    };
}

class LatestMessage {
    final String id;
    final Sender sender;
    final String content;
    final String receiver;
    final String chat;

    LatestMessage({
        required this.id,
        required this.sender,
        required this.content,
        required this.receiver,
        required this.chat,
    });

    factory LatestMessage.fromJson(Map<String, dynamic> json) => LatestMessage(
        id: json["_id"],
        sender: Sender.fromJson(json["sender"]),
        content: json["content"],
        receiver: json["receiver"],
        chat: json["chat"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "sender": sender.toJson(),
        "content": content,
        "receiver": receiver,
        "chat": chat,
    };
}

class Sender {
    final String id;
    final String name;
    final String rollno;
    final String dp;
    final String fcmtoken;
    final bool certified;
    final String department;
    Sender({
        required this.id,
        required this.name,
        required this.rollno,
        required this.dp,
        required this.fcmtoken,
        required this.certified,
        required this.department
    });

    factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["_id"],
        name: json["name"],
        rollno: json["rollno"],
        dp: json["dp"],
        fcmtoken:json['fcmtoken'],
        certified: json['certified'],
        department: json['department']
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "rollno": rollno,
        "dp": dp,
        'fcmtoken':fcmtoken,
        'certified':certified,
        'department':department
    };
}
