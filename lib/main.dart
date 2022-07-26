import 'package:flutter/material.dart';
import 'package:game_lib_app/main/my_destination.dart';
import 'package:game_lib_app/results_grid/results_grid.dart';
import 'package:game_lib_app/search_page/search_page.dart';
import 'package:game_lib_app/services/network_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Game Library',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.purple,
      ),
      home: const MainView(),
    );
  }
}

NetworkService networkService = NetworkService();

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
      label: "Home",
    ),
    MyDestination(
      body: const SearchPage(),
      icon: const Icon(Icons.search),
      label: "Search",
    ),
    MyDestination(
        body: Center(
          child: Container(color: Colors.red),
        ),
        label: "Library",
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
    return smallScreen
        ? Scaffold(
            appBar: AppBar(actions: [
              Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                  child: IconButton(
                    icon: const Icon(Icons.settings),
                    onPressed: () => Scaffold.of(context).openEndDrawer(),
                  ),
                );
              }),
            ]),
            endDrawer: Drawer(
              child: ListView(
                children: [
                  const Text("Settings"),
                  Row(
                    children: [
                      const Text("EN"),
                      Switch(value: _switchValue, onChanged: changeLanguage),
                      const Text("PL")
                    ],
                  ),
                ],
              ),
            ),
            body: destinations.elementAt(_selectedIndex).body,
            bottomNavigationBar: BottomNavigationBar(
              items: destinations
                  .map((e) =>
                      BottomNavigationBarItem(icon: e.icon, label: e.label))
                  .toList(),
              currentIndex: _selectedIndex,
              onTap: _onDestinationSelected,
            ))
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
