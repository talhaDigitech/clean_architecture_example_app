// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class AuthService {
//   static final AuthService instance = AuthService._();
//   AuthService._();
//   factory AuthService() => instance;
  

//   Future<User?> signInWithGoogle() async {
//     try {
//       debugPrint("Starting Google Sign-In initialization...");
//       // Initialize GoogleSignIn with your serverClientId for version 7.x
//       await GoogleSignIn.instance.initialize(
       
//         serverClientId:
//             dotenv.env['WEB_CLIENT_ID'],
//       );

//       debugPrint("Triggering Google authenticate flow...");
//       // Trigger the authentication flow
//       final gUser = await GoogleSignIn.instance.authenticate();

//       debugPrint(
//         "Google Sign-In successful. Fetching authentication details for: ${gUser.email}",
//       );
//       // Obtain the auth details from the request
//       final GoogleSignInAuthentication gAuth = gUser.authentication;

//       debugPrint("Fetching authorization for scopes...");
//       // Access tokens are now handled via the authorizationClient in google_sign_in 7.x
//       final authz = await gUser.authorizationClient.authorizationForScopes([
//         'email',
//         'profile',
//       ]);

//       if (authz == null) {
//         debugPrint("Authorization failed: No access token obtained.");
//         return null;
//       }

//       debugPrint("ID Token present: ${gAuth.idToken != null}");
//       // debugPrint("Access Token present: ${authz.accessToken != null}");

//       // Create a new credential
//       final credential = GoogleAuthProvider.credential(
//         accessToken: authz.accessToken,
//         idToken: gAuth.idToken,
//       );

//       debugPrint("Signing into Firebase with Google credential...");
//       // Sign in to Firebase with the Google user credentials
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithCredential(credential);

//       // Extract the user details (name and email)
//       User? user = userCredential.user;
//       if (user != null) {
//         debugPrint("Firebase Sign-In Successful!");
//         debugPrint("User Email: ${user.email}");
//         debugPrint("User Name: ${user.displayName}");
//       } else {
//         debugPrint("Firebase User is null after sign-in.");
//       }

//       return user;
//     } catch (e) {
//       debugPrint("Google sign-in failed with error: $e");
//       rethrow;
//       // return null;
//     }
//   }

//   Future<void> signOut() async {
//     try {
//       // Sign out from Google using the singleton instance
//       await GoogleSignIn.instance.signOut();

//       // Sign out from Firebase
//       await FirebaseAuth.instance.signOut();

//       debugPrint("User signed out from Google and Firebase.");
//     } catch (e) {
//       debugPrint("Sign-out failed: $e");
//     }
//   }
// }
