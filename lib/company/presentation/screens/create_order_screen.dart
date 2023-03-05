import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/order/order_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/utils/app_router.dart';
import 'package:company/core/utils/app_strings.dart';
import 'package:company/core/utils/background_empty.dart';
import 'package:company/core/utils/colors.dart';
import 'package:company/core/utils/app_constants.dart';
import 'package:company/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CreateOrderScreen extends StatelessWidget {
  final Map<String, dynamic> createOrderParameters;
  // Create Order
  // {
  // 'secretary': secretaryParameter['user'],
  // 'uid': secretaryParameter['uid'],
  // 'position': AppString.mainStrings['secretary'],
  // 'orderType': AppString.secretaryScreenStrings['create_order'],
  // }

  // Modify Order
  // {
  // 'representative': userState.user,
  // 'secretary': secretaryParameter['user'],
  // 'uid': orderListParameters['uid'],
  // 'position': AppString.mainStrings['secretary'],
  // 'orderType': AppString.secretaryScreenStrings['modify_order'],
  // 'order': order,
  // }
  const CreateOrderScreen({
    Key? key,
    required this.createOrderParameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundEmpty(
        hasAppBarIcon: true,
        child: _CreateOrderBody(
          createOrderParameters: createOrderParameters,
        ),
      ),
    );
  }
}

class _CreateOrderBody extends StatefulWidget {
  final Map<String, dynamic> createOrderParameters;

  const _CreateOrderBody({
    Key? key,
    required this.createOrderParameters,
  }) : super(key: key);

  @override
  State<_CreateOrderBody> createState() => _CreateOrderBodyState();
}

class _CreateOrderBodyState extends State<_CreateOrderBody> {
  var order = const OrderEntity();
  var clientNameController = TextEditingController();
  var clientAddressController = TextEditingController();
  var clientPhoneController = TextEditingController();
  var deviceProblemController = TextEditingController();
  var deviceTypeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  String? selectedDevice;

