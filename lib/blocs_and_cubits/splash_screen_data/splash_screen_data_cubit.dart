import 'package:bloc/bloc.dart';

enum SplashScreenDataStatus {
  initial,
  submitting,
  success,
  error,
}

class SplashScreenDataCubit extends Cubit<SplashScreenDataStatus> {
  SplashScreenDataCubit() : super(SplashScreenDataStatus.initial);
}
