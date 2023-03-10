import 'package:company/company/domain/use_cases/get_current_position_usecase.dart';
import 'package:company/company/domain/use_cases/get_current_uid_usecase.dart';
import 'package:company/company/domain/use_cases/get_device_token_usecase.dart';
import 'package:company/company/domain/use_cases/get_user_by_uid_usecase.dart';
import 'package:company/company/domain/use_cases/is_sign_in_usecase.dart';
import 'package:company/company/domain/use_cases/sign_out_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final GetDeviceTokenUseCase getDeviceTokenUseCase;
  final GetUserByUIdUseCase getUserByUIdUseCase;
  final GetCurrentUIdUseCase getCurrentUIdUseCase;
  final IsSignInUseCase isSignInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetCurrentPositionUseCase getCurrentPositionUseCase;
  AuthCubit({
    required this.getDeviceTokenUseCase,
    required this.getUserByUIdUseCase,
    required this.getCurrentUIdUseCase,
    required this.isSignInUseCase,
    required this.signOutUseCase,
    required this.getCurrentPositionUseCase,
  }) : super(AuthInitial());

  Future<void> appStarted() async {
    try {
      final isSignIn = await isSignInUseCase.call();

      if (isSignIn) {
        final uid = await getCurrentUIdUseCase.call();
        final getCurrentPosition = await getCurrentPositionUseCase.call(uid);
        final getUserByUIdUse = await getUserByUIdUseCase.call(uid: uid);
        final deviceToken = await getDeviceTokenUseCase.call();
        emit(Authenticated(
          uid: uid,
          position: getCurrentPosition,
          user: getUserByUIdUse,
          deviceToken: deviceToken,
        ));
      } else {
        emit(UnAuthenticated());
      }
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedIn() async {
    try {
      final uid = await getCurrentUIdUseCase.call();
      final getCurrentPosition = await getCurrentPositionUseCase.call(uid);
      final getUserByUIdUse = await getUserByUIdUseCase.call(uid: uid);
      final deviceToken = await getDeviceTokenUseCase.call();
      emit(Authenticated(
        uid: uid,
        position: getCurrentPosition,
        user: getUserByUIdUse,
        deviceToken: deviceToken,
      ));
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }

  Future<void> loggedOut() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.clear();
      await signOutUseCase.call();
      emit(UnAuthenticated());
    } on SocketException catch (_) {
      emit(UnAuthenticated());
    }
  }
}
