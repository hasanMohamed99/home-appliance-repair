import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class UpdateUserOrderUseCase {
  final FirebaseRepository repository;

  UpdateUserOrderUseCase({required this.repository});

  Future<void> call({
    required String uId,
    required String field,
    required int value,
  }) async {
    return repository.updateUserOrder(
      uId: uId,
      field: field,
      value: value,
    );
  }
}
