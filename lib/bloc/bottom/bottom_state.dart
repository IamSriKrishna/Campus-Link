class BottomState {
  final int index;
  BottomState({this.index = 0});

  BottomState copyWith({int? index}) {
    return BottomState(index: index ?? this.index);
  }
}
