import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? uId;
  final String? name;
  final String? password;
  final String? username;
  final String? position;
  final String? deviceToken;
  final int? finishedOrders;
  final int? currentOrders;

  const UserEntity({
    this.uId,
    this.name,
    this.password,
    this.username,
    this.position,
    this.deviceToken,
    this.finishedOrders,
    this.currentOrders,
  });

  @override
  List<Object?> get props => [
        uId,
        name,
        password,
        username,
        position,
        deviceToken,
        finishedOrders,
        currentOrders,
      ];
}
