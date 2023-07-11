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

class OrderListScreen extends StatelessWidget {
  final Map<String, dynamic> orderListParameters;
  // Secretary
  // 'secretary': secretaryParameter['user'],
  // 'uid': secretaryParameter['uid'],
  // 'position': AppString.mainStrings['secretary'],
  // 'orderType': AppString.secretaryScreenStrings['modify_order'],

  // Representative
  // 'representative': representativeParameter['user']
  // 'uid': representativeParameter['uid'],
  // 'position': AppString.mainStrings['representative'],
  // 'orderType': AppString.representativeScreenStrings['new_orders'],

  // Manager
  // 'manager': managerParameter['user'],
  // 'position': AppString.mainStrings['manager'],
  // 'orderType': AppString.managerScreenStrings['new_orders'],

  const OrderListScreen({
    Key? key,
    required this.orderListParameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<OrderEntity> orders = [];
    return Scaffold(
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, orderState) {
          if (orderState is OrderLoaded) {
            if (orderListParameters['orderType'] ==
                AppString.representativeScreenStrings['new_orders']) {
              orders.clear();
              for (var element in orderState.orders) {
                if (element.orderStatus !=
                    AppString.orderScreenStrings['delivered']) {
                  orders.add(element);
                }
              }
            } else if (orderListParameters['orderType'] ==
                AppString.representativeScreenStrings['delivered_orders']) {
              orders.clear();
              for (var element in orderState.orders) {
                if (element.orderStatus ==
                    AppString.orderScreenStrings['delivered']) {
                  orders.add(element);
                }
              }
            } else if (orderListParameters['orderType'] ==
                AppString.secretaryScreenStrings['modify_order']) {
              orders.clear();
              for (var element in orderState.orders) {
                if (element.orderStatus ==
                    AppString.orderScreenStrings['new']) {
                  orders.add(element);
                }
              }
            } else if (orderListParameters['orderType'] ==
                    AppString.managerScreenStrings['new_orders'] &&
                orderListParameters['position'] ==
                    AppString.mainStrings['manager']) {
              orders.clear();
              for (var element in orderState.orders) {
                orders.add(element);
              }
            } else if (orderListParameters['orderType'] ==
                    AppString.managerScreenStrings['checkout_orders'] &&
                orderListParameters['position'] ==
                    AppString.mainStrings['manager']) {
              orders.clear();
              for (var element in orderState.orders) {
                orders.add(element);
              }
            } else if (orderListParameters['orderType'] ==
                    AppString.managerScreenStrings['delivered_orders'] &&
                orderListParameters['position'] ==
                    AppString.mainStrings['manager']) {
              orders.clear();
              for (var element in orderState.orders) {
                orders.add(element);
              }
            } else if (orderListParameters['orderType'] ==
                    AppString.managerScreenStrings['checked_orders'] &&
                orderListParameters['position'] ==
                    AppString.mainStrings['manager']) {
              orders.clear();
              for (var element in orderState.orders) {
                orders.add(element);
              }
            }

            return BackgroundEmpty(
              hasAppBarText: false,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    primary: true,
                    iconTheme: const IconThemeData(color: normalTextColor),
                    toolbarHeight: 80.h,
                    titleTextStyle:
                        Styles.textStyleBold16(normalTextColor, context),
                    backgroundColor: backgroundColor,
                    pinned: true,
                    title: Text('Orders: ${orders.length}'),
                    centerTitle: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        if (orderListParameters['position'] ==
                            AppString.mainStrings['secretary']) {
                          return _OrderListViewItemSecretary(
                            orderListParameters: orderListParameters,
                            order: orders[index],
                          );
                        } else if (orderListParameters['position'] ==
                            AppString.mainStrings['representative']) {
                          return _OrderListViewItemRepresentative(
                            orderListParameters: orderListParameters,
                            order: orders[index],
                          );
                        } else if (orderListParameters['position'] ==
                            AppString.mainStrings['manager']) {
                          return _OrderListViewItemManager(
                            orderListParameters: orderListParameters,
                            order: orders[index],
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      },
                      childCount: orders.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _OrderListViewItemSecretary extends StatelessWidget {
  final Map<String, dynamic> orderListParameters;
  final OrderEntity order;
  const _OrderListViewItemSecretary({
    Key? key,
    required this.orderListParameters,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context)
        .getNameById(uid: order.representativeId!);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(kRadius.r)),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).push(
                    AppRouter.kCreateOrderScreen,
                    extra: {
                      'representative': userState.user,
                      'secretary': orderListParameters['secretary'],
                      'uid': orderListParameters['uid'],
                      'position': AppString.mainStrings['secretary'],
                      'orderType':
                          AppString.secretaryScreenStrings['modify_order'],
                      'order': order,
                    },
                  );
                },
                child: SizedBox(
                  height: 130.h,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 17.w,
                      ),
                      Image(
                        image: ResizeImage(
                          AssetImage(getDeviceIcon(deviceName: order.deviceName!)),
                          width: 102.w.toInt(),
                          height: 102.h.toInt(),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              order.deviceName!,
                              style: Styles.textStyleBold16(
                                normalTextColor,
                                context,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.1.h,
                            ),
                            Text(
                              userState.user['name'],
                              style:
                                  Styles.textStyle14(normalTextColor, context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.1.h,
                            ),
                            Text(
                              order.customerAddress!,
                              style:
                                  Styles.textStyle14(normalTextColor, context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return myShimmer(
          height: 130.h,
          verticalPadding: 10.0.h,
          horizontalPadding: 20.w,
        );
      },
    );
  }
}

class _OrderListViewItemRepresentative extends StatelessWidget {
  final Map<String, dynamic> orderListParameters;
  final OrderEntity order;
  const _OrderListViewItemRepresentative({
    Key? key,
    required this.orderListParameters,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context)
        .getNameById(uid: order.representativeId!);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(kRadius.r)),
              elevation: 5,
              child: AbsorbPointer(
                absorbing: order.orderStatus ==
                        AppString.orderScreenStrings['delivered']
                    ? true
                    : false,
                child: InkWell(
                  onTap: () {
                    GoRouter.of(context).push(
                      AppRouter.kOrderScreen,
                      extra: {
                        'uid': orderListParameters['uid'],
                        'position': AppString.mainStrings['representative'],
                        'orderType':
                            AppString.representativeScreenStrings['new_orders'],
                        'order': order,
                        'repName': orderListParameters['repName'],
                        'representative': orderListParameters['representative'],
                      },
                    );
                  },
                  child: SizedBox(
                    height: 130.h,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 17.w,
                        ),
                        Image(
                          image: ResizeImage(
                            AssetImage(getDeviceIcon(deviceName: order.deviceName!)),
                            width: 102.w.toInt(),
                            height: 102.h.toInt(),
                          ),
                        ),
                        SizedBox(
                          width: 30.w,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                order.deviceName!,
                                style: Styles.textStyleBold16(
                                  normalTextColor,
                                  context,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 10.1.h,
                              ),
                              if (order.orderStatus ==
                                  AppString.orderScreenStrings['new'])
                                Text(
                                  order.orderStatus!.toUpperCase(),
                                  style:
                                      Styles.textStyle14(Colors.red, context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (order.orderStatus ==
                                  AppString.orderScreenStrings['checked'])
                                Text(
                                  order.orderStatus!.toUpperCase(),
                                  style:
                                      Styles.textStyle14(Colors.amber, context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (order.orderStatus ==
                                      AppString.orderScreenStrings['fixed'] ||
                                  order.orderStatus ==
                                      AppString.orderScreenStrings['checkout'])
                                Text(
                                  order.orderStatus!.toUpperCase(),
                                  style:
                                      Styles.textStyle14(Colors.green, context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (order.orderStatus ==
                                  AppString.orderScreenStrings['not_fixed'])
                                Text(
                                  order.orderStatus!.toUpperCase(),
                                  style: Styles.textStyle14(
                                      Colors.purple, context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (order.orderStatus ==
                                  AppString.orderScreenStrings['delivered'])
                                Text(
                                  order.orderStatus!.toUpperCase(),
                                  style: Styles.textStyle14(
                                      Colors.greenAccent, context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (order.orderStatus ==
                                  AppString.orderScreenStrings['delivered'])
                                Text(
                                  'Price: ${order.price!} EGP',
                                  style: Styles.textStyle14(
                                      Colors.black54, context),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              if (order.orderStatus !=
                                  AppString.orderScreenStrings['delivered'])
                                SizedBox(
                                  height: 10.1.h,
                                ),
                              Text(
                                order.customerAddress!,
                                style: Styles.textStyle14(
                                    normalTextColor, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        return myShimmer(
          height: 130.h,
          verticalPadding: 10.0.h,
          horizontalPadding: 20.w,
        );
      },
    );
  }
}

class _OrderListViewItemManager extends StatelessWidget {
  final Map<String, dynamic> orderListParameters;
  final OrderEntity order;
  const _OrderListViewItemManager({
    Key? key,
    required this.orderListParameters,
    required this.order,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context)
        .getNameById(uid: order.representativeId!);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
            child: Material(
              borderRadius: BorderRadius.all(Radius.circular(kRadius.r)),
              elevation: 5,
              child: InkWell(
                onTap: () {
                  GoRouter.of(context).push(
                    AppRouter.kOrderScreen,
                    extra: {
                      'manager': orderListParameters['manager'],
                      'position': AppString.mainStrings['manager'],
                      'orderType': AppString.managerScreenStrings['new_orders'],
                      'order': order,
                    },
                  );
                },
                child: SizedBox(
                  height: 130.h,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 17.w,
                      ),
                      Image(
                        image: ResizeImage(
                          AssetImage(getDeviceIcon(deviceName: order.deviceName!)),
                          width: 102.w.toInt(),
                          height: 102.h.toInt(),
                        ),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              order.deviceName!,
                              style: Styles.textStyleBold16(
                                normalTextColor,
                                context,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 10.1.h,
                            ),
                            if (order.orderStatus ==
                                AppString.orderScreenStrings['new'])
                              Text(
                                order.orderStatus!.toUpperCase(),
                                style: Styles.textStyle14(Colors.red, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (order.orderStatus ==
                                AppString.orderScreenStrings['checked'])
                              Text(
                                order.orderStatus!.toUpperCase(),
                                style:
                                    Styles.textStyle14(Colors.amber, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (order.orderStatus ==
                                    AppString.orderScreenStrings['fixed'] ||
                                order.orderStatus ==
                                    AppString.orderScreenStrings['checkout'])
                              Text(
                                order.orderStatus!.toUpperCase(),
                                style:
                                    Styles.textStyle14(Colors.green, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (order.orderStatus ==
                                AppString.orderScreenStrings['not_fixed'])
                              Text(
                                order.orderStatus!.toUpperCase(),
                                style:
                                    Styles.textStyle14(Colors.purple, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (order.orderStatus ==
                                AppString.orderScreenStrings['delivered'])
                              Text(
                                '${order.orderStatus!.toUpperCase()} ${order.orderFixedOrNotFixedStatus ?? ''}',
                                style: Styles.textStyle14(
                                    Colors.greenAccent, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            if (order.orderStatus ==
                                AppString.orderScreenStrings['delivered'])
                              Text(
                                'Price: ${order.price} EGP',
                                style:
                                    Styles.textStyle14(Colors.black54, context),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            Text(
                              order.customerAddress!,
                              style:
                                  Styles.textStyle14(normalTextColor, context),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        return myShimmer(
          height: 130.h,
          verticalPadding: 10.0.h,
          horizontalPadding: 20.w,
        );
      },
    );
  }
}

String getDeviceIcon({required String deviceName}) {
  String result = '';
  switch (deviceName) {
    case 'Microwave':
      result = 'assets/images/microwave.png';
      break;
    case 'Deep Freezer':
      result = 'assets/images/deep_freezer.png';
      break;
    case 'Refrigerator':
      result = 'assets/images/refrigerator.png';
      break;
    case 'Washing Machine':
      result = 'assets/images/washing_machine.png';
      break;
  }
  return result;
}
