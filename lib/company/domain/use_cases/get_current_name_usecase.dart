import 'package:company/company/domain/repository/firebase_repository.dart';

class GetCurrentNameUseCase {
  final FirebaseRepository repository;

  GetCurrentNameUseCase({required this.repository});

  Future<String> call(String uid) async {
    return repository.getCurrentName(uid:uid);
  }
}
