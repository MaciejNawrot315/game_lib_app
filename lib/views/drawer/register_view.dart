import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signup/signup_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';
import 'package:game_lib_app/widgets/error_dialog.dart';
import 'package:get/get.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  final TextEditingController _passwordController = TextEditingController();
  String? _name, _email, _password;
  void _submit() {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    context
        .read<SignupCubit>()
        .signup(
          name: _name!,
          email: _email!,
          password: _password!,
        )
        .then((value) => {
              context
                  .read<UserCubit>()
                  .getUser(FirebaseAuth.instance.currentUser?.uid)
            });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: BlocConsumer<SignupCubit, SignupState>(
        listener: (context, state) {
          if (state.signupStatus == SignupStatus.error) {
            errorDialog(context, state.error);
          }
          if (state.signupStatus == SignupStatus.success) {
            context.read<DrawerCubit>().changeToInitialState();
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () => state.signupStatus !=
                              SignupStatus.submitting
                          ? context.read<DrawerCubit>().changeToInitialState()
                          : null),
                ),
              ),
              const SizedBox(
                height: 110,
              ),
              SizedBox(
                width: 240,
                child: Form(
                  key: _formKey,
                  autovalidateMode: _autovalidateMode,
                  child: Column(
                    children: [
                      TextFormField(
                        autocorrect: false,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          contentPadding:
                              const EdgeInsets.only(bottom: 13.0, left: 8.0),
                          filled: true,
                          hintText: "name".tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        validator: (String? value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'name_required'.tr;
                          }
                          if (value.trim().length < 2) {
                            return 'name_2_char'.tr;
                          }
                          return null;
                        },
                        onSaved: (String? value) {
                          _name = value;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        autocorrect: false,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.email_rounded),
                          filled: true,
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
                      const SizedBox(height: 20),
                      TextFormField(
                        autocorrect: false,
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                            filled: true,
                            icon: const Icon(Icons.key),
                            contentPadding:
                                const EdgeInsets.only(bottom: 13.0, left: 8.0),
                            hintText: "pass".tr,
                            hintStyle: const TextStyle(color: Colors.grey),
                            border: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.purple))),
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
                      const SizedBox(height: 20),
                      TextFormField(
                        autocorrect: false,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.keyboard_arrow_right_rounded),
                          filled: true,
                          contentPadding:
                              const EdgeInsets.only(bottom: 13.0, left: 8.0),
                          hintText: "confirm_pass".tr,
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.purple),
                          ),
                        ),
                        validator: (String? value) {
                          if (_passwordController.text != value) {
                            return 'pass_not_match'.tr;
                          }
                          return null;
                        },
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: TextButton(
                            onPressed: () {
                              state.signupStatus == SignupStatus.submitting
                                  ? null
                                  : _submit();
                            },
                            child: Text(
                              state.signupStatus == SignupStatus.submitting
                                  ? 'loading'.tr
                                  : 'sign_up'.tr,
                            ),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
