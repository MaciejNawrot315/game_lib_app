import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_lib_app/models/user.dart';
import 'package:game_lib_app/repositories/firestore_repository.dart';

class UserCubit extends Cubit<User> {
  final ProfileRepository profileRepository;
  UserCubit({
    required this.profileRepository,
  }) : super(User.initial());

  Future<void> getUser(String? uid) async {
    if (uid != null) {
      emit(await profileRepository.getProfile(uid: uid));
    }
  }

  void setToInitial() {
    emit(User.initial());
  }
}
