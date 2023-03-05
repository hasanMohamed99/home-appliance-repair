import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/company/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  const OrderModel({
    final String? oId,
    final String? deviceName,
    final String? customerName,
    final String? customerAddress,
    final String? customerPhone,
    final String? representativeId,
    final String? secretaryId,
    final String? problemType,
    final String? registrationDate,
    final String? orderStatus,
    final String? orderCheckedOrCheckoutStatus,
    final String? orderFixedOrNotFixedStatus,
    final String? orderDeliveredStatus,
    final String? orderCheckedOrCheckoutDate,
    final String? orderFixedOrNotFixedDate,
    final String? orderDeliveredDate,
    final String? price,
  }) : super(
          oId: oId,
          deviceName: deviceName,
          customerName: customerName,
          customerAddress: customerAddress,
          customerPhone: customerPhone,
          representativeId: representativeId,
          secretaryId: secretaryId,
          problemType: problemType,
          registrationDate: registrationDate,
          orderStatus: orderStatus,
          orderCheckedOrCheckoutStatus: orderCheckedOrCheckoutStatus,
          orderFixedOrNotFixedStatus: orderFixedOrNotFixedStatus,
          orderDeliveredStatus: orderDeliveredStatus,
          orderCheckedOrCheckoutDate: orderCheckedOrCheckoutDate,
          orderFixedOrNotFixedDate: orderFixedOrNotFixedDate,
          orderDeliveredDate: orderDeliveredDate,
          price: price,
        );

  factory OrderModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return OrderModel(
      oId: documentSnapshot.get('oId'),
      deviceName: documentSnapshot.get('deviceName'),
      customerName: documentSnapshot.get('customerName'),
      customerAddress: documentSnapshot.get('customerAddress'),
      customerPhone: documentSnapshot.get('customerPhone'),
      representativeId: documentSnapshot.get('representativeId'),
      secretaryId: documentSnapshot.get('secretaryId'),
      problemType: documentSnapshot.get('problemType'),
      registrationDate: documentSnapshot.get('registrationDate'),
      orderStatus: documentSnapshot.get('orderStatus'),
      orderCheckedOrCheckoutDate:
          documentSnapshot.get('orderCheckedOrCheckoutDate'),
      orderFixedOrNotFixedDate:
          documentSnapshot.get('orderFixedOrNotFixedDate'),
      orderDeliveredDate: documentSnapshot.get('orderDeliveredDate'),
      orderCheckedOrCheckoutStatus:
          documentSnapshot.get('orderCheckedOrCheckoutStatus'),
      orderFixedOrNotFixedStatus:
          documentSnapshot.get('orderFixedOrNotFixedStatus'),
      orderDeliveredStatus: documentSnapshot.get('orderDeliveredStatus'),
      price: documentSnapshot.get('price'),
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'oId': oId,
      'deviceName': deviceName,
      'customerName': customerName,
      'customerAddress': customerAddress,
      'customerPhone': customerPhone,
      'representativeId': representativeId,
      'secretaryId': secretaryId,
      'problemType': problemType,
      'registrationDate': registrationDate,
      'orderStatus': orderStatus,
      'orderCheckedOrCheckoutDate': orderCheckedOrCheckoutDate,
      'orderFixedOrNotFixedDate': orderFixedOrNotFixedDate,
      'orderDeliveredDate': orderDeliveredDate,
      'orderCheckedOrCheckoutStatus': orderCheckedOrCheckoutStatus,
      'orderFixedOrNotFixedStatus': orderFixedOrNotFixedStatus,
      'orderDeliveredStatus': orderDeliveredStatus,
      'price':price,
    };
  }
}
