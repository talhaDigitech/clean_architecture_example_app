enum RechargeStatus { success, pending, failed }

enum PaymentMethodType { jazzCash, easypaisa, card, bankTransfer }

class RechargeHistoryEntity {
  final String transactionId;
  final DateTime date;
  final double amount;
  final PaymentMethodType method;
  final RechargeStatus status;
  final String meterId;

  const RechargeHistoryEntity({
    required this.transactionId,
    required this.date,
    required this.amount,
    required this.method,
    required this.status,
    required this.meterId,
  });

  String get methodName {
    switch (method) {
      case PaymentMethodType.jazzCash:
        return 'JazzCash';
      case PaymentMethodType.easypaisa:
        return 'Easypaisa';
      case PaymentMethodType.card:
        return 'Debit / Credit Card';
      case PaymentMethodType.bankTransfer:
        return '1Link Bank Transfer';
    }
  }

  String get statusLabel {
    switch (status) {
      case RechargeStatus.success:
        return 'Synced';
      case RechargeStatus.pending:
        return 'Pending Meter Sync';
      case RechargeStatus.failed:
        return 'Failed';
    }
  }

  RechargeHistoryEntity copyWith({
    String? transactionId,
    DateTime? date,
    double? amount,
    PaymentMethodType? method,
    RechargeStatus? status,
    String? meterId,
  }) {
    return RechargeHistoryEntity(
      transactionId: transactionId ?? this.transactionId,
      date: date ?? this.date,
      amount: amount ?? this.amount,
      method: method ?? this.method,
      status: status ?? this.status,
      meterId: meterId ?? this.meterId,
    );
  }
}
