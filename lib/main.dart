import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/cubit/fav_games_cubit.dart';
import 'package:game_lib_app/cubit/played_games_cubit.dart';
import 'package:game_lib_app/cubit/wishlist_games_cubit.dart';
import 'package:game_lib_app/locale_string.dart';
import 'package:game_lib_app/main_view/main_view.dart';
import 'package:game_lib_app/services/network_service.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Game Library',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.purple,
        primaryColor: Colors.purple[600],
      ),
      locale: const Locale('en', 'US'),
      translations: LocaleString(),
      home: MultiBlocProvider(
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
        child: const MainView(),
      ),
    );
  }
}

NetworkService networkService = NetworkService();
