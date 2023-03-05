import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class UpdateOrderStatusUseCase {
  final FirebaseRepository repository;

  UpdateOrderStatusUseCase({required this.repository});

  Future<void> call({
    required String oid,
    required String field,
    required String value,
  }) async {
    return repository.updateOrderStatus(oid: oid, field: field, value: value);
  }
}