  @override
  void dispose() {
    clientNameController.dispose();
    clientAddressController.dispose();
    clientPhoneController.dispose();
    deviceProblemController.dispose();
    deviceTypeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    order = widget.createOrderParameters['order'] ?? const OrderEntity();
    if (widget.createOrderParameters['orderType'] ==
        AppString.secretaryScreenStrings['modify_order']) {
      clientNameController.text = order.customerName!;
      clientAddressController.text = order.customerAddress!;
      clientPhoneController.text = order.customerPhone!;
      deviceProblemController.text = order.problemType!;
      selectedDevice = order.deviceName!;
    }
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kCreateOrderPadding.w),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: kButtonWidth.w,
                height: kButtonHeight.h,
                child: defaultTextFormField(
                  style: Styles.textStyle16(normalTextColor, context),
                  label: AppString.createOrderScreenStrings['client_name']!,
                  controller: clientNameController,
                  type: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kRadius.r),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: kButtonWidth.w,
                height: kButtonHeight.h,
                child: defaultTextFormField(
                  style: Styles.textStyle16(normalTextColor, context),
                  label: AppString.createOrderScreenStrings['client_address']!,
                  controller: clientAddressController,
                  type: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kRadius.r),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: kButtonWidth.w,
                height: kButtonHeight.h,
                child: defaultTextFormField(
                  style: Styles.textStyle16(normalTextColor, context),
                  label: AppString.createOrderScreenStrings['client_phone']!,
                  controller: clientPhoneController,
                  type: TextInputType.phone,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kRadius.r),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: kButtonWidth.w,
                height: kButtonHeight.h,
                child: defaultTextFormField(
                  style: Styles.textStyle16(normalTextColor, context),
                  label: AppString.createOrderScreenStrings['device_problem']!,
                  controller: deviceProblemController,
                  type: TextInputType.name,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return '';
                    }
                    return null;
                  },
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kRadius.r),
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              SizedBox(
                width: kButtonWidth.w / 1.8,
                height: kButtonHeight.h,
                child: DropdownButtonFormField<String>(
                  isDense: ScreenUtil().screenWidth >= 700 ? false : true,
                  hint: const Text('Choose device'),
                  validator: (value) {
                    if (value == null) {
                      return 'please, select device type';
                    }
                    return null;
                  },
                  style: Styles.textStyle14(normalTextColor, context),
                  value: selectedDevice,
                  items: AppString.devices
                      .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(item,
                              style: Styles.textStyle14(
                                  normalTextColor, context))))
                      .toList(),
                  onChanged: (item) => setState(() {
                    selectedDevice = item;
                    deviceTypeController.text = selectedDevice!;
                  }),
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              widget.createOrderParameters['orderType'] ==
                      AppString.secretaryScreenStrings['create_order']
                  ? defaultButton(
                      function: () {
                        fillNewOrder();
                      },
                      text: AppString.createOrderScreenStrings['send']!,
                      width: kButtonWidth.w / 2,
                      height: kButtonHeight.h,
                      radius: kRadius.r,
                      style: Styles.textStyle20(iconTextColor, context),
                    )
                  : Row(
                      children: [
                        Expanded(
                          child: defaultButton(
                            function: () {
                              if (formKey.currentState!.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (context) => SimpleDialog(
                                    title: Text(
                                      'Confirm modifying order',
                                      style: Styles.textStyle16(
                                          normalTextColor, context),
                                    ),
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              child: defaultTextButton(
                                                  function: () {
                                                    Navigator.pop(context);
                                                  },
                                                  text: 'Cancel')),
                                          Expanded(
                                              child: defaultTextButton(
                                                  function: () {
                                                    updateOrder();
                                                    showToast(
                                                        text:
                                                            'order modified successfully ',
                                                        state: ToastStates
                                                            .SUCCESS);
                                                    GoRouter.of(context).go(
                                                      AppRouter
                                                          .kSecretaryScreen,
                                                      extra: {
                                                        'user': widget.createOrderParameters['secretary'],
                                                        'uid': widget.createOrderParameters['uid'],
                                                        'position': 'Secretary'
                                                      },
                                                    );
                                                  },
                                                  text: 'Confirm')),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            text: AppString.createOrderScreenStrings['save']!,
                            height: kButtonHeight.h,
                            radius: kRadius.r,
                            style: Styles.textStyle20(iconTextColor, context),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: defaultButton(
                            function: () {
                              showDialog(
                                context: context,
                                builder: (context) => SimpleDialog(
                                  title: Text(
                                    'Confirm removing order',
                                    style: Styles.textStyle16(
                                        normalTextColor, context),
                                  ),
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                            child: defaultTextButton(
                                                function: () {
                                                  Navigator.pop(context);
                                                },
                                                text: 'Cancel')),
                                        Expanded(
                                            child: defaultTextButton(
                                                function: () {

                                                  updateUserOrder(
                                                      uId: widget.createOrderParameters['representative']['uId'],
                                                      field: 'currentOrders',
                                                      value: widget.createOrderParameters['representative']['currentOrders']-1);
                                                  updateUserOrder(
                                                      uId: widget.createOrderParameters['secretary']['uId'],
                                                      field: 'currentOrders',
                                                      value: widget.createOrderParameters['secretary']['currentOrders']-1);
                                                  BlocProvider.of<OrderCubit>(context).deleteOrder(order: order);
                                                  showToast(
                                                      text:
                                                          'order removed successfully ',
                                                      state:
                                                          ToastStates.SUCCESS);
                                                  widget.createOrderParameters['secretary']['currentOrders']-=1;
                                                  GoRouter.of(context).go(
                                                    AppRouter.kSecretaryScreen,
                                                    extra: {
                                                      'user': widget.createOrderParameters['secretary'],
                                                      'uid': widget.createOrderParameters['uid'],
                                                      'position': 'Secretary'
                                                    },
                                                  );
                                                },
                                                text: 'Confirm')),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            text: AppString
                                .createOrderScreenStrings['remove_order']!,
                            height: kButtonHeight.h,
                            radius: kRadius.r,
                            style: Styles.textStyle20(iconTextColor, context),
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void fillNewOrder() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<UserCubit>(context).getRepresentative();
      GoRouter.of(context).push(AppRouter.kUserListViewScreen, extra: {
        'secretary': widget.createOrderParameters['secretary'],
        'uid': widget.createOrderParameters['uid'],
        'position': AppString.mainStrings['secretary'],
        'representative_list': 'Representative List',
        'order': {
          'deviceName': deviceTypeController.text,
          'customerName': clientNameController.text,
          'customerAddress': clientAddressController.text,
          'customerPhone': clientPhoneController.text,
          'orderStatus': 'new',
          'problemType': deviceProblemController.text,
          'registrationDate':
              DateFormat('dd MMM yyyy hh:mm a').format(DateTime.now()),
          'secretaryId': widget.createOrderParameters['uid'],
          'orderStatusDate': '',
        },
      });
    }
  }

  Map<String, dynamic> returnUpdateMap() {
    return {
      'oid': order.oId,
      'deviceName': deviceTypeController.text,
      'customerName': clientNameController.text,
      'customerAddress': clientAddressController.text,
      'customerPhone': clientPhoneController.text,
      'problemType': deviceProblemController.text,
    };
  }

  void updateOrder() {
    BlocProvider.of<OrderCubit>(context).updateOrder(order: returnUpdateMap());
  }

  void updateUserOrder({
    required String uId,
    required String field,
    required int value,
  }) {
    BlocProvider.of<UserCubit>(context)
        .updateUserOrder(uId: uId, field: field, value: value);
  }
}
