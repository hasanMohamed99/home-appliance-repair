import 'package:company/company/domain/repository/firebase_repository.dart';

class GetCurrentPositionUseCase {
  final FirebaseRepository repository;

  GetCurrentPositionUseCase({required this.repository});

  Future<String> call(String uid) async {
    return repository.getCurrentPosition(uid);
  }
}
