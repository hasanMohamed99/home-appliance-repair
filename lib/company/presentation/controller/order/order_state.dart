part of 'order_cubit.dart';

abstract class OrderState extends Equatable {
  const OrderState();
}

class OrderInitial extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoading extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderFailure extends OrderState {
  @override
  List<Object> get props => [];
}

class OrderLoaded extends OrderState {
  final List<OrderEntity> orders;

  const OrderLoaded({required this.orders});
  @override
  List<Object> get props => [];
}
