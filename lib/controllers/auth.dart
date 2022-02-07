import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:zipcursos_app/controllers/student_controller.dart';
import 'package:zipcursos_app/models/student.dart';
import 'package:zipcursos_app/view/home_page.dart';
import 'package:zipcursos_app/view/register_student_page.dart';

class Authentication {
  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();
      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
        // ignore: empty_catches
      } catch (e) {}
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn();

      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);
          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                  content:
                      'The account already exists with a different credential'),
            );
          } else if (e.code == 'invalid-credential') {
            ScaffoldMessenger.of(context).showSnackBar(
              Authentication.customSnackBar(
                  content:
                      'Error occurred while accessing credentials. Try again.'),
            );
          }
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
                content: 'Error occurred using Google Sign In. Try again.'),
          );
        }
      }
    }
    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(content: 'Error signing out. Try again.'),
      );
    }
  }

  static void isUserLogged(context) async {
    User? user = await FirebaseAuth.instance.currentUser;
    if (user != null) {
      if (await StudentController().checkIfUserExist(user)) {
        StudentModel student =
            await StudentController().getStudentAsModel(user.uid);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(student: student)));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RegisterStudentPage(
                    nome: user.displayName,
                    email: user.email,
                    photo: user.photoURL,
                    uid: user.uid)));
      }
    }
  }
}
