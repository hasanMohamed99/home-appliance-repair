import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class GetRepresentativeUseCase {
  final FirebaseRepository repository;

  GetRepresentativeUseCase({required this.repository});

  Stream<List<UserEntity>> call() {
    return repository.getRepresentative();
  }
}
