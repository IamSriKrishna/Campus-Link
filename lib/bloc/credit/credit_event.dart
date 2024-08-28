abstract class CreditEvent {}

class UpdateCreditEvent extends CreditEvent {
  final int credit;
  UpdateCreditEvent({required this.credit});
}
