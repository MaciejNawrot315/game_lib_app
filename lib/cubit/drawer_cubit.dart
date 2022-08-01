import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'drawer_state.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(DrawerInitial());
  void changeState(DrawerState newState) => emit(newState);
}
