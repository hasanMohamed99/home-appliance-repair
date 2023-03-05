import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class GetOrdersUseCase {
  final FirebaseRepository repository;

  GetOrdersUseCase({required this.repository});

  Stream<List<OrderEntity>> call({
    required String field,
    required String value,
  }) {
    return repository.getOrders(
      field: field,
      value: value,
    );
  }
}
