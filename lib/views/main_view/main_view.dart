import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/auth/auth_bloc.dart';
import 'package:game_lib_app/blocs_and_cubits/signin/signin_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/signup/signup_cubit.dart';
import 'package:game_lib_app/blocs_and_cubits/user_cubit.dart';
import 'package:game_lib_app/repositories/fb_auth_repository.dart';
import 'package:game_lib_app/views/library/all_library_page.dart';
import 'package:game_lib_app/views/main_view/my_destination.dart';
import 'package:game_lib_app/views/drawer/my_drawer.dart';
import 'package:game_lib_app/views/results_grid/results_grid.dart';
import 'package:game_lib_app/views/search_page/search_page.dart';

import 'package:get/get.dart';

class MainView extends StatefulWidget {
  static const String mainViewRoute = '/mainViewRoute';
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  List<LibraryAll> libraryTabChildren = [
    UserListNames.favGames,
    UserListNames.playedGames,
    UserListNames.wishlistGames
  ].map((e) => LibraryAll(listName: e)).toList();
  late List<MyDestination> destinations = [
    MyDestination(
      body: const ResultsGrid(),
      icon: const Icon(Icons.home),
      label: 'home',
    ),
    MyDestination(
      body: const SearchPage(),
      icon: const Icon(Icons.search),
      label: "search",
    ),
    MyDestination(
        body: Center(
          child: TabBarView(
            children: libraryTabChildren,
          ),
        ),
        label: "library",
        icon: const Icon(Icons.library_books))
  ];
  void _onDestinationSelected(int index) {
    if (mounted) {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  void initState() {
    context
        .read<UserCubit>()
        .getUser(fb_auth.FirebaseAuth.instance.currentUser?.uid);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TabBar tabBar = TabBar(
      indicatorColor: Theme.of(context).primaryColor,
      tabs: [
        Tab(text: 'fav'.tr),
        Tab(text: 'played'.tr),
        Tab(text: 'wishlist'.tr),
      ],
    );
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        return DefaultTabController(
            length: libraryTabChildren.length,
            child: Scaffold(
              appBar: AppBar(
                title: Text(context.watch<UserCubit>().state.name),
                leading: Builder(builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: IconButton(
                      icon: const Icon(Icons.settings),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                    ),
                  );
                }),

                //preffered size is here so that I can change the color of the tabBar
                bottom: (_selectedIndex == 2 &&
                        state.authStatus == AuthStatus.authenticated)
                    ? PreferredSize(
                        preferredSize: tabBar.preferredSize,
                        child: ColoredBox(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          child: tabBar,
                        ),
                      )
                    : null,
              ),
              drawer: MultiBlocProvider(
                providers: [
                  BlocProvider(
                    create: (context) => SignupCubit(
                      authRepository: context.read<AuthRepository>(),
                    ),
                  ),
                  BlocProvider(
                    create: (context) => SigninCubit(
                      authRepository: context.read<AuthRepository>(),
                    ),
                  ),
                ],
                child: const MyDrawer(),
              ),
              body: getDestinationBody(context, _selectedIndex),
              bottomNavigationBar: BottomNavigationBar(
                items: destinations
                    .map((e) => BottomNavigationBarItem(
                        icon: e.icon, label: e.label.tr))
                    .toList(),
                currentIndex: _selectedIndex,
                onTap: _onDestinationSelected,
              ),
            ));
      },
    );
  }

  Widget getDestinationBody(BuildContext context, int index) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (_selectedIndex == 2 &&
            state.authStatus != AuthStatus.authenticated) {
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 48),
            child: Text('please_login'.tr,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white)),
          );
        }
        return destinations[index].body;
      },
    );
  }
}
