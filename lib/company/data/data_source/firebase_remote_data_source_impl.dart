import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/company/data/data_source/firebase_remote_data_source.dart';
import 'package:company/company/data/models/order_model.dart';
import 'package:company/company/data/models/user_model.dart';
import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/entities/user_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseRemoteDataSourceImpl implements FirebaseRemoteDataSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  FirebaseRemoteDataSourceImpl({required this.auth, required this.firestore});
  @override
  Future<void> addOrder(OrderEntity orderEntity) async {
    final orderCollectionRef = firestore.collection('orders');
    orderCollectionRef
        .add(OrderModel(
          deviceName: orderEntity.deviceName,
          customerName: orderEntity.customerName,
          customerAddress: orderEntity.customerAddress,
          customerPhone: orderEntity.customerPhone,
          problemType: orderEntity.problemType,
          representativeId: orderEntity.representativeId,
          secretaryId: orderEntity.secretaryId,
          orderCheckedOrCheckoutDate: orderEntity.orderCheckedOrCheckoutDate,
          orderFixedOrNotFixedDate: orderEntity.orderFixedOrNotFixedDate,
          orderDeliveredDate: orderEntity.orderDeliveredDate,
          orderStatus: orderEntity.orderStatus,
          registrationDate: orderEntity.registrationDate,
          orderCheckedOrCheckoutStatus: orderEntity.orderCheckedOrCheckoutStatus,
          orderFixedOrNotFixedStatus: orderEntity.orderFixedOrNotFixedStatus,
          orderDeliveredStatus: orderEntity.orderDeliveredStatus,
          price: orderEntity.price,
        ).toDocument())
        .then((value) => value.update({'oId': value.id}));
    return;
  }

  @override
  Future<void> updateOrder(Map<String, dynamic> order) async {
    final orderCollectionRef = FirebaseFirestore.instance.collection('orders');
    orderCollectionRef.doc(order['oid']).update({
      'deviceName': order['deviceName'],
      'customerName': order['customerName'],
      'customerAddress': order['customerAddress'],
      'customerPhone': order['customerPhone'],
      'problemType': order['problemType'],
    });
    return;
  }

  @override
  Future<void> deleteOrder(OrderEntity orderEntity) async {
    final orderCollectionRef = FirebaseFirestore.instance.collection('orders');
    orderCollectionRef.doc(orderEntity.oId).get().then((order) {
      if (order.exists) {
        orderCollectionRef.doc(orderEntity.oId).delete();
      }
      return;
    });
  }

  @override
  Future<void> deleteUser(UserEntity userEntity) async {
    final orderCollectionRef = FirebaseFirestore.instance.collection('users');
    orderCollectionRef.doc(userEntity.uId).get().then((user) {
      if (user.exists) {
        orderCollectionRef.doc(userEntity.uId).delete();
      }
      return;
    });
  }

  @override
  Future<void> getCreateCurrentUser(UserEntity user) async {
    final userCollectionRef = firestore.collection('users');

    final uid = await getCurrentUId();

    userCollectionRef.doc(uid).get().then((value) async {
      final newUser = UserModel(
        uId: uid,
        position: user.position,
        username: user.username,
        password: user.password,
        name: user.name,
        finishedOrders: user.finishedOrders,
        currentOrders: user.currentOrders,
      ).toDocument();
      if (!value.exists) {
        userCollectionRef.doc(uid).set(newUser);
      }
      return;
    });
  }

  @override
  Future<String> getCurrentUId() async => auth.currentUser!.uid;

  @override
  Future<bool> isSignIn() async => auth.currentUser?.uid != null;

  @override
  Future<void> signIn(UserEntity user) async => auth.signInWithEmailAndPassword(
      email: '${user.username!}@mc.com', password: user.password!);

  @override
  Future<void> signOut() async => auth.signOut();

  @override
  Future<void> signUp(UserEntity user) async =>
      auth.createUserWithEmailAndPassword(
          email: user.username!, password: user.password!);

  @override
  Future<void> updateOrderStatus({
    required String oid,
    required String field,
    required String value,
  }) async {
    final orderCollectionRef = FirebaseFirestore.instance.collection('orders');
    orderCollectionRef.doc(oid).update({
      field: value,
    });
    return;
  }

  @override
  Future<void> updateUserOrder({
    required String uId,
    required String field,
    required int value,
  }) async {
    final orderCollectionRef = FirebaseFirestore.instance.collection('users');
    orderCollectionRef.doc(uId).update({
      field: value,
    });
    return;
  }

  @override
  Future<String> getCurrentPosition(String uid) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    Map<String, dynamic> data = docSnapshot.data()!;
    var position = data['position'];
    return position;
  }

  @override
  Future<String> getCurrentName({required String uid}) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    Map<String, dynamic> data = docSnapshot.data()!;
    var name = data['name'];
    return name;
  }

  @override
  Future<Map<String, dynamic>> getUserById({required String uid}) async {
    var collection = FirebaseFirestore.instance.collection('users');
    var docSnapshot = await collection.doc(uid).get();
    return docSnapshot.data()!;
  }

  @override
  Stream<List<OrderEntity>> getOrders({
    required String field,
    required String value,
  }) {
    final orderCollectionRef =
        firestore.collection('orders').where(field, isEqualTo: value);
    return orderCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => OrderModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<List<UserEntity>> getUsers() {
    final userCollectionRef = firestore.collection('users').where(
          'position',
          isNotEqualTo: 'manager',
        );
    return userCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => UserModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Stream<List<UserEntity>> getRepresentative() {
    final userCollectionRef = firestore.collection('users').where(
          'position',
          isEqualTo: 'representative',
        );
    return userCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => UserModel.fromSnapshot(docSnap))
          .toList();
    });
  }
}
