import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  Rxn<User> user = Rxn<User>();

  @override
  void onInit() {
    super.onInit();

    user.bindStream(_auth.authStateChanges());

    ever(user, (User? u) {
      if (u != null) {
        Get.offAllNamed('/mainwrapper');
      } else {
        Get.offAllNamed('/login');
      }
    });
  }


  Future<void> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return; // user canceled

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      await _auth.signInWithCredential(credential);
      Get.snackbar("Success", "Welcome, ${_auth.currentUser?.displayName}");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }
}
