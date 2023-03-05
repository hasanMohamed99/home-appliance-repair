import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? oId;
  final String? deviceName;
  final String? customerName;
  final String? customerAddress;
  final String? customerPhone;
  final String? representativeId;
  final String? secretaryId;
  final String? problemType;
  final String? registrationDate;
  final String? orderStatus;
  final String? orderCheckedOrCheckoutStatus;
  final String? orderFixedOrNotFixedStatus;
  final String? orderDeliveredStatus;
  final String? orderCheckedOrCheckoutDate;
  final String? orderFixedOrNotFixedDate;
  final String? orderDeliveredDate;
  final String? price;

  const OrderEntity({
    this.oId,
    this.deviceName,
    this.customerName,
    this.customerAddress,
    this.customerPhone,
    this.representativeId,
    this.secretaryId,
    this.problemType,
    this.registrationDate,
    this.orderStatus,
    this.orderCheckedOrCheckoutDate,
    this.orderFixedOrNotFixedDate,
    this.orderDeliveredDate,
    this.orderCheckedOrCheckoutStatus,
    this.orderFixedOrNotFixedStatus,
    this.orderDeliveredStatus,
    this.price,
  });

  @override
  List<Object?> get props => [
        oId,
        deviceName,
        customerName,
        customerAddress,
        customerPhone,
        representativeId,
        problemType,
        registrationDate,
        orderStatus,
        orderCheckedOrCheckoutDate,
        orderFixedOrNotFixedDate,
        orderDeliveredDate,
        orderCheckedOrCheckoutStatus,
        orderFixedOrNotFixedStatus,
        orderDeliveredStatus,
        price,
      ];
}
