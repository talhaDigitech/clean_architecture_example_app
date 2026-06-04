// mixin Bufferss on ChangeNotifier{}
// here we use on because changeNotifier is already mixin
import 'package:clean_architecture_example_app/app/core/utils/app_logger.dart';
import 'package:clean_architecture_example_app/app/core/utils/app_snack_bar.dart';
import 'package:flutter/material.dart';


mixin Buffers on ChangeNotifier {
  List<String> buffers = [];

  void addLoader(String id) {
    buffers.add(id);
    debugPrint('Buffer added: $id');
    notifyListeners();
  }

  void removeLoader(String id) {
    buffers.remove(id);
    debugPrint('Buffer remove: $id');
    notifyListeners();
  }

  bool hasLoader(String id) {
    return buffers.contains(id);
  }

  @protected
  Future<void> executeAPI({
    bool isAuth = false,
    bool onUnAuthPrompt = false,
    bool showPrompt = true,
    bool showDialogPrompt = false,
    required String apiEndPoint,
    required Future<void> Function() onExecute,
    Future<void> Function(Object)? onError,
    Function()? onFinally,
  }) async {
    if (hasLoader(apiEndPoint)) return;
    try {
      addLoader(apiEndPoint);
      await onExecute();
    } catch (e, stackTrace) {
      appPrint('[Error]: ${e.runtimeType}\n');
      appPrint('[Error-StackTrace]: $stackTrace');
      if (showPrompt) {
        // if (showDialogPrompt) {
        Prompt.showErrorDialog(e.toString());
        // } else {
        //   Prompt.showError(e.toString());
        // }
      }
      await onError?.call(e);
    } finally {
      removeLoader(apiEndPoint);
      await onFinally?.call();
    }
  }
}
