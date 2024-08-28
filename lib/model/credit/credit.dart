class Credit {
  final int credit;
  Credit({this.credit = 0});

  factory Credit.fronJson(Map<String, dynamic> json) {
    return Credit(credit: json["credit"]);
  }

  Map<String, dynamic> toJson() {
    return {"credit": credit};
  }
}
