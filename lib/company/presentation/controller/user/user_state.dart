part of 'user_cubit.dart';

abstract class UserState extends Equatable {
  const UserState();
}

class UserInitial extends UserState {
  @override
  List<Object> get props => [];
}

class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

class UserFailure extends UserState {
  @override
  List<Object> get props => [];
}

class UserSuccess extends UserState {
  @override
  List<Object> get props => [];
}

class UsersLoaded extends UserState {
  final List<UserEntity> users;

  const UsersLoaded({required this.users});
  @override
  List<Object> get props => [users];
}

class UserNameLoaded extends UserState {
  final String userName;

  const UserNameLoaded({required this.userName});
  @override
  List<Object> get props => [userName];
}

class UserLoaded extends UserState {
  final Map<String, dynamic> user;

  const UserLoaded({required this.user});
  @override
  List<Object> get props => [user];
}


