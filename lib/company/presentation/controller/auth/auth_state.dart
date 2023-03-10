part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class Authenticated extends AuthState {
  final String uid;
  final String position;
  final Map<String, dynamic> user;
  final String deviceToken;
  const Authenticated({
    required this.uid,
    required this.position,
    required this.user,
    required this.deviceToken,
  });
  @override
  List<Object> get props => [];
}

class UnAuthenticated extends AuthState {
  @override
  List<Object> get props => [];
}
