// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_stripe/flutter_stripe.dart';
// import '../../modules/points_card/presentation/provider/points_card_provider.dart';
// import '../../modules/sub_category/presentation/screens/order_receipt.dart';

// class StripePayment {
//   Map<String, dynamic>? paymentIntent;

//   Future<void> makePayment(
//     BuildContext context,
//     String price,
//     WidgetRef ref,
//   ) async {
//     try {
//       paymentIntent = await createPaymentIntent(price, 'USD');

//       //STEP 2: Initialize Payment Sheet
//       await Stripe.instance
//           .initPaymentSheet(
//             paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret:
//                   paymentIntent!['client_secret'], //Gotten from payment intent
//               style: ThemeMode.dark,
//               merchantDisplayName: 'Ikay',
//             ),
//           )
//           .then((value) {});

//       //STEP 3: Display Payment sheet
//       // ignore: use_build_context_synchronously
//       displayPaymentSheet(context, ref);
//     } catch (err) {
//       throw Exception(err);
//     }
//   }

//   Future<void> displayPaymentSheet(BuildContext context, WidgetRef ref) async {
//     try {
//       await Stripe.instance
//           .presentPaymentSheet()
//           .then((value) {
//             ref.watch(pointsCardProvider).clearCart();

//             showDialog(
//               // ignore: use_build_context_synchronously
//               context: context,
//               barrierDismissible: false,
//               builder: (BuildContext context) {
//                 // Show the dialog
//                 Future.delayed(const Duration(seconds: 2), () {
//                   Navigator.pushReplacement(
//                     // ignore: use_build_context_synchronously
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const OrderReceipt(
//                         orderId: '1',
//                         customerName: 'Hussnain',
//                         mobileNumber: '+92000-0000000',
//                         orderDate: '12-09-24',
//                         totalAmount: 100,
//                         deliveryAddress: 'Karachi Pakistan',
//                         deliveryInstructions: 'no instructions',
//                         deliveryFee: 20,
//                         taxAmount: 10,
//                         grandTotal: 200,
//                         paymentType: 'cash',
//                       ),
//                     ),
//                   );
//                 });

//                 return const AlertDialog(
//                   content: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Icon(
//                         Icons.check_circle,
//                         color: Colors.green,
//                         size: 100.0,
//                       ),
//                       SizedBox(height: 10.0),
//                       Text("Payment Successful!"),
//                     ],
//                   ),
//                 );
//               },
//             );

//             paymentIntent = null;
//           })
//           .onError((error, stackTrace) {
//             throw Exception(error);
//           });
//     } on StripeException catch (e) {
//       debugPrint('Error is:---> $e');
//       const AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.cancel, color: Colors.red),
//                 Text("Payment Failed"),
//               ],
//             ),
//           ],
//         ),
//       );
//     } catch (e) {
//       debugPrint('$e');
//     }
//   }

//   Future<Map<String, dynamic>> createPaymentIntent(
//     String amount,
//     String currency,
//   ) async {
//     try {
//       // Check if STRIPE_SECRET_KEY is loaded
//       final stripeSecret = dotenv.env['STRIPE_SECRET_KEY'];
//       if (stripeSecret == null || stripeSecret.isEmpty) {
//         debugPrint(
//           "ERROR: STRIPE_SECRET_KEY is not loaded. Please check your .env file",
//         );
//         throw Exception("STRIPE_SECRET_KEY environment variable is not set");
//       }

//       //Request body
//       Map<String, dynamic> body = {
//         'amount': calculateAmount(amount),
//         'currency': currency,
//       };

//       //Make post request to Stripe
//       var response = await http.post(
//         Uri.parse('https://api.stripe.com/v1/payment_intents'),
//         headers: {
//           'Authorization': 'Bearer $stripeSecret',
//           'Content-Type': 'application/x-www-form-urlencoded',
//         },
//         body: body,
//       );

//       return json.decode(response.body);
//     } catch (err) {
//       throw Exception(err.toString());
//     }
//   }

//   String calculateAmount(String amount) {
//     final calculatedAmout = (int.parse(amount)) * 100;
//     return calculatedAmout.toString();
//   }
// }
