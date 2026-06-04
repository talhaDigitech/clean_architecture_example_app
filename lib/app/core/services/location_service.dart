// import 'dart:convert';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:http/http.dart' as http;
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:naikify_mobile_app/src/core/utils/app_logger.dart';

// class LocationService {
//   // Private constructor
//   LocationService._();

//   // Singleton instance
//   static final LocationService instance = LocationService._();

//   static final _apiKey = dotenv.env["GOOGLE_API_KEY"];

//   /// Gets the current position of the device.
//   /// Handles permission requests and service availability.
//   Future<Position?> getCurrentLocation() async {
//     try {
//       bool serviceEnabled;
//       LocationPermission permission;

//       // Test if location services are enabled.
//       serviceEnabled = await Geolocator.isLocationServiceEnabled();
//       if (!serviceEnabled) {
//         appPrint('Location services are disabled.');
//         return null;
//       }

//       permission = await Geolocator.checkPermission();
//       if (permission == LocationPermission.denied) {
//         permission = await Geolocator.requestPermission();
//         if (permission == LocationPermission.denied) {
//           appPrint('Location permissions are denied');

//           return null;
//         }
//       }

//       if (permission == LocationPermission.deniedForever) {
//         appPrint(
//           'Location permissions are permanently denied, we cannot request permissions.',
//         );
//         await Geolocator.openAppSettings();
//         return null;
//       }

//       // When we have permission, we can get the current position.
//       return await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.high,
//       );
//     } catch (e) {
//       appPrint("Error getting current location: $e");
//       return null;
//     }
//   }

//   /// Converts coordinates into a human-readable address.
//   Future<String> getAddressFromLatLng(LatLng latLng) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(
//         latLng.latitude,
//         latLng.longitude,
//       );
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         // Build address string, filtering out empty fields
//         List<String> addressParts = [
//           place.street ?? "",
//           place.subLocality ?? "",
//           place.locality ?? "",
//           place.administrativeArea ?? "",
//           place.country ?? "",
//         ]..removeWhere((part) => part.isEmpty);

//         return addressParts.join(", ");
//       }
//     } catch (e) {
//       appPrint("Error getting address from LatLng: $e");
//       return "Address not found";
//     }
//     return "Address not found";
//   }

//   /// Converts an address string into coordinates.
//   Future<LatLng?> getLatLngFromAddress(String address) async {
//     try {
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         return LatLng(locations[0].latitude, locations[0].longitude);
//       }
//     } catch (e) {
//       appPrint("Error getting LatLng from address: $e");
//       return null;
//     }
//     return null;
//   }

//   /// Gets a list of place suggestions based on the input string.
//   Future<List<Map<String, dynamic>>> getPlaceSuggestions(String input) async {
//     if (input.isEmpty) return [];

//     final url = Uri.parse(
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$input&key=$_apiKey',
//     );

//     try {
//       final response = await http.get(url);
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);
//         if (data['status'] == 'OK') {
//           return List<Map<String, dynamic>>.from(data['predictions']);
//         }
//       }
//     } catch (e) {
//       appPrint("Error getting place suggestions: $e");
//     }
//     return [];
//   }
// }
