abstract class GatePassEvent {}

class ReasonEvent extends GatePassEvent {
  final String reason;
  ReasonEvent({
    required this.reason,
  });
}

class FromTimeEvent extends GatePassEvent {
  final String time;
  FromTimeEvent({
    required this.time,
  });
}

class ToTimeEvent extends GatePassEvent {
  final String time;
  ToTimeEvent({
    required this.time,
  });
}

class ClearEvent extends GatePassEvent {}