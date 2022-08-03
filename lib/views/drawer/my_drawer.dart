import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signin/signin_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signup/signup_cubit.dart';
import 'package:game_lib_app/repositories/fb_auth_repository.dart';
import 'package:game_lib_app/views/drawer/login_view.dart';
import 'package:game_lib_app/views/drawer/main_drawer_view.dart';
import 'package:game_lib_app/views/drawer/register_view.dart';
import 'package:get/get.dart';

class MyDrawer extends StatelessWidget {
  MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget content = const SizedBox();
    switch (context.watch<DrawerCubit>().state) {
      case DrawerState.initial:
        {
          content = const MainDrawerView();
        }
        break;
      case DrawerState.login:
        {
          content = BlocProvider(
            create: (context) =>
                SigninCubit(authRepository: context.read<AuthRepository>()),
            child: const LoginView(),
          );
        }
        break;
      case DrawerState.register:
        {
          content = BlocProvider(
            create: (context) =>
                SignupCubit(authRepository: context.read<AuthRepository>()),
            child: const RegisterView(),
          );
        }
        break;
    }
    return Drawer(child: content);
  }
}
