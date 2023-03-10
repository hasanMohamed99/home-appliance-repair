import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class GetDeviceTokenUseCase {
  final FirebaseRepository repository;

  GetDeviceTokenUseCase({required this.repository});

  Future<String> call() {
    return repository.getDeviceToken();
  }
}
