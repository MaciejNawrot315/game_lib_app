import 'package:flutter/material.dart';
import 'package:game_lib_app/results_grid/results_grid.dart';
import 'package:game_lib_app/search_page/search_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        scaffoldBackgroundColor: Colors.grey[900],
        primarySwatch: Colors.purple,
      ),
      home: const MainView(),
    );
  }
}

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;
  bool _switchValue = false;
  var destinations = {
    {
      'body': const ResultsGrid(),
      'icon': const Icon(Icons.home),
      'label': "Home",
    },
    {
      'body': const SearchPage(),
      'icon': const Icon(Icons.search),
      'label': "Search",
    },
    {
      'body': Center(
        child: Container(color: Colors.red),
      ),
      'icon': const Icon(Icons.library_books),
      'label': "Library",
    },
  };
  void _onDestinationSelected(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  NavigationRailDestination _getRailDestination(
      int index, double passedPadding) {
    return NavigationRailDestination(
        icon: destinations.elementAt(index)['icon'] as Widget,
        label: Text(destinations.elementAt(index)['label'] as String),
        padding: EdgeInsets.symmetric(vertical: passedPadding));
  }

  void changeLanguage(bool value) {
    setState(() {
      _switchValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool smallScreen = MediaQuery.of(context).size.width <= 640 ? true : false;
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
            body: destinations.elementAt(_selectedIndex)['body'] as Widget,
            bottomNavigationBar: BottomNavigationBar(
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: destinations.elementAt(0)['icon'] as Widget,
                    label: destinations.elementAt(0)['label']
                        as String), //czy warto towrzyć
                BottomNavigationBarItem(
                    icon: destinations.elementAt(1)['icon'] as Widget,
                    label: destinations.elementAt(1)['label'] as String),
                BottomNavigationBarItem(
                    icon: destinations.elementAt(2)['icon'] as Widget,
                    label: destinations.elementAt(2)['label'] as String),
              ],
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
              Expanded(
                  child:
                      destinations.elementAt(_selectedIndex)['body'] as Widget)
            ],
          ));
  }
}
