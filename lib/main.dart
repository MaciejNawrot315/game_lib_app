import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:game_lib_app/locale_string.dart';
import 'package:game_lib_app/repositories/fb_auth_repository.dart';
import 'package:game_lib_app/repositories/firestore_repository.dart';
import 'package:game_lib_app/services/network_service.dart';
import 'package:game_lib_app/views/main_view/main_view.dart';
import 'package:game_lib_app/views/main_view/splash_screen.dart';
import 'package:game_lib_app/widgets/bloc_provider_wrapper.dart';
import 'package:game_lib_app/widgets/injector.dart';
import 'package:game_lib_app/widgets/repository_provider_wrapper.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await injectorSetup();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RepositoryProviderWrapper(
      child: BlocProviderWrapper(
        child: GetMaterialApp(
          title: 'Game Library',
          theme: ThemeData(
            scaffoldBackgroundColor: const Color(0xFF212121),
            primarySwatch: Colors.purple,
            primaryColor: Colors.purple[600],
          ),
          locale: const Locale('en', 'US'),
          translations: LocaleString(),
          initialRoute: SplashScreen.splashScreenRoute,
          routes: {
            MainView.mainViewRoute: (context) => const MainView(),
            SplashScreen.splashScreenRoute: (context) => SplashScreen(),
          },
        ),
      ),
    );
  }
}

NetworkService networkService = NetworkService();
