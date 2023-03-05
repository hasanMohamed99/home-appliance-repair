import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class UpdateOrderUseCase {
  final FirebaseRepository repository;

  UpdateOrderUseCase({required this.repository});

  Future<void> call(Map<String, dynamic> order) async {
    return repository.updateOrder(order);
  }
}
