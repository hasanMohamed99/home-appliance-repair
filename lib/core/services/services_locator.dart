import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/company/data/data_source/firebase_remote_data_source.dart';
import 'package:company/company/data/data_source/firebase_remote_data_source_impl.dart';
import 'package:company/company/data/repository/firebase_repository_impl.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';
import 'package:company/company/domain/use_cases/add_order_usecase.dart';
import 'package:company/company/domain/use_cases/delete_order_usecase.dart';
import 'package:company/company/domain/use_cases/delete_user_usecase.dart';
import 'package:company/company/domain/use_cases/get_create_current_user_usecase.dart';
import 'package:company/company/domain/use_cases/get_current_name_usecase.dart';
import 'package:company/company/domain/use_cases/get_current_position_usecase.dart';
import 'package:company/company/domain/use_cases/get_current_uid_usecase.dart';
import 'package:company/company/domain/use_cases/get_device_token_usecase.dart';
import 'package:company/company/domain/use_cases/get_orders_usecase.dart';
import 'package:company/company/domain/use_cases/get_representative_usecase.dart';
import 'package:company/company/domain/use_cases/get_user_by_uid_usecase.dart';
import 'package:company/company/domain/use_cases/get_users_usecase.dart';
import 'package:company/company/domain/use_cases/is_sign_in_usecase.dart';
import 'package:company/company/domain/use_cases/sign_in_usecase.dart';
import 'package:company/company/domain/use_cases/sign_out_usecase.dart';
import 'package:company/company/domain/use_cases/sign_up_usecase.dart';
import 'package:company/company/domain/use_cases/update_order_status_usecase.dart';
import 'package:company/company/domain/use_cases/update_order_usecase.dart';
import 'package:company/company/domain/use_cases/update_user_device_token_usecase.dart';
import 'package:company/company/domain/use_cases/update_user_order_usecase.dart';
import 'package:company/company/presentation/controller/auth/auth_cubit.dart';
import 'package:company/company/presentation/controller/order/order_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';

GetIt sl = GetIt.instance;

Future<void> init() async {
  /// Bloc
  sl.registerFactory<AuthCubit>(() => AuthCubit(
        getCurrentUIdUseCase: sl.call(),
        isSignInUseCase: sl.call(),
        signOutUseCase: sl.call(),
        getCurrentPositionUseCase: sl.call(),
        getUserByUIdUseCase: sl.call(),
        getDeviceTokenUseCase: sl.call(),
      ));
  sl.registerFactory<UserCubit>(() => UserCubit(
        signInUseCase: sl.call(),
        signUpUseCase: sl.call(),
        getCreateCurrentUserUseCase: sl.call(),
        deleteUserUseCase: sl.call(),
        getUsersUseCase: sl.call(),
        getRepresentativeUseCase: sl.call(),
        getCurrentNameUseCase: sl.call(),
        updateUserOrderUseCase: sl.call(),
        getUserByUIdUseCase: sl.call(),
        updateUserDeviceTokenUseCase: sl.call(),
      ));
  sl.registerFactory<OrderCubit>(() => OrderCubit(
        updateOrderUseCase: sl.call(),
        updateOrderStatusUseCase: sl.call(),
        deleteOrderUseCase: sl.call(),
        getOrdersUseCase: sl.call(),
        addOrderUseCase: sl.call(),
      ));

  /// Use Cases
  sl.registerLazySingleton<AddOrderUseCase>(
      () => AddOrderUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteOrderUseCase>(
      () => DeleteOrderUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCreateCurrentUserUseCase>(
      () => GetCreateCurrentUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentUIdUseCase>(
      () => GetCurrentUIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentPositionUseCase>(
      () => GetCurrentPositionUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetOrdersUseCase>(
      () => GetOrdersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUserByUIdUseCase>(
      () => GetUserByUIdUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetDeviceTokenUseCase>(
      () => GetDeviceTokenUseCase(repository: sl.call()));
  sl.registerLazySingleton<IsSignInUseCase>(
      () => IsSignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignInUseCase>(
      () => SignInUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignOutUseCase>(
      () => SignOutUseCase(repository: sl.call()));
  sl.registerLazySingleton<SignUpUseCase>(
      () => SignUpUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateOrderStatusUseCase>(
      () => UpdateOrderStatusUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateUserDeviceTokenUseCase>(
      () => UpdateUserDeviceTokenUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateOrderUseCase>(
      () => UpdateOrderUseCase(repository: sl.call()));
  sl.registerLazySingleton<UpdateUserOrderUseCase>(
      () => UpdateUserOrderUseCase(repository: sl.call()));
  sl.registerLazySingleton<DeleteUserUseCase>(
      () => DeleteUserUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetUsersUseCase>(
      () => GetUsersUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetRepresentativeUseCase>(
      () => GetRepresentativeUseCase(repository: sl.call()));
  sl.registerLazySingleton<GetCurrentNameUseCase>(
      () => GetCurrentNameUseCase(repository: sl.call()));

  /// Repository
  sl.registerLazySingleton<FirebaseRepository>(
      () => FirebaseRepositoryImpl(remoteDataSource: sl.call()));

  /// Data Source
  sl.registerLazySingleton<FirebaseRemoteDataSource>(() =>
      FirebaseRemoteDataSourceImpl(auth: sl.call(), firestore: sl.call()));

  /// External
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;
  sl.registerLazySingleton(() => auth);
  sl.registerLazySingleton(() => fireStore);
}
