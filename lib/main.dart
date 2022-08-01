import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
<<<<<<< HEAD
import 'package:game_lib_app/cubit/games_cubits.dart';

=======
import 'package:game_lib_app/cubit/drawer_cubit.dart';
import 'package:game_lib_app/cubit/fav_games_cubit.dart';
import 'package:game_lib_app/cubit/played_games_cubit.dart';
import 'package:game_lib_app/cubit/wishlist_games_cubit.dart';
>>>>>>> 91116b0c0db01f1e4f9e3a65df5dd09169ec3865
import 'package:game_lib_app/locale_string.dart';
import 'package:game_lib_app/services/network_service.dart';
import 'package:game_lib_app/views/main_view/main_view.dart';
import 'package:get/get.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

//TODO providers on the material app
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<FavGamesCubit>(
          create: (context) => FavGamesCubit(),
        ),
        BlocProvider<PlayedGamesCubit>(
          create: (context) => PlayedGamesCubit(),
        ),
        BlocProvider<WishlistGamesCubit>(
          create: (context) => WishlistGamesCubit(),
        ),
      ],
      child: GetMaterialApp(
        title: 'Game Library',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.grey[900],
          primarySwatch: Colors.purple,
          primaryColor: Colors.purple[600],
        ),
        locale: const Locale('en', 'US'),
        translations: LocaleString(),
<<<<<<< HEAD
        home: const MainView(),
=======
        home: BlocProvider<DrawerCubit>(
          create: (context) => DrawerCubit(),
          child: const MainView(),
        ),
>>>>>>> 91116b0c0db01f1e4f9e3a65df5dd09169ec3865
      ),
    );
  }
}

NetworkService networkService = NetworkService();
