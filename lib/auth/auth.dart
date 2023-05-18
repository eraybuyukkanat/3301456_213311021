import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:social_media_app_demo/cache/shared_manager.dart';

class Auth {
  final FirebaseAuth? _auth = FirebaseAuth.instance;
  SharedManager sharedManager = SharedManager();

  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    final user = await _auth!
        .createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final user = await _auth!
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut(String email) async {
    final user = await _auth!.signOut();
  }
}
