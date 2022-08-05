import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:game_lib_app/constants.dart';
import 'package:game_lib_app/models/custom_error.dart';
import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/models/user.dart';

class FirestoreRepository {
  final FirebaseFirestore firebaseFirestore;
  FirestoreRepository({
    required this.firebaseFirestore,
  });

  Future<User> getProfile({required String uid}) async {
    try {
      final DocumentSnapshot userDoc = await usersRef.doc(uid).get();

      if (userDoc.exists) {
        final currentUser = User.fromDoc(userDoc);
        return currentUser;
      }

      throw 'User not found';
    } on FirebaseException catch (e) {
      throw CustomError(
        code: e.code,
        message: e.message!,
        plugin: e.plugin,
      );
    } catch (e) {
      throw CustomError(
        code: 'Exception',
        message: e.toString(),
        plugin: 'flutter_error/server_error',
      );
    }
  }

  void addGameToFs(Game game, String listName) {
    usersRef.doc(fb_auth.FirebaseAuth.instance.currentUser?.uid).update({
      listName: FieldValue.arrayUnion([game.toJson()])
    });
  }

  void removeGameFromFs(Game game, String listName) {
    usersRef.doc(fb_auth.FirebaseAuth.instance.currentUser?.uid).update({
      listName: FieldValue.arrayRemove([game.toJson()])
    });
  }
}
