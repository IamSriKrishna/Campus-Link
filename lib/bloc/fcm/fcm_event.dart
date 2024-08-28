abstract class FcmEvent {}

class UpdateFcmTokenEvent extends FcmEvent {
  final String fcmtoken;
  UpdateFcmTokenEvent({required this.fcmtoken});
}

class ReloadFcmTokenEvent extends FcmEvent {}

class SendFcmEvent extends FcmEvent {
  final String title;
  final String body;
  final String token;
  SendFcmEvent({required this.title, required this.body, required this.token});
}
