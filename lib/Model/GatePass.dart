
import 'package:uuid/uuid.dart';

const Uuid uuid = Uuid();
class GatePass{
  final String id;
  final String date;
  final String from;
  final String to;
  final String reason;

  GatePass({
    required this.date,
    required this.from,
    required this.to,
    required this.reason
  }):id= uuid.v4();

  factory GatePass.fromJson(Map<String,dynamic> map){
    return GatePass(
      date: map['date'], 
      from: map['from'], 
      to: map['to'], 
      reason: map['reason']
    );
  }
}