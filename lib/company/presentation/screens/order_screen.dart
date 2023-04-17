import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/order/order_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/utils/app_icons.dart';
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
import 'package:timeline_tile/timeline_tile.dart';

class OrderScreen extends StatelessWidget {
  final Map<String, dynamic> orderScreenParameters;
  // Representative
  // 'representative': orderListParameters['representative']
  // 'uid': orderListParameters['uid'],
  // 'position': AppString.mainStrings['representative'],
  // 'orderType': AppString.representativeScreenStrings['new_orders'],
  // 'order': order,

  // Manager
  // 'manager': orderListParameters['manager'],
  // 'position': AppString.mainStrings['manager'],
  // 'orderType': AppString.managerScreenStrings['new_orders'],
  const OrderScreen({
    Key? key,
    required this.orderScreenParameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderEntity order = orderScreenParameters['order'];
    BlocProvider.of<UserCubit>(context)
        .getUserById(uid: order.representativeId!);
    return Scaffold(
      body: orderScreenParameters['position'] == AppString.mainStrings['manager']
          ?BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserLoaded) {
            return BackgroundEmpty(
              hasAppBarText: false,
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    primary: true,
                    iconTheme: const IconThemeData(color: normalTextColor),
                    toolbarHeight: 80.h,
                    titleTextStyle:
                        Styles.textStyleBold16(normalTextColor, context),
                    backgroundColor: backgroundColor,
                    title: Text(order.deviceName!),
                    centerTitle: true,
                  ),
                  SliverFixedExtentList(
                    delegate: SliverChildListDelegate([
                      _OrderItemBody(
                        constantTitle:
                            AppString.orderScreenStrings['client_name']!,
                        variableTitle: order.customerName!,
                        icon: AppIcon.orderClientNameIcon,
                      ),
                      _OrderItemBody(
                        constantTitle: AppString.orderScreenStrings['address']!,
                        variableTitle: order.customerAddress!,
                        icon: AppIcon.orderAddressIcon,
                      ),
                      _OrderItemBody(
                        constantTitle: AppString.orderScreenStrings['phone']!,
                        variableTitle: order.customerPhone!,
                        icon: AppIcon.orderPhoneIcon,
                      ),
                      _OrderItemBody(
                        constantTitle: AppString
                            .orderScreenStrings['representative_name']!,
                        variableTitle: userState.user['name'],
                        icon: AppIcon.representativesIcon,
                      ),
                      _OrderItemBody(
                        constantTitle:
                            AppString.orderScreenStrings['problem_type']!,
                        variableTitle: order.problemType!,
                        icon: AppIcon.orderProblemTypeIcon,
                      ),
                      _OrderItemBody(
                        constantTitle:
                            AppString.orderScreenStrings['register_date']!,
                        variableTitle: order.registrationDate!,
                        icon: AppIcon.orderRegisterDateIcon,
                      ),
                      if (orderScreenParameters['position'] ==
                          AppString.mainStrings['manager'])
                        _OrderItemActionManagerBody(
                          order: order,
                          status: 'Registered',
                          date: order.registrationDate!,
                          isChecked: true,
                          isFirst: true,
                        ),
                      if (orderScreenParameters['position'] ==
                          AppString.mainStrings['manager'] &&
                          (order.orderCheckedOrCheckoutStatus ==
                              AppString.orderScreenStrings['checked'] ||
                              order.orderCheckedOrCheckoutStatus ==
                                  AppString.orderScreenStrings['checkout']))
                        _OrderItemActionManagerBody(
                          order: order,
                          status: order.orderCheckedOrCheckoutStatus!,
                          date: order.orderCheckedOrCheckoutDate!,
                          isChecked: true,
                          isLast: order.orderFixedOrNotFixedStatus == null && order.orderDeliveredStatus == null? true: false,
                        ),
                      if (orderScreenParameters['position'] ==
                          AppString.mainStrings['manager'] &&
                          (order.orderFixedOrNotFixedStatus ==
                              AppString.orderScreenStrings['fixed'] ||
                              order.orderFixedOrNotFixedStatus ==
                                  AppString.orderScreenStrings['not_fixed']))
                        _OrderItemActionManagerBody(
                          order: order,
                          status: order.orderFixedOrNotFixedStatus!,
                          date: order.orderFixedOrNotFixedDate!,
                          isChecked: true,
                          isLast: order.orderDeliveredStatus == null? true: false,
                        ),
                      if (orderScreenParameters['position'] ==
                          AppString.mainStrings['manager'] &&
                          order.orderDeliveredStatus ==
                              AppString.orderScreenStrings['delivered'])
                        _OrderItemActionManagerBody(
                          order: order,
                          status: order.orderDeliveredStatus!,
                          date: order.orderDeliveredDate!,
                          isChecked: true,
                          isLast: true,
                        ),
                      if (orderScreenParameters['position'] ==
                              AppString.mainStrings['representative'] &&
                          (order.orderStatus ==
                                  AppString.orderScreenStrings['new'] ||
                              order.orderStatus ==
                                  AppString.orderScreenStrings['checkout'] ||
                              order.orderStatus ==
                                  AppString.orderScreenStrings['checked'] ||
                              order.orderStatus ==
                                  AppString.orderScreenStrings['fixed'] ||
                              order.orderStatus ==
                                  AppString.orderScreenStrings['not_fixed']))
                        AbsorbPointer(
                          absorbing: order.orderStatus ==
                                  AppString.orderScreenStrings['new']
                              ? false
                              : true,
                          child: _OrderItemActionFirstStageBody(
                            order: order,
                            orderStatus: order.orderStatus!,
                            firstTitle:
                                AppString.orderScreenStrings['checkout']!,
                            secondTitle:
                                AppString.orderScreenStrings['checked']!,
                            date: order.orderCheckedOrCheckoutDate!,
                          ),
                        ),
                      if (orderScreenParameters['position'] ==
                              AppString.mainStrings['representative'] &&
                          order.orderCheckedOrCheckoutStatus ==
                              AppString.orderScreenStrings['checked'])
                        _OrderItemActionSecondStageBody(
                          order: order,
                          orderStatus: orderScreenParameters['position'],
                          firstTitle: AppString.orderScreenStrings['fixed']!,
                          secondTitle:
                              AppString.orderScreenStrings['not_fixed']!,
                          date: order.orderFixedOrNotFixedDate!,
                        ),
                      if (orderScreenParameters['position'] ==
                              AppString.mainStrings['representative'] &&
                          (order.orderStatus ==
                                  AppString.orderScreenStrings['fixed'] ||
                              order.orderStatus ==
                                  AppString.orderScreenStrings['not_fixed'] ||
                              order.orderStatus ==
                                  AppString.orderScreenStrings['checkout']))
                        _OrderItemActionThirdStageBody(
                          repUser: orderScreenParameters['representative'],
                          order: order,
                          position: orderScreenParameters['position'],
                          date: order.orderDeliveredDate!,
                          price: 1500,
                        ),
                    ]),
                    itemExtent: 104.h,
                  ),
                ],
              ),
            );
          }
          return Container(
            height: double.infinity,
            width: double.infinity,
            color: backgroundColor,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      )
          :BackgroundEmpty(
        hasAppBarText: false,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              primary: true,
              iconTheme: const IconThemeData(color: normalTextColor),
              toolbarHeight: 80.h,
              titleTextStyle:
              Styles.textStyleBold16(normalTextColor, context),
              backgroundColor: backgroundColor,
              title: Text(order.deviceName!),
              centerTitle: true,
            ),
            SliverFixedExtentList(
              delegate: SliverChildListDelegate([
                _OrderItemBody(
                  constantTitle:
                  AppString.orderScreenStrings['client_name']!,
                  variableTitle: order.customerName!,
                  icon: AppIcon.orderClientNameIcon,
                ),
                _OrderItemBody(
                  constantTitle: AppString.orderScreenStrings['address']!,
                  variableTitle: order.customerAddress!,
                  icon: AppIcon.orderAddressIcon,
                ),
                _OrderItemBody(
                  constantTitle: AppString.orderScreenStrings['phone']!,
                  variableTitle: order.customerPhone!,
                  icon: AppIcon.orderPhoneIcon,
                ),
                _OrderItemBody(
                  constantTitle: AppString
                      .orderScreenStrings['representative_name']!,
                  variableTitle: orderScreenParameters['representative']['name'],
                  icon: AppIcon.representativesIcon,
                ),
                _OrderItemBody(
                  constantTitle:
                  AppString.orderScreenStrings['problem_type']!,
                  variableTitle: order.problemType!,
                  icon: AppIcon.orderProblemTypeIcon,
                ),
                _OrderItemBody(
                  constantTitle:
                  AppString.orderScreenStrings['register_date']!,
                  variableTitle: order.registrationDate!,
                  icon: AppIcon.orderRegisterDateIcon,
                ),
                if (orderScreenParameters['position'] ==
                    AppString.mainStrings['manager'])
                  _OrderItemActionManagerBody(
                    order: order,
                    status: 'Registered',
                    date: order.registrationDate!,
                    isChecked: true,
                    isFirst: true,
                  ),
                if (orderScreenParameters['position'] ==
                    AppString.mainStrings['manager'] &&
                    (order.orderCheckedOrCheckoutStatus ==
                        AppString.orderScreenStrings['checked'] ||
                        order.orderCheckedOrCheckoutStatus ==
                            AppString.orderScreenStrings['checkout']))
                  _OrderItemActionManagerBody(
                    order: order,
                    status: order.orderCheckedOrCheckoutStatus!,
                    date: order.orderCheckedOrCheckoutDate!,
                    isChecked: true,
                    isLast: order.orderFixedOrNotFixedStatus == null && order.orderDeliveredStatus == null? true: false,
                  ),
                if (orderScreenParameters['position'] ==
                    AppString.mainStrings['manager'] &&
                    (order.orderFixedOrNotFixedStatus ==
                        AppString.orderScreenStrings['fixed'] ||
                        order.orderFixedOrNotFixedStatus ==
                            AppString.orderScreenStrings['not_fixed']))
                  _OrderItemActionManagerBody(
                    order: order,
                    status: order.orderFixedOrNotFixedStatus!,
                    date: order.orderFixedOrNotFixedDate!,
                    isChecked: true,
                    isLast: order.orderDeliveredStatus == null? true: false,
                  ),
                if (orderScreenParameters['position'] ==
                    AppString.mainStrings['manager'] &&
                    order.orderDeliveredStatus ==
                        AppString.orderScreenStrings['delivered'])
                  _OrderItemActionManagerBody(
                    order: order,
                    status: order.orderDeliveredStatus!,
                    date: order.orderDeliveredDate!,
                    isChecked: true,
                    isLast: true,
                  ),
                if (orderScreenParameters['position'] ==
                    AppString.mainStrings['representative'] &&
                    (order.orderStatus ==
                        AppString.orderScreenStrings['new'] ||
                        order.orderStatus ==
                            AppString.orderScreenStrings['checkout'] ||
                        order.orderStatus ==
                            AppString.orderScreenStrings['checked'] ||
                        order.orderStatus ==
                            AppString.orderScreenStrings['fixed'] ||
                        order.orderStatus ==
                            AppString.orderScreenStrings['not_fixed']))
                  AbsorbPointer(
                    absorbing: order.orderStatus ==
                        AppString.orderScreenStrings['new']
                        ? false
                        : true,
                    child: _OrderItemActionFirstStageBody(
                      order: order,
                      orderStatus: order.orderStatus!,
                      firstTitle:
                      AppString.orderScreenStrings['checkout']!,
                      secondTitle:
                      AppString.orderScreenStrings['checked']!,
                      date: order.orderCheckedOrCheckoutDate!,
                    ),
                  ),
                if (orderScreenParameters['position'] ==
                    AppString.mainStrings['representative'] &&
                    order.orderCheckedOrCheckoutStatus ==
                        AppString.orderScreenStrings['checked'])
                  _OrderItemActionSecondStageBody(
                    order: order,
                    orderStatus: orderScreenParameters['position'],
                    firstTitle: AppString.orderScreenStrings['fixed']!,
                    secondTitle:
                    AppString.orderScreenStrings['not_fixed']!,
                    date: order.orderFixedOrNotFixedDate!,
                  ),
                if (orderScreenParameters['position'] ==
                    AppString.mainStrings['representative'] &&
                    (order.orderStatus ==
                        AppString.orderScreenStrings['fixed'] ||
                        order.orderStatus ==
                            AppString.orderScreenStrings['not_fixed'] ||
                        order.orderStatus ==
                            AppString.orderScreenStrings['checkout']))
                  _OrderItemActionThirdStageBody(
                    repUser: orderScreenParameters['representative'],
                    order: order,
                    position: orderScreenParameters['position'],
                    date: order.orderDeliveredDate!,
                    price: 1500,
                  ),
              ]),
              itemExtent: 104.h,
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemBody extends StatelessWidget {
  final String constantTitle;
  final String variableTitle;
  final Widget icon;
  const _OrderItemBody({
    Key? key,
    required this.constantTitle,
    required this.variableTitle,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
      child: ListTile(
        dense: false,
        horizontalTitleGap: 10.w,
        leading: SizedBox(
          width: 50.w,
          height: 50.h,
          child: FittedBox(
            fit: BoxFit.contain,
            child: icon,
          ),
        ),
        title: Text(
          constantTitle,
          style: Styles.textStyleBold16(normalTextColor, context),
        ),
        subtitle: Text(
          variableTitle,
          style: Styles.textStyle14(normalTextColor, context),
        ),
      ),
    );
  }
}

class _OrderItemActionFirstStageBody extends StatefulWidget {
  final String orderStatus;
  final String firstTitle;
  final String secondTitle;
  final String date;
  final OrderEntity order;
  const _OrderItemActionFirstStageBody({
    Key? key,
    required this.firstTitle,
    required this.secondTitle,
    required this.date,
    required this.orderStatus,
    required this.order,
  }) : super(key: key);

  @override
  State<_OrderItemActionFirstStageBody> createState() =>
      _OrderItemActionFirstStageBodyState();
}

class _OrderItemActionFirstStageBodyState
    extends State<_OrderItemActionFirstStageBody> {
  dynamic radioValue = AppString.orderScreenStrings['new'];
  @override
  Widget build(BuildContext context) {
    if (widget.order.orderStatus != AppString.orderScreenStrings['new']) {
      radioValue = widget.order.orderCheckedOrCheckoutStatus;
    }
    return Opacity(
      opacity: widget.order.orderCheckedOrCheckoutStatus ==
                  AppString.orderScreenStrings['checked'] ||
              widget.order.orderCheckedOrCheckoutStatus ==
                  AppString.orderScreenStrings['checkout']
          ? 0.5
          : 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: LinkedLabelRadio(
                label: widget.firstTitle,
                padding: EdgeInsets.zero,
                value: widget.firstTitle,
                groupValue: radioValue,
                onChanged: (dynamic newValue) {
                  setState(() {
                    radioValue = newValue;
                  });
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: LinkedLabelRadio(
                label: widget.secondTitle,
                padding: EdgeInsets.zero,
                value: widget.secondTitle,
                groupValue: radioValue,
                onChanged: (dynamic newValue) {
                  setState(() {
                    radioValue = newValue;
                  });
                },
              ),
            ),
            Expanded(
              flex: 7,
              child: defaultButton(
                height: 40.h,
                style: Styles.textStyle14(iconTextColor, context),
                radius: kRadius.r,
                text: 'Confirm',
                function: () {
                  if (radioValue == AppString.orderScreenStrings['new']) {
                    showToast(
                        text: 'please, select status',
                        state: ToastStates.ERROR);
                  } else {
                    BlocProvider.of<OrderCubit>(context).updateOrderStatus(
                        oid: widget.order.oId!,
                        field: 'orderCheckedOrCheckoutStatus',
                        value: radioValue);
                    BlocProvider.of<OrderCubit>(context).updateOrderStatus(
                        oid: widget.order.oId!,
                        field: 'orderStatus',
                        value: radioValue);
                    BlocProvider.of<OrderCubit>(context).updateOrderStatus(
                        oid: widget.order.oId!,
                        field: 'orderCheckedOrCheckoutDate',
                        value: DateFormat('dd MMM yyyy hh:mm a')
                            .format(DateTime.now()));
                    showToast(
                        text: 'order is ${radioValue.toString().toLowerCase()}',
                        state: ToastStates.SUCCESS);
                    GoRouter.of(context).go(AppRouter.kRepresentativeScreen,
                        extra: {
                          'uid': widget.order.representativeId,
                          'position': 'Representative'
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemActionSecondStageBody extends StatefulWidget {
  final String orderStatus;
  final String firstTitle;
  final String secondTitle;
  final String date;
  final OrderEntity order;
  const _OrderItemActionSecondStageBody({
    Key? key,
    required this.firstTitle,
    required this.secondTitle,
    required this.date,
    required this.orderStatus,
    required this.order,
  }) : super(key: key);

  @override
  State<_OrderItemActionSecondStageBody> createState() =>
      _OrderItemActionSecondStageBodyState();
}

class _OrderItemActionSecondStageBodyState
    extends State<_OrderItemActionSecondStageBody> {
  dynamic radioValue = AppString.orderScreenStrings['new'];
  @override
  Widget build(BuildContext context) {
    if (widget.order.orderStatus == AppString.orderScreenStrings['fixed'] ||
        widget.order.orderStatus == AppString.orderScreenStrings['not_fixed']) {
      radioValue = widget.order.orderFixedOrNotFixedStatus;
    }
    return Opacity(
      opacity: widget.order.orderFixedOrNotFixedStatus ==
                  AppString.orderScreenStrings['fixed'] ||
              widget.order.orderFixedOrNotFixedStatus ==
                  AppString.orderScreenStrings['not_fixed']
          ? 0.5
          : 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
        child: Row(
          children: [
            Expanded(
              flex: 10,
              child: LinkedLabelRadio(
                label: widget.firstTitle,
                padding: EdgeInsets.zero,
                value: widget.firstTitle,
                groupValue: radioValue,
                onChanged: (dynamic newValue) {
                  setState(() {
                    radioValue = newValue;
                  });
                },
              ),
            ),
            Expanded(
              flex: 10,
              child: LinkedLabelRadio(
                label: widget.secondTitle,
                padding: EdgeInsets.zero,
                value: widget.secondTitle,
                groupValue: radioValue,
                onChanged: (dynamic newValue) {
                  setState(() {
                    radioValue = newValue;
                  });
                },
              ),
            ),
            Expanded(
              flex: 7,
              child: defaultButton(
                height: 40.h,
                style: Styles.textStyle14(iconTextColor, context),
                radius: kRadius.r,
                text: 'Confirm',
                function: () {
                  if (radioValue == AppString.orderScreenStrings['new']) {
                    showToast(
                        text: 'please, select status',
                        state: ToastStates.ERROR);
                  } else {
                    BlocProvider.of<OrderCubit>(context).updateOrderStatus(
                        oid: widget.order.oId!,
                        field: 'orderFixedOrNotFixedStatus',
                        value: radioValue);
                    BlocProvider.of<OrderCubit>(context).updateOrderStatus(
                        oid: widget.order.oId!,
                        field: 'orderStatus',
                        value: radioValue);
                    BlocProvider.of<OrderCubit>(context).updateOrderStatus(
                        oid: widget.order.oId!,
                        field: 'orderFixedOrNotFixedDate',
                        value: DateFormat('dd MMM yyyy hh:mm a')
                            .format(DateTime.now()));
                    showToast(
                        text: 'order is ${radioValue.toString().toLowerCase()}',
                        state: ToastStates.SUCCESS);
                    GoRouter.of(context).go(AppRouter.kRepresentativeScreen,
                        extra: {
                          'uid': widget.order.representativeId,
                          'position': 'Representative'
                        });
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OrderItemActionThirdStageBody extends StatefulWidget {
  final Map<String, dynamic> repUser;
  final OrderEntity order;
  final String position;
  final String date;
  final num price;
  const _OrderItemActionThirdStageBody({
    Key? key,
    required this.date,
    required this.price,
    required this.position,
    required this.order,
    required this.repUser,
  }) : super(key: key);

  @override
  State<_OrderItemActionThirdStageBody> createState() =>
      _OrderItemActionThirdStageBodyState();
}

class _OrderItemActionThirdStageBodyState
    extends State<_OrderItemActionThirdStageBody> {
  var priceController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  bool? isChecked = false;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context)
        .getUserById(uid: widget.order.secretaryId!);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
            child: AbsorbPointer(
              absorbing: widget.position == AppString.mainStrings['manager']
                  ? true
                  : false,
              child: Row(
                children: [
                  Expanded(
                    child: CheckboxListTile(
                      contentPadding: EdgeInsets.zero,
                      dense: true,
                      visualDensity: VisualDensity.compact,
                      value: isChecked,
                      title: Text(
                        'Delivered',
                        style: Styles.textStyle14(normalTextColor, context),
                      ),
                      onChanged: (value) {
                        setState(() {
                          isChecked = value;
                        });
                      },
                    ),
                  ),
                  widget.position == AppString.mainStrings['manager']
                      ? Expanded(
                          child: Center(
                            child: Text(
                              'Paid: ${widget.price} E£',
                              style: Styles.textStyle14(iconTextColor, context,
                                  background: Paint()
                                    ..strokeWidth = 27.0.w
                                    ..color = Colors.green
                                    ..style = PaintingStyle.stroke
                                    ..strokeJoin = StrokeJoin.round),
                            ),
                          ),
                        )
                      : Form(
                          key: formKey,
                          child: Expanded(
                            child: Center(
                              child: defaultTextFormField(
                                label: 'price',
                                controller: priceController,
                                type: TextInputType.number,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'no price put';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                        ),
                  widget.position == AppString.mainStrings['manager']
                      ? Expanded(
                          child: FittedBox(
                            child: Text(
                              '- ${widget.date}',
                              style:
                                  Styles.textStyle12(normalTextColor, context),
                            ),
                          ),
                        )
                      : Expanded(
                          child: defaultButton(
                            height: 40.h,
                            style: Styles.textStyle14(iconTextColor, context),
                            radius: kRadius.r,
                            text: 'Confirm',
                            function: () {
                              if (formKey.currentState!.validate() &&
                                  isChecked == true) {
                                updateUserOrder(
                                    uId: userState.user['uId'],
                                    field: 'currentOrders',
                                    value: userState.user['currentOrders'] - 1);
                                updateUserOrder(
                                    uId: widget.repUser['uId'],
                                    field: 'currentOrders',
                                    value: widget.repUser['currentOrders'] - 1);
                                updateUserOrder(
                                    uId: userState.user['uId'],
                                    field: 'finishedOrders',
                                    value:
                                        userState.user['finishedOrders'] + 1);
                                updateUserOrder(
                                    uId: widget.repUser['uId'],
                                    field: 'finishedOrders',
                                    value:
                                        widget.repUser['finishedOrders'] + 1);
                                BlocProvider.of<OrderCubit>(context)
                                    .updateOrderStatus(
                                        oid: widget.order.oId!,
                                        field: 'orderDeliveredStatus',
                                        value: AppString
                                            .orderScreenStrings['delivered']!);
                                BlocProvider.of<OrderCubit>(context)
                                    .updateOrderStatus(
                                        oid: widget.order.oId!,
                                        field: 'orderStatus',
                                        value: AppString
                                            .orderScreenStrings['delivered']!);
                                BlocProvider.of<OrderCubit>(context)
                                    .updateOrderStatus(
                                        oid: widget.order.oId!,
                                        field: 'orderDeliveredDate',
                                        value: DateFormat('dd MMM yyyy hh:mm a')
                                            .format(DateTime.now()));
                                BlocProvider.of<OrderCubit>(context)
                                    .updateOrderStatus(
                                        oid: widget.order.oId!,
                                        field: 'price',
                                        value: priceController.text);
                                showToast(
                                    text: 'order is delivered',
                                    state: ToastStates.SUCCESS);
                                GoRouter.of(context).go(
                                    AppRouter.kRepresentativeScreen,
                                    extra: {
                                      'uid': widget.order.representativeId,
                                      'position': 'Representative'
                                    });
                              }
                              if (isChecked == false) {
                                showToast(
                                    text: 'please, select status',
                                    state: ToastStates.ERROR);
                              }
                            },
                          ),
                        ),
                ],
              ),
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
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

class _OrderItemActionManagerBody extends StatefulWidget {
  final bool isFirst;
  final bool isLast;
  final bool isChecked;
  final String status;
  final String date;
  final OrderEntity order;
  const _OrderItemActionManagerBody({
    Key? key,
    required this.order,
    required this.status,
    required this.date,
    required this.isChecked,
    this.isFirst = false,
    this.isLast = false,
  }) : super(key: key);

  @override
  State<_OrderItemActionManagerBody> createState() =>
      _OrderItemActionManagerBodyState();
}

class _OrderItemActionManagerBodyState
    extends State<_OrderItemActionManagerBody> {
  @override
  Widget build(BuildContext context) {
    Color? color = Colors.grey;
    if (widget.isChecked == true) {
      setState(() {
        color = Colors.green[700];
      });
    }
    return TimelineTile(
      alignment: TimelineAlign.manual,
      lineXY: 0.1,
      isFirst: widget.isFirst,
      isLast: widget.isLast,
      indicatorStyle: IndicatorStyle(
        width: 25.w,
        color: color!,
        padding: EdgeInsets.only(right: 16.w, left: 20.w),
      ),
      endChild: RichText(
        text: TextSpan(
          text: '${widget.status}\n',
          style: Styles.textStyle16(normalTextColor, context),
          children: [
            TextSpan(
              text: widget.date,
              style: Styles.textStyle14(normalTextColor, context),
            ),
          ],
        ),
      ),
      afterLineStyle: LineStyle(color: color!),
      beforeLineStyle: LineStyle(color: color!),
    );
  }
}
