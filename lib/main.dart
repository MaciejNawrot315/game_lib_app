import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';

import 'package:game_lib_app/locale_string.dart';
import 'package:game_lib_app/repositories/fb_auth_repository.dart';
import 'package:game_lib_app/repositories/firestore_repository.dart';
import 'package:game_lib_app/services/network_service.dart';
import 'package:game_lib_app/views/main_view/main_view.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
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
      child: MultiBlocProvider(
        providers: [
          BlocProvider<DrawerCubit>(
            create: (context) => DrawerCubit(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<AuthBloc>(
            create: (context) =>
                AuthBloc(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<UserCubit>(
            create: (context) => UserCubit(
                firestoreRepository: FirestoreRepository(
                    firebaseFirestore: FirebaseFirestore.instance)),
          ),
        ],
        child: GetMaterialApp(
          title: 'Game Library',
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.grey[900],
            primarySwatch: Colors.purple,
            primaryColor: Colors.purple[600],
          ),
          locale: const Locale('en', 'US'),
          translations: LocaleString(),
          home: const MainView(),
        ),
      ),
    );
  }
}

NetworkService networkService = NetworkService();
