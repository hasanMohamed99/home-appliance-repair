import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/company/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? uId,
    final String? name,
    final String? password,
    final String? username,
    final String? position,
    final int? finishedOrders,
    final int? currentOrders,
  }): super(
    uId: uId,
    name: name,
    password: password,
    username: username,
    position: position,
    finishedOrders: finishedOrders,
    currentOrders:currentOrders,
  );

  factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot){
    return UserModel(
      uId: documentSnapshot.get('uId'),
      name: documentSnapshot.get('name'),
      password: documentSnapshot.get('password'),
      username: documentSnapshot.get('username'),
      position: documentSnapshot.get('position'),
      finishedOrders: documentSnapshot.get('finishedOrders'),
      currentOrders: documentSnapshot.get('currentOrders'),
    );
  }

  Map<String,dynamic> toDocument(){
    return {
      'uId':uId,
      'name':name,
      'password': password,
      'username':username,
      'position':position,
      'finishedOrders': finishedOrders,
      'currentOrders': currentOrders,
    };
  }
}
