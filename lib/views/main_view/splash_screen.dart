import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:game_lib_app/models/game/game.dart';
import 'package:game_lib_app/models/game/game_list_model.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/views/main_view/main_view.dart';
import 'package:game_lib_app/widgets/injector.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends HookWidget {
  static const String splashScreenRoute = '/';
  SplashScreen({Key? key}) : super(key: key);
  bool animationFinished = false;
  bool fetchingFinished = false;
  @override
  Widget build(BuildContext context) {
    final AnimationController animationController = useAnimationController();
    loadGames(context);

    return Lottie.asset(
      'assets/lottie/71262-games-knight-loading-icon.json',
      controller: animationController,
      onLoaded: (composition) {
        animationController.addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              animationController
                ..duration = composition.duration
                ..repeat(reverse: true);

              animationFinished = true;
              if (fetchingFinished) {
                Navigator.pushNamed(context, MainView.mainViewRoute);
              }
            }
          },
        );

        animationController
          ..duration = composition.duration
          ..forward();
      },
    );
  }

  Future<void> loadGames(BuildContext context) async {
    GameListModel gameList = locator.get<GameListModel>();
    gameList.list = await IgdbRepository.fetchGamePosters('', 0);
    print(gameList.list);
    fetchingFinished = true;
    if (animationFinished) {
      Navigator.pushNamed(context, MainView.mainViewRoute);
    }
  }
}



// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:game_lib_app/blocs_and_cubits/drawer_cubit.dart';
// import 'package:game_lib_app/views/main_view/main_view.dart';
// import 'package:lottie/lottie.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: (20)),
//       vsync: this,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Lottie.asset(
//         'assets/lottie/71262-games-knight-loading-icon.json',
//         controller: _controller,
//         height: MediaQuery.of(context).size.height,
//         animate: true,
//         repeat: true,
//         onLoaded: (composition) {
//           _controller
//             ..duration = composition.duration
//             ..forward().whenComplete(
//               () => Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BlocProvider<DrawerCubit>(
//                     create: (context) => DrawerCubit(),
//                     child: const MainView(),
//                   ),
//                 ),
//               ),
//             );
//         },
//       ),
//     );
//   }
// }
