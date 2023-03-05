import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/use_cases/add_order_usecase.dart';
import 'package:company/company/domain/use_cases/delete_order_usecase.dart';
import 'package:company/company/domain/use_cases/get_orders_usecase.dart';
import 'package:company/company/domain/use_cases/update_order_status_usecase.dart';
import 'package:company/company/domain/use_cases/update_order_usecase.dart';
import 'package:equatable/equatable.dart';

part 'order_state.dart';

class OrderCubit extends Cubit<OrderState> {
  final UpdateOrderUseCase updateOrderUseCase;
  final UpdateOrderStatusUseCase updateOrderStatusUseCase;
  final DeleteOrderUseCase deleteOrderUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final AddOrderUseCase addOrderUseCase;
  OrderCubit({
    required this.updateOrderStatusUseCase,
    required this.deleteOrderUseCase,
    required this.getOrdersUseCase,
    required this.addOrderUseCase,
    required this.updateOrderUseCase,
  }) : super(OrderInitial());
  Future<void> addOrder({required OrderEntity order}) async {
    try {
      await addOrderUseCase.call(order);
    } on SocketException catch (_) {
      emit(OrderFailure());
    } catch (_) {
      emit(OrderFailure());
    }
  }

  Future<void> deleteOrder({required OrderEntity order}) async {
    try {
      await deleteOrderUseCase.call(order);
    } on SocketException catch (_) {
      emit(OrderFailure());
    } catch (_) {
      emit(OrderFailure());
    }
  }

  Future<void> updateOrderStatus({
    required String oid,
    required String field,
    required String value,
  }) async {
    try {
      await updateOrderStatusUseCase.call(oid: oid, field: field, value: value);
    } on SocketException catch (_) {
      emit(OrderFailure());
    } catch (_) {
      emit(OrderFailure());
    }
  }

  Future<void> updateOrder({required Map<String, dynamic> order}) async {
    try {
      await updateOrderUseCase.call(order);
    } on SocketException catch (_) {
      emit(OrderFailure());
    } catch (_) {
      emit(OrderFailure());
    }
  }

  Future<void> getOrders({
    required String field,
    required String value,
  }) async {
    emit(OrderLoading());
    try {
      getOrdersUseCase
          .call(
        field: field,
        value: value,
      )
          .listen((orders) {
        emit(OrderLoaded(orders: orders));
      });
    } on SocketException catch (_) {
      emit(OrderFailure());
    } catch (_) {
      emit(OrderFailure());
    }
  }
}
