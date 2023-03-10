import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/domain/use_cases/delete_user_usecase.dart';
import 'package:company/company/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:company/company/domain/use_cases/get_current_name_usecase.dart';
import 'package:company/company/domain/use_cases/get_representative_usecase.dart';
import 'package:company/company/domain/use_cases/get_user_by_uid_usecase.dart';
import 'package:company/company/domain/use_cases/get_users_usecase.dart';
import 'package:company/company/domain/use_cases/sign_in_usecase.dart';
import 'package:company/company/domain/use_cases/sign_up_usecase.dart';
import 'package:company/company/domain/use_cases/update_user_device_token_usecase.dart';
import 'package:company/company/domain/use_cases/update_user_order_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'dart:io';
part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UpdateUserDeviceTokenUseCase updateUserDeviceTokenUseCase;
  final GetUserByUIdUseCase getUserByUIdUseCase;
  final UpdateUserOrderUseCase updateUserOrderUseCase;
  final GetCurrentNameUseCase getCurrentNameUseCase;
  final GetRepresentativeUseCase getRepresentativeUseCase;
  final GetUsersUseCase getUsersUseCase;
  final DeleteUserUseCase deleteUserUseCase;
  final SignInUseCase signInUseCase;
  final SignUpUseCase signUpUseCase;
  final GetCreateCurrentUserUseCase getCreateCurrentUserUseCase;
  UserCubit({
    required this.updateUserDeviceTokenUseCase,
    required this.getUserByUIdUseCase,
    required this.updateUserOrderUseCase,
    required this.signInUseCase,
    required this.signUpUseCase,
    required this.getCreateCurrentUserUseCase,
    required this.deleteUserUseCase,
    required this.getUsersUseCase,
    required this.getRepresentativeUseCase,
    required this.getCurrentNameUseCase,
  }) : super(UserInitial());

  Future<void> submitSignIn({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signInUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  void callInitialState()  {
    emit(UserInitial());
  }

  Future<void> submitSignUp({required UserEntity user}) async {
    emit(UserLoading());
    try {
      await signUpUseCase.call(user);
      await getCreateCurrentUserUseCase.call(user);
      emit(UserSuccess());
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> deleteUser({required UserEntity user}) async {
    try {
      await deleteUserUseCase(user);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> getUsers() async {
    emit(UserLoading());
    try {
      getUsersUseCase.call().listen((users) {
        emit(UsersLoaded(users:users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }


  Future<void> getRepresentative() async {
    emit(UserLoading());
    try {
      getRepresentativeUseCase.call().listen((users) {
        emit(UsersLoaded(users:users));
      });
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
  Future<void> getNameById({required String uid,}) async {
    emit(UserLoading());
    try {
      final getUserByUId = await getUserByUIdUseCase.call(uid: uid);
      emit(UserLoaded(user: getUserByUId));
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
  Future<void> getUserById({required String uid,}) async {
    emit(UserLoading());
    try {
      final getUserByUId = await getUserByUIdUseCase.call(uid: uid);
      emit(UserLoaded(user: getUserByUId));
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }
  Future<void> getCurrentName({required String uid,}) async {
    emit(UserLoading());
    try {
      final getCurrentPosition = await getCurrentNameUseCase.call(uid);
      emit(UserNameLoaded(userName: getCurrentPosition));
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

  Future<void> updateUserOrder({
    required String uId,
    required String field,
    required int value,
  }) async {
    try {
      await updateUserOrderUseCase.call(uId: uId, field: field, value: value);
    } on SocketException catch (_) {
      emit(UserFailure());
    } catch (_) {
      emit(UserFailure());
    }
  }

}
