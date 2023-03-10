import 'package:company/company/data/data_source/firebase_remote_data_source.dart';
import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/domain/repository/firebase_repository.dart';

class FirebaseRepositoryImpl extends FirebaseRepository {
  final FirebaseRemoteDataSource remoteDataSource;

  FirebaseRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> addOrder(OrderEntity order) async =>
      remoteDataSource.addOrder(order);

  @override
  Future<void> updateOrder(Map<String, dynamic> order) async =>
      remoteDataSource.updateOrder(order);

  @override
  Future<void> deleteOrder(OrderEntity order) async =>
      remoteDataSource.deleteOrder(order);

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async =>
      remoteDataSource.getCreateCurrentUser(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();

  @override
  Stream<List<OrderEntity>> getOrders({
    required String field,
    required String value,
  }) =>
      remoteDataSource.getOrders(
        field: field,
        value: value,
      );

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<void> updateOrderStatus({
    required String oid,
    required String field,
    required String value,
  }) async =>
      remoteDataSource.updateOrderStatus(oid: oid, field: field, value: value);

  @override
  Future<void> updateUserOrder({
    required String uId,
    required String field,
    required int value,
  }) async =>
      remoteDataSource.updateUserOrder(
        uId: uId,
        field: field,
        value: value,
      );

  @override
  Future<String> getCurrentPosition(String uid) async =>
      remoteDataSource.getCurrentPosition(uid);

  @override
  Future<Map<String, dynamic>> getUserById({required String uid}) async =>
      remoteDataSource.getUserById(uid: uid);

  @override
  Future<void> deleteUser(UserEntity user) async =>
      remoteDataSource.deleteUser(user);

  @override
  Stream<List<UserEntity>> getUsers() => remoteDataSource.getUsers();

  @override
  Stream<List<UserEntity>> getRepresentative() =>
      remoteDataSource.getRepresentative();

  @override
  Future<String> getCurrentName({required String uid}) async =>
      remoteDataSource.getCurrentName(uid: uid);

  @override
  Future<String> getDeviceToken() async => remoteDataSource.getDeviceToken();

  @override
  Future<void> updateUserDeviceToken({required String uId, required String field, required String value,}) async =>
      remoteDataSource.updateUserDeviceToken(
        uId: uId,
        field: field,
        value: value,
      );
}
