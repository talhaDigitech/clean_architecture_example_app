// import 'dart:async';
// import 'package:connectivity_plus/connectivity_plus.dart';

// class ConnectivityService {
//   final Connectivity _connectivity = Connectivity();
  
//   // Singleton instance
//   static final ConnectivityService _instance = ConnectivityService._internal();
//   factory ConnectivityService() => _instance;
//   ConnectivityService._internal();

//   /// Checks if the device is currently connected to the internet.
//   Future<bool> checkInternetConnection() async {
//     final connectivityResult = await _connectivity.checkConnectivity();
    
//     // connectivity_plus 6.x returns a List<ConnectivityResult>
//     if (connectivityResult.contains(ConnectivityResult.none)) {
//       return false;
//     } else if (connectivityResult.contains(ConnectivityResult.mobile) ||
//         connectivityResult.contains(ConnectivityResult.wifi) ||
//         connectivityResult.contains(ConnectivityResult.ethernet) ||
//         connectivityResult.contains(ConnectivityResult.vpn) ||
//         connectivityResult.contains(ConnectivityResult.bluetooth)) {
//       return true;
//     }
//     return false;
//   }

//   /// Stream of connectivity changes
//   Stream<List<ConnectivityResult>> get onConnectivityChanged =>
//       _connectivity.onConnectivityChanged;
// }

// final connectivityService = ConnectivityService();
