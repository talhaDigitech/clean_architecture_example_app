import 'package:clean_architecture_example_app/app/core/utils/buffers.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/data/source/recharge_imple_repo.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/domain/entities/recharge_history_entity.dart';
import 'package:clean_architecture_example_app/app/modules/recharge/domain/usecase/get_recharge_history_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

final rechargeControllerProvider =
    ChangeNotifierProvider<RechargeController>((ref) {
  return RechargeController(
    getRechargeHistoryUseCase: GetRechargeHistoryUseCase(RechargeImpleRepo()),
  );
});

class RechargeController extends ChangeNotifier with Buffers {
  final GetRechargeHistoryUseCase _getRechargeHistoryUseCase;

  RechargeController({
    required GetRechargeHistoryUseCase getRechargeHistoryUseCase,
  }) : _getRechargeHistoryUseCase = getRechargeHistoryUseCase {
    loadHistory();
  }

  double _selectedAmount = 1000.0;
  double get selectedAmount => _selectedAmount;

  final TextEditingController amountController =
      TextEditingController(text: '1000');

  PaymentMethodType _selectedMethod = PaymentMethodType.jazzCash;
  PaymentMethodType get selectedMethod => _selectedMethod;

  bool get isProcessing => hasLoader('processPayment');

  bool _hasPendingSync = false;
  bool get hasPendingSync => _hasPendingSync;

  double _pendingAmount = 0.0;
  double get pendingAmount => _pendingAmount;

  bool get isLoadingHistory => hasLoader('getRechargeHistory');

  List<RechargeHistoryEntity> _history = [];
  List<RechargeHistoryEntity> get history => _history;

  Future<void> loadHistory() async {
    await executeAPI(
      apiEndPoint: 'getRechargeHistory',
      showPrompt: false,
      onExecute: () async {
        _history = await _getRechargeHistoryUseCase();
      },
      onError: (e) async {
        _history = [];
      },
    );
  }

  void selectAmount(double amount) {
    _selectedAmount = amount;
    amountController.text = amount.toInt().toString();
    notifyListeners();
  }

  void onCustomAmountChanged(String val) {
    final parsed = double.tryParse(val);
    if (parsed != null && parsed > 0) {
      _selectedAmount = parsed;
    }
    notifyListeners();
  }

  void selectPaymentMethod(PaymentMethodType method) {
    _selectedMethod = method;
    notifyListeners();
  }

  Future<bool> processPayment({
    required String meterId,
    required VoidCallback onMeterTopUp,
  }) async {
    bool success = false;
    await executeAPI(
      apiEndPoint: 'processPayment',
      showPrompt: false,
      onExecute: () async {
        await Future.delayed(const Duration(milliseconds: 1500));

        final newTxn = RechargeHistoryEntity(
          transactionId:
              'TXN-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
          date: DateTime.now(),
          amount: _selectedAmount,
          method: _selectedMethod,
          status: RechargeStatus.pending,
          meterId: meterId,
        );

        _history.insert(0, newTxn);
        _pendingAmount = _selectedAmount;
        _hasPendingSync = true;
        onMeterTopUp();
        success = true;
      },
    );
    return success;
  }

  void dismissPendingSync() {
    _hasPendingSync = false;
    notifyListeners();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }
}
