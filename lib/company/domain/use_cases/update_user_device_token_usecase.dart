import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class UpdateUserDeviceTokenUseCase {
  final FirebaseRepository repository;

  UpdateUserDeviceTokenUseCase({required this.repository});

  Future<void> call({
    required String uId,
    required String field,
    required String value,
  }) async {
    return repository.updateUserDeviceToken(
      uId: uId,
      field: field,
      value: value,
    );
  }
}
