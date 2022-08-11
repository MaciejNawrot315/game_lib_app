import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:game_lib_app/repositories/fb_auth_repository.dart';
import 'package:game_lib_app/repositories/firestore_repository.dart';

class RepositoryProviderWrapper extends StatelessWidget {
  final Widget? child;
  const RepositoryProviderWrapper({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
              firebaseAuth: FirebaseAuth.instance,
              firebaseFirestore: FirebaseFirestore.instance),
        ),
        RepositoryProvider(
          create: (context) => FirestoreRepository(
              firebaseFirestore: FirebaseFirestore.instance),
        )
      ],
      child: child ?? const SizedBox(),
    );
  }
}
