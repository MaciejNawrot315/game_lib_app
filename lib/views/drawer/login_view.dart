import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/drawer_cubit.dart';
import 'package:get/get.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () =>
                context.read<DrawerCubit>().changeState(DrawerInitial()),
          ),
        ),
        const SizedBox(
          height: 150,
        ),
        SizedBox(
            width: 240,
            child: TextFormField(
              decoration: InputDecoration(
                  icon: const Icon(Icons.person),
                  contentPadding:
                      const EdgeInsets.only(bottom: 13.0, left: 8.0),
                  hintText: "email".tr,
                  hintStyle: const TextStyle(color: Colors.grey),
                  constraints: const BoxConstraints(maxHeight: 42),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple))),
            )),
        SizedBox(height: 25),
        SizedBox(
            width: 240,
            child: TextFormField(
              decoration: InputDecoration(
                  icon: const Icon(Icons.key),
                  contentPadding:
                      const EdgeInsets.only(bottom: 13.0, left: 8.0),
                  hintText: "pass".tr,
                  hintStyle: const TextStyle(color: Colors.grey),
                  constraints: const BoxConstraints(maxHeight: 42),
                  border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple))),
            )),
        SizedBox(
            width: 240,
            child: Align(
                alignment: Alignment.bottomRight,
                child: TextButton(
                  child: Text("sign_in".tr),
                  onPressed: () {},
                )))
      ],
    );
  }
}
