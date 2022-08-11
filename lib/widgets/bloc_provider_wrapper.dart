import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';
import 'package:game_lib_app/repositories/fb_auth_repository.dart';
import 'package:game_lib_app/repositories/firestore_repository.dart';

class BlocProviderWrapper extends StatelessWidget {
  final Widget? child;
  const BlocProviderWrapper({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(
            authRepository: context.read<AuthRepository>(),
          ),
        ),
        BlocProvider<UserCubit>(
          create: (context) => UserCubit(
            firestoreRepository: FirestoreRepository(
                firebaseFirestore: FirebaseFirestore.instance),
          ),
        ),
        BlocProvider<DrawerCubit>(
          create: (context) => DrawerCubit(),
        ),
      ],
      child: child ?? const SizedBox(),
    );
  }
}
