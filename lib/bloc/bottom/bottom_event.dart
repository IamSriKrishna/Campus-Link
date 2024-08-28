abstract class BottomEvent {}

class CurrentIndexEvent extends BottomEvent {
  final int index;
  CurrentIndexEvent({required this.index});
}