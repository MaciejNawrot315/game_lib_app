import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  static void createUser(String email, String pass) {
    print(FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: pass));
  }
}
