import 'package:company/company/presentation/controller/auth/auth_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/company/presentation/screens/create_order_screen.dart';
import 'package:company/company/presentation/screens/create_user_screen.dart';
import 'package:company/company/presentation/screens/login_screen.dart';
import 'package:company/company/presentation/screens/manager_screen.dart';
import 'package:company/company/presentation/screens/modify_user_list_screen.dart';
import 'package:company/company/presentation/screens/order_list_screen.dart';
import 'package:company/company/presentation/screens/order_screen.dart';
import 'package:company/company/presentation/screens/representative_screen.dart';
import 'package:company/company/presentation/screens/secretary_screen.dart';
import 'package:company/company/presentation/screens/start_screen.dart';
import 'package:company/company/presentation/screens/user_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'colors.dart';

abstract class AppRouter {
  static const kLoginScreen = '/loginScreen';
  static const kManagerScreen = '/managerScreen';
  static const kSecretaryScreen = '/secretaryScreen';
  static const kRepresentativeScreen = '/representativeScreen';
  static const kOrderListViewScreen = '/orderListViewScreen';
  static const kOrderScreen = '/orderScreen';
  static const kCreateUserScreen = '/createUserScreen';
  static const kCreateOrderScreen = '/createOrderScreen';
  static const kModifyUserListViewScreen = '/modifyUserListViewScreen';
  static const kUserListViewScreen = '/userListViewScreen';

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => BlocBuilder<AuthCubit, AuthState>(
          builder: (context, authState) {
            if (authState is Authenticated && authState.position == 'manager') {
              getPosition(authState.uid).then((value) {
                if (value == authState.position) {
                  BlocProvider.of<UserCubit>(context).updateUserDeviceTokenUseCase(uId: authState.uid, field: 'deviceToken', value: authState.deviceToken);
                  GoRouter.of(context).go(AppRouter.kManagerScreen, extra: {
                    'uid': authState.uid,
                    'position': 'Manager',
                    'user': authState.user
                  });
                } else {
                  GoRouter.of(context).go('/');
                }
              });
            }
            if (authState is Authenticated &&
                authState.position == 'secretary') {
              getPosition(authState.uid).then((value) {
                if (value == authState.position) {
                  BlocProvider.of<UserCubit>(context).updateUserDeviceTokenUseCase(uId: authState.uid, field: 'deviceToken', value: authState.deviceToken);
                  GoRouter.of(context).go(AppRouter.kSecretaryScreen, extra: {
                    'uid': authState.uid,
                    'position': 'Secretary',
                    'user': authState.user
                  });
                } else {
                  GoRouter.of(context).go('/');
                }
              });
            }
            if (authState is Authenticated &&
                authState.position == 'representative') {
              getPosition(authState.uid).then((value) {
                if (value == authState.position) {
                  BlocProvider.of<UserCubit>(context).updateUserDeviceTokenUseCase(uId: authState.uid, field: 'deviceToken', value: authState.deviceToken);
                  GoRouter.of(context).go(AppRouter.kRepresentativeScreen,
                      extra: {
                        'uid': authState.uid,
                        'position': 'Representative',
                        'user': authState.user
                      });
                } else {
                  GoRouter.of(context).go('/');
                }
              });
            }
            if (authState is UnAuthenticated) {
              return const StartScreen();
            }
            return Container(
              height: double.infinity,
              width: double.infinity,
              color: backgroundColor,
              child: const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
      GoRoute(
        path: kLoginScreen,
        builder: (context, state) =>
            LoginScreen(position: state.extra as String),
      ),
      GoRoute(
        path: kManagerScreen,
        builder: (context, state) =>
            ManagerScreen(managerParameter: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kSecretaryScreen,
        builder: (context, state) => SecretaryScreen(
            secretaryParameter: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kRepresentativeScreen,
        builder: (context, state) => RepresentativeScreen(
            representativeParameter: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kOrderListViewScreen,
        builder: (context, state) => OrderListScreen(
            orderListParameters: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kOrderScreen,
        builder: (context, state) => OrderScreen(
            orderScreenParameters: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kCreateUserScreen,
        builder: (context, state) =>
            CreateUserScreen(createUserParameters: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kCreateOrderScreen,
        builder: (context, state) => CreateOrderScreen(
            createOrderParameters: state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kModifyUserListViewScreen,
        builder: (context, state) =>
            ModifyUserListScreen(modifyUserListParameters:state.extra as Map<String, dynamic>),
      ),
      GoRoute(
        path: kUserListViewScreen,
        builder: (context, state) => UserListScreen(
            userListParameters: state.extra as Map<String, dynamic>),
      ),
    ],
  );
}

Future<String?> getPosition(String userID) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString(userID);
}
