import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signin/signin_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';
import 'package:game_lib_app/widgets/error_dialog.dart';
import 'package:get/get.dart';

class RestartView extends StatefulWidget {
  const RestartView({Key? key}) : super(key: key);

  @override
  State<RestartView> createState() => _RestartViewState();
}

class _RestartViewState extends State<RestartView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    form.save();
    context.read<DrawerCubit>().sendResetEmail(email: _email!);
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('pass_reset'.tr),
              content: Text('email_with_restart_link_sent'.tr),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    context.read<DrawerCubit>().changeToLoginState();
                    Navigator.pop(context);
                  },
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded),
            onPressed: () => context.read<DrawerCubit>().changeToLoginState(),
          ),
        ),
        const SizedBox(
          height: 150,
        ),
        SizedBox(
          width: 240,
          child: Form(
            key: _formKey,
            autovalidateMode: _autovalidateMode,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  autocorrect: false,
                  decoration: InputDecoration(
                    icon: const Icon(Icons.email_outlined),
                    contentPadding:
                        const EdgeInsets.only(bottom: 13.0, left: 8.0),
                    hintText: "email".tr,
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.purple),
                    ),
                  ),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'email_required'.tr;
                    }
                    if (!value.trim().isEmail) {
                      return 'enter_valid_email'.tr;
                    }
                    return null;
                  },
                  onSaved: (String? value) {
                    _email = value;
                  },
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: Text("reset".tr),
                    onPressed: () => _submit(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
