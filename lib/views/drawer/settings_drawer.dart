import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/drawer_cubit.dart';
import 'package:game_lib_app/views/drawer/login_view.dart';
import 'package:get/get.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({Key? key}) : super(key: key);

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  bool _switchValue = false;
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
    return Drawer(
      child: BlocBuilder<DrawerCubit, DrawerState>(
        builder: (context, state) {
          if (state is DrawerLogin) {
            return LoginView();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Text("settings".tr),
                Row(
                  children: [
                    const Text("EN"),
                    Switch(value: _switchValue, onChanged: changeLanguage),
                    const Text("PL")
                  ],
                ),
                TextButton.icon(
                    style: const ButtonStyle(alignment: Alignment.topLeft),
                    onPressed: () =>
                        context.read<DrawerCubit>().changeState(DrawerLogin()),
                    icon: const Icon(Icons.login),
                    label: Text("sign_in".tr)),
                TextButton.icon(
                    style: const ButtonStyle(alignment: Alignment.topLeft),
                    onPressed: () {},
                    icon: const Icon(Icons.app_registration_rounded),
                    label: Text("sign_up".tr))
              ],
            ),
          );
        },
      ),
    );
  }
}
