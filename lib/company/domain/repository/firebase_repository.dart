import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/entities/user_entity.dart';

abstract class FirebaseRepository {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut(); // logout
  Future<String> getCurrentUId();
  Future<String> getCurrentPosition(String uid);
  Future<String> getCurrentName({required String uid});
  Future<String> getDeviceToken();
  Future<void> getCreateCurrentUser(UserEntity user);
  Future <Map<String, dynamic>> getUserById({required String uid});
  Future<void> addOrder(OrderEntity order);
  Future<void> updateOrder(Map<String, dynamic> order);
  Future<void> updateOrderStatus({
    required String oid,
    required String field,
    required String value,
  });
  Future<void> updateUserOrder({
    required String uId,
    required String field,
    required int value,
  });
  Future<void> updateUserDeviceToken({
    required String uId,
    required String field,
    required String value,
  });
  Future<void> deleteOrder(OrderEntity order);
  Future<void> deleteUser(UserEntity user);
  Stream<List<OrderEntity>> getOrders({
    required String field,
    required String value,
  });
  Stream<List<UserEntity>> getUsers();
  Stream<List<UserEntity>> getRepresentative();
}
