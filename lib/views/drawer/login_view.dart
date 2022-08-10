import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signin/signin_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';
import 'package:game_lib_app/widgets/error_dialog.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _email, _password;

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) {
      return;
    }

    form.save();
    await context
        .read<SigninCubit>()
        .signin(email: _email!, password: _password!)
        .then((value) => {
              context
                  .read<UserCubit>()
                  .getUser(FirebaseAuth.instance.currentUser?.uid)
            });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SigninCubit, SigninState>(
      listener: (context, state) {
        if (state.signinStatus == SigninStatus.error) {
          errorDialog(context, state.error);
        }
        if (state.signinStatus == SigninStatus.success) {
          context.read<DrawerCubit>().changeToInitialState();
        }
      },
      builder: (context, state) {
        return Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  onPressed: () => state.signinStatus != SigninStatus.submitting
                      ? context.read<DrawerCubit>().changeToInitialState()
                      : null),
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
                        hintText: "email",
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
                    const SizedBox(height: 25),
                    TextFormField(
                      obscureText: true,
                      autocorrect: false,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.key),
                        contentPadding:
                            const EdgeInsets.only(bottom: 13.0, left: 8.0),
                        hintText: "pass".tr,
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: const OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.purple),
                        ),
                      ),
                      validator: (String? value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'pass_required'.tr;
                        }
                        if (value.trim().length < 6) {
                          return 'pass_6_char'.tr;
                        }
                        return null;
                      },
                      onSaved: (String? value) {
                        _password = value;
                      },
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        child: Text(
                            state.signinStatus == SigninStatus.submitting
                                ? 'loading'.tr
                                : "sign_in".tr),
                        onPressed: () {
                          state.signinStatus == SigninStatus.submitting
                              ? null
                              : _submit();
                        },
                      ),
                    ),
                    TextButton(
                      onPressed: () =>
                          context.read<DrawerCubit>().changeToRestartState(),
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(
                            decoration: TextDecoration.underline),
                      ),
                      child: Text('forgot_pass'.tr),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
