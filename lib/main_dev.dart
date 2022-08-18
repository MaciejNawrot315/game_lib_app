import 'package:game_lib_app/main.dart';
import 'package:game_lib_app/models/environment.dart';

Future<void> main() async {
  await mainCommon(Environment.dev);
}
