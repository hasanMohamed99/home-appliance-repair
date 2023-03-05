import 'package:company/company/domain/repository/firebase_repository.dart';

class GetUserByUIdUseCase {
  final FirebaseRepository repository;

  GetUserByUIdUseCase({required this.repository});

  Future <Map<String, dynamic>> call({required String uid}) async {
    return repository.getUserById(uid: uid);
  }
}
