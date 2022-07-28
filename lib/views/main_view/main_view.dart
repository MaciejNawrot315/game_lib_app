import 'package:flutter/material.dart';
import 'package:game_lib_app/views/library/all_library_page.dart';
import 'package:game_lib_app/views/main_view/my_destination.dart';
import 'package:game_lib_app/views/results_grid/results_grid.dart';
import 'package:game_lib_app/views/search_page/search_page.dart';

import 'package:get/get.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  bool _switchValue = false;
  List<MyDestination> destinations = [
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
            children: [LibraryAll(id: 0), LibraryAll(id: 1), LibraryAll(id: 2)],
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

  NavigationRailDestination _getRailDestination(
      int index, double passedPadding) {
    return NavigationRailDestination(
        icon: destinations.elementAt(index).icon,
        label: Text(destinations.elementAt(index).label),
        padding: EdgeInsets.symmetric(vertical: passedPadding));
  }

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
    bool smallScreen = MediaQuery.of(context).size.width <= 640;
    double paddingBetweenNavigationRail =
        (MediaQuery.of(context).size.height / 6) - 40;
    TabBar tabBar = TabBar(
      indicatorColor: Theme.of(context).primaryColor,
      tabs: [
        Tab(text: 'fav'.tr),
        Tab(text: 'played'.tr),
        Tab(text: 'wishlist'.tr),
      ],
    );
    return smallScreen
        ? DefaultTabController(
            length: 3,
            child: Scaffold(
                appBar: AppBar(
                  actions: [
                    Builder(builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: IconButton(
                          icon: const Icon(Icons.settings),
                          onPressed: () => Scaffold.of(context).openEndDrawer(),
                        ),
                      );
                    }),
                  ],
                  //preffered size is here so that I can change the color of the tabBar
                  bottom: (_selectedIndex == 2)
                      ? PreferredSize(
                          preferredSize: tabBar.preferredSize,
                          child: ColoredBox(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            child: tabBar,
                          ),
                        )
                      : null,
                ),
                endDrawer: Drawer(
                  child: ListView(
                    children: [
                      Text("settings".tr),
                      Row(
                        children: [
                          const Text("EN"),
                          Switch(
                              value: _switchValue, onChanged: changeLanguage),
                          const Text("PL")
                        ],
                      ),
                    ],
                  ),
                ),
                body: destinations.elementAt(_selectedIndex).body,
                bottomNavigationBar: BottomNavigationBar(
                  items: destinations
                      .map((e) => BottomNavigationBarItem(
                          icon: e.icon, label: e.label.tr))
                      .toList(),
                  currentIndex: _selectedIndex,
                  onTap: _onDestinationSelected,
                )),
          )
        : Scaffold(
            body: Row(
            children: [
              NavigationRail(
                destinations: <NavigationRailDestination>[
                  _getRailDestination(0, paddingBetweenNavigationRail),
                  _getRailDestination(1, paddingBetweenNavigationRail),
                  _getRailDestination(2, paddingBetweenNavigationRail)
                ],
                selectedIndex: _selectedIndex,
                onDestinationSelected: _onDestinationSelected,
                groupAlignment: 0,
              ),
              Expanded(child: destinations.elementAt(_selectedIndex).body)
            ],
          ));
  }
}
