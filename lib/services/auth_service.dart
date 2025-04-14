// lib/services/auth_service.dart

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Google Sign-In
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
    }
  }

  //WhatsApp Number text message:
//  static Future<void> openWhatsApp(String phoneNumber, {String message = ""}) async {
//   final Uri whatsappUrl = Uri.parse("https://wa.me/$phoneNumber?text=${Uri.encodeFull(message)}");

//   if (await canLaunchUrl(whatsappUrl)) {
//     await launchUrl(whatsappUrl, mode: LaunchMode.externalApplication);
//   } else {
//     print('Could not launch WhatsApp');
//   }
// }


  // Facebook Sign-In
  Future<UserCredential?> signInWithFacebook() async {
    try {
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
            FacebookAuthProvider.credential(result.accessToken!.tokenString);
        return await _auth.signInWithCredential(facebookAuthCredential);
      } else {
        print("Facebook login failed: ${result.status}");
        return null;
      }
    } catch (e) {
      print("Facebook Sign-In Error: $e");
      return null;
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  // Get Current User
  User? get currentUser => _auth.currentUser;
}
