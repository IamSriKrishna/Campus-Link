abstract class ChatEvent {}

class GetChatEvent extends ChatEvent {}

class CreateChatEvent extends ChatEvent {
  final String userId;
  CreateChatEvent({required this.userId});
}

class ClearChatEvent extends ChatEvent{}