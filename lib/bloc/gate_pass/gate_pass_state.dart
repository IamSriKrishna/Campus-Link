class GatePassState {
  final String username;
  final String department;
  final String year;
  final String reason;
  final String from;
  final String to;

  GatePassState({
    this.username = "",
    this.department = "",
    this.year = "",
    this.reason = "",
    this.from = "",
    this.to = "",
  
  }) ;

  GatePassState copyWith({
    String? username,
    String? department,
    String? year,
    String? reason,
    String? from,
    String? to,
  }) {
    return GatePassState(
      username: username ?? this.username,
      department: department ?? this.department,
      year: year ?? this.year,
      reason: reason ?? this.reason,
      from: from ?? this.from,
      to: to ?? this.to
    );
  }

}
