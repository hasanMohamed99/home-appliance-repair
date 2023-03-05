import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class GetCreateCurrentUserUseCase {
  final FirebaseRepository repository;

  GetCreateCurrentUserUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.getCreateCurrentUser(user);
  }
}
