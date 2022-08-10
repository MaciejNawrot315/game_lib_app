import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';
import 'package:game_lib_app/main.dart';
import 'package:game_lib_app/models/user.dart';
import 'package:game_lib_app/repositories/firestore_repository.dart';
import 'package:game_lib_app/widgets/my_snack_bar.dart';
import 'package:get/get.dart';

class MainDrawerView extends StatefulWidget {
  const MainDrawerView({Key? key}) : super(key: key);

  @override
  State<MainDrawerView> createState() => _MainDrawerViewState();
}

class _MainDrawerViewState extends State<MainDrawerView> {
  bool _switchValue = Get.locale == const Locale('pl', 'PL');
  void changeLanguage(bool value) {
    if (Get.locale == const Locale('pl', 'PL')) {
      Get.updateLocale(const Locale('en', 'US'));
    } else {
      Get.updateLocale(const Locale('pl', 'PL'));
    }
    if (mounted) {
      setState(() {
        _switchValue = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        final AuthState stateAuth = context.watch<AuthBloc>().state;
        final User stateUser = context.watch<UserCubit>().state;
        String name = stateUser.name;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: ListView(
            physics: const NeverScrollableScrollPhysics(),
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                    onPressed: Navigator.of(context).pop),
              ),
              Text('${"settings".tr}${name == '' ? '' : ',  Hi $name!!'}'),
              Row(
                children: [
                  const Text("EN"),
                  Switch(
                    value: _switchValue,
                    onChanged: changeLanguage,
                  ),
                  const Text("PL")
                ],
              ),
              stateAuth.authStatus == AuthStatus.authenticated
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton.icon(
                            style: const ButtonStyle(
                              alignment: Alignment.topLeft,
                            ),
                            onPressed: () {
                              context
                                  .read<AuthBloc>()
                                  .add(SignoutRequestedEvent());
                              context.read<UserCubit>().setToInitial();
                            },
                            icon: const Icon(Icons.login),
                            label: Text("log_out".tr)),
                        TextButton.icon(
                            style: const ButtonStyle(
                              alignment: Alignment.topLeft,
                            ),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: ((context) => AlertDialog(
                                      title: Text('delete_account'.tr),
                                      content: Text(
                                          'do_you_really_want_to_delete'.tr),
                                      actions: [
                                        TextButton(
                                          child: const Text(
                                            'OK',
                                            style: TextStyle(color: Colors.red),
                                          ),
                                          onPressed: () {
                                            context
                                                .read<FirestoreRepository>()
                                                .deleteCurrentUserDatabase();
                                            context
                                                .read<AuthBloc>()
                                                .add(DeletionRequestedEvent());
                                            context
                                                .read<UserCubit>()
                                                .setToInitial();
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              MySnackBar(
                                                  text: "account_deleted".tr),
                                            );
                                          },
                                        ),
                                        TextButton(
                                          child: Text('cancel'.tr),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    )),
                              );
                            },
                            icon: const Icon(Icons.close_rounded),
                            label: Text("delete_account".tr)),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          TextButton.icon(
                              style: const ButtonStyle(
                                alignment: Alignment.topLeft,
                              ),
                              onPressed: () => context
                                  .read<DrawerCubit>()
                                  .changeToLoginState(),
                              icon: const Icon(Icons.login),
                              label: Text("sign_in".tr)),
                          TextButton.icon(
                              style: const ButtonStyle(
                                alignment: Alignment.topLeft,
                              ),
                              onPressed: () => context
                                  .read<DrawerCubit>()
                                  .changeToRegisterState(),
                              icon: const Icon(
                                Icons.app_registration_rounded,
                              ),
                              label: Text("sign_up".tr)),
                        ])
            ],
          ),
        );
      },
    );
  }
}
