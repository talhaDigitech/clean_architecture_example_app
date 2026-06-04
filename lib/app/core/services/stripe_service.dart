// import 'dart:io';

// import 'package:dio/dio.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:naikify_mobile_app/src/components/state_loader.dart';
// import 'package:naikify_mobile_app/src/core/utils/app_logger.dart';
// import 'package:naikify_mobile_app/src/core/utils/app_overlays.dart';
// import 'package:naikify_mobile_app/src/modules/authentication/presentation/authentication_barrel.dart';

// class StripeService {
//   StripeService._();

//   static final StripeService intance = StripeService._();

//   // Payment indent
//   Future<String?> _createPaymentIntent(int amount, String currency) async {
//     try {
//       // Check if STRIPE_SECRET_KEY is loaded
//       final stripeSecret = dotenv.env['STRIPE_SECRET_KEY'];
//       if (stripeSecret == null || stripeSecret.isEmpty) {
//         appPrint(
//           "ERROR: STRIPE_SECRET_KEY is not loaded. Please check your .env file",
//         );
//         throw Exception("STRIPE_SECRET_KEY environment variable is not set");
//       }

//       final Dio dio = Dio();
//       Map<String, dynamic> data = {
//         "amount": calculateAmount(amount),
//         "currency": currency,
//       };

//       var response = await dio.post(
//         "https://api.stripe.com/v1/payment_intents",
//         data: data,
//         options: Options(
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization": "Bearer $stripeSecret",
//             'Content-Type': 'application/x-www-form-urlencoded',
//           },
//         ),
//       );
//       if (response.data != null) {
//         appLog("create PaymentIntent response:${response.data}");
//         return response.data["client_secret"];
//         // return "";
//       }
//       return null;
//     } catch (e) {
//       appPrint("create payment intent methode failed: $e");
//       rethrow;
//     }
//   }

//   // Make Payment Methode
//   Future<void> makePayment({
//     int? amount,
//     Function? onSuccess,
//     BuildContext? context,
//   }) async {
//     try {
//       String? paymentIntentClientSecret = await _createPaymentIntent(
//         amount ?? 10,
//         "usd",
//       );
//       if (paymentIntentClientSecret == null) return;

//       if (!context!.mounted) return;
//       LoadingOverlay.hide();
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: paymentIntentClientSecret,
//           merchantDisplayName: "talha dynamic",
//         ),
//       );
//       if (!context.mounted) return;
//       LoadingOverlay.show(context);
//       await _processPayment(onSuccess);
//     } on SocketException catch (e) {
//       if (context!.mounted) return;
//       AppOverlays.showErrorDialog(
//         context,
//         title: "Connection Error",
//         message:
//             "No internet connection. Please check your network and try again.",
//       );
//       appPrint("make payment method failed: $e");
//     } on StripeException catch (e) {
//       if (context!.mounted) return;
//       if (e.error.code == FailureCode.Canceled) {
//         appPrint("Payment canceled by user");
//         return;
//       }
//       AppOverlays.showErrorDialog(
//         context,
//         title: "Payment Error",
//         message:
//             e.error.localizedMessage ??
//             "An unexpected error occurred during payment.",
//       );
//       appPrint("Stripe payment error: ${e.error.localizedMessage}");
//     } catch (e) {
//       if (context!.mounted) return;
//       AppOverlays.showErrorDialog(
//         context,
//         title: "Payment Failed",
//         message: "Something went wrong. Please check your card and try again.",
//       );
//       appPrint("make payment method failed: $e");
//     } finally {
//       LoadingOverlay.hide();
//     }
//   }

//   // Process payment
//   Future<void> _processPayment(Function? onSuccess) async {
//     try {
//       await Stripe.instance.presentPaymentSheet();
//       appPrint("_____________[PAY SUCCESS]________________");
//       onSuccess?.call();
//     } catch (e) {
//       appPrint("processPayment method failed $e");
//       rethrow;
//     } finally {
//       LoadingOverlay.hide();
//     }
//   }

//   // for USD : example if 100 cents $1.00 , so to make proper amount we do this
//   String calculateAmount(int amount) {
//     final calculatedAmount = amount * 100;
//     return calculatedAmount.toString();
//   }
// }
