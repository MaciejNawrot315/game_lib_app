import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signin/signin_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signup/signup_cubit.dart';
import 'package:game_lib_app/views/drawer/login_view.dart';
import 'package:game_lib_app/views/drawer/main_drawer_view.dart';
import 'package:game_lib_app/views/drawer/register_view.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

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
          content = const LoginView();
        }
        break;
      case DrawerState.register:
        {
          content = const RegisterView();
        }
        break;
    }
    return GestureDetector(
      onHorizontalDragUpdate: (details) {
        // Note: Sensitivity is integer used when you don't want to mess up vertical drag
        int sensitivity = 8;
        if (details.delta.dx > sensitivity) {
          null;
        } else if (details.delta.dx < -sensitivity) {
          null;
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Drawer(child: content),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  (context.read<SigninCubit>().state.signinStatus ==
                              SigninStatus.submitting ||
                          context.read<SignupCubit>().state.signupStatus ==
                              SignupStatus.submitting)
                      ? null
                      : Navigator.pop(context);
                },
                child: Container(
                  color: Colors.transparent,
                  child: SizedBox(height: MediaQuery.of(context).size.height),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
