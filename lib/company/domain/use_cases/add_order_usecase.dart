import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class AddOrderUseCase {
  final FirebaseRepository repository;

  AddOrderUseCase({required this.repository});

  Future<void> call(OrderEntity order) async {
    return repository.addOrder(order);
  }
}
