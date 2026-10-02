import 'package:clean_architecture_example_app/app/modules/recharge/domain/entities/recharge_history_entity.dart';

class RechargeHistoryDto {
  final String transactionId;
  final String date;
  final double amount;
  final String method;
  final String status;
  final String meterId;

  RechargeHistoryDto({
    required this.transactionId,
    required this.date,
    required this.amount,
    required this.method,
    required this.status,
    required this.meterId,
  });

  factory RechargeHistoryDto.fromJson(Map<String, dynamic> json) =>
      RechargeHistoryDto(
        transactionId: json["transactionId"] ?? "",
        date: json["date"] ?? "",
        amount: (json["amount"] as num?)?.toDouble() ?? 0.0,
        method: json["method"] ?? "card",
        status: json["status"] ?? "success",
        meterId: json["meterId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "transactionId": transactionId,
        "date": date,
        "amount": amount,
        "method": method,
        "status": status,
        "meterId": meterId,
      };

  RechargeHistoryEntity toEntity() {
    PaymentMethodType payMethod;
    switch (method.toLowerCase()) {
      case 'jazzcash':
        payMethod = PaymentMethodType.jazzCash;
        break;
      case 'easypaisa':
        payMethod = PaymentMethodType.easypaisa;
        break;
      case 'card':
        payMethod = PaymentMethodType.card;
        break;
      case 'banktransfer':
        payMethod = PaymentMethodType.bankTransfer;
        break;
      default:
        payMethod = PaymentMethodType.card;
    }

    RechargeStatus rechargeStatus;
    switch (status.toLowerCase()) {
      case 'success':
        rechargeStatus = RechargeStatus.success;
        break;
      case 'pending':
        rechargeStatus = RechargeStatus.pending;
        break;
      case 'failed':
        rechargeStatus = RechargeStatus.failed;
        break;
      default:
        rechargeStatus = RechargeStatus.success;
    }

    return RechargeHistoryEntity(
      transactionId: transactionId,
      date: DateTime.tryParse(date) ?? DateTime.now(),
      amount: amount,
      method: payMethod,
      status: rechargeStatus,
      meterId: meterId,
    );
  }
}
