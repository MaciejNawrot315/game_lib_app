import 'package:game_lib_app/models/game/game_list_model.dart';
// ignore: depend_on_referenced_packages
import 'package:get_it/get_it.dart';

final locator = GetIt.instance;
// or second, equal option
// final locator = GetIt.I;

Future<void> injectorSetup() async {
  // registerSingleton creates an Object and always returns the same instance

  // Counter can have some defualt values
  // so we don't have to pass it here in constructor
  // and eventually change it later to what we want
  locator.registerLazySingleton<GameListModel>(
    () => GameListModel(),
  );

  // but beware of registerFactory method
  // it will return NEW instance each time
}
