import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class SignInUseCase {
  final FirebaseRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signIn(user);
  }
}
