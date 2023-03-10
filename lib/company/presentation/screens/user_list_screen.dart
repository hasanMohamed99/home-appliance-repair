import 'package:company/company/domain/entities/order_entity.dart';
import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/order/order_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/services/notification_service.dart';
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

class UserListScreen extends StatefulWidget {
  final Map<String, dynamic> userListParameters;
  // Secretary
  // 'secretary': secretaryParameter['user']
  // 'uid': widget.createOrderParameters['uid'],
  // 'position': AppString.mainStrings['secretary'],
  // 'representative_list': 'Representative List',

  // Manager
  // 'position': AppString.mainStrings['manager'],
  // 'screenType': AppString.managerScreenStrings['delete_account'],
  const UserListScreen({
    Key? key,
    required this.userListParameters,
  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  Widget build(BuildContext context) {
    List<UserEntity> users = [];
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UsersLoaded) {
            if (widget.userListParameters['position'] ==
                    AppString.mainStrings['manager'] &&
                widget.userListParameters['screenType'] ==
                    AppString.managerScreenStrings['secretary']) {
              for (var element in userState.users) {
                if (element.position == 'secretary') users.add(element);
              }
            }
            if (widget.userListParameters['position'] ==
                    AppString.mainStrings['manager'] &&
                widget.userListParameters['screenType'] ==
                    AppString.managerScreenStrings['representative']) {
              for (var element in userState.users) {
                if (element.position == 'representative') users.add(element);
              }
            }

            if (widget.userListParameters['position'] ==
                AppString.mainStrings['manager']) {
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
                      title: Text(widget.userListParameters['screenType'] ==
                          AppString.managerScreenStrings['secretary']?
                          'Secretary list': 'Representative list'),
                      centerTitle: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _UsersListViewItemManager(
                            user: users[index],
                          );
                        },
                        childCount: users.length,
                      ),
                    ),
                  ],
                ),
              );
            }else{
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
                      title:
                      Text(widget.userListParameters['representative_list']),
                      centerTitle: true,
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          return _UsersListViewItem(
                            secretary: widget.userListParameters['secretary'],
                            order: widget.userListParameters['order'],
                            user: userState.users[index],
                            position: widget.userListParameters['position'],
                          );
                        },
                        childCount: userState.users.length,
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _UsersListViewItem extends StatefulWidget {
  final Map<String, dynamic> order;
  final Map<String, dynamic>? secretary;
  final UserEntity user;
  final String position;
  const _UsersListViewItem({
    Key? key,
    required this.user,
    required this.position,
    required this.order,
    required this.secretary,
  }) : super(key: key);

  @override
  State<_UsersListViewItem> createState() => _UsersListViewItemState();
}

class _UsersListViewItemState extends State<_UsersListViewItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(kRadius.r)),
        elevation: 5,
        child: AbsorbPointer(
          absorbing: widget.position == AppString.loginScreenStrings['manager']
              ? true
              : false,
          child: InkWell(
            borderRadius: BorderRadius.all(Radius.circular(kRadius.r)),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => SimpleDialog(
                  title: Text(
                    'Confirm your selection',
                    style: Styles.textStyle16(normalTextColor, context),
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
                                      uId: widget.user.uId!,
                                      field: 'currentOrders',
                                      value: widget.user.currentOrders! + 1);
                                  updateUserOrder(
                                      uId: widget.order['secretaryId'],
                                      field: 'currentOrders',
                                      value:
                                          widget.secretary!['currentOrders'] +
                                              1);
                                  BlocProvider.of<OrderCubit>(context).addOrder(
                                    order: OrderEntity(
                                      deviceName: widget.order['deviceName'],
                                      customerName:
                                          widget.order['customerName'],
                                      customerAddress:
                                          widget.order['customerAddress'],
                                      customerPhone:
                                          widget.order['customerPhone'],
                                      orderStatus: 'new',
                                      problemType: widget.order['problemType'],
                                      registrationDate:
                                          widget.order['registrationDate'],
                                      secretaryId: widget.order['secretaryId'],
                                      representativeId: widget.user.uId,
                                      orderCheckedOrCheckoutDate: '',
                                      orderFixedOrNotFixedDate: '',
                                      orderDeliveredDate: '',
                                    ),
                                  );
                                  Navigator.pop(context);
                                  showToast(
                                      text: 'order sent successfully ',
                                      state: ToastStates.SUCCESS);
                                  widget.secretary!['currentOrders'] += 1;
                                  sendPushMessage(
                                    token: widget.user.deviceToken!,
                                    body: 'You have New Order from ${widget.secretary!['name']}',
                                    title: 'New Order',
                                  );
                                  GoRouter.of(context)
                                      .go(AppRouter.kSecretaryScreen, extra: {
                                    'uid': widget.order['secretaryId'],
                                    'position': 'Secretary',
                                    'user': widget.secretary,
                                  });
                                },
                                text: 'Confirm')),
                      ],
                    ),
                  ],
                ),
              );
            },
            child: SizedBox(
              height: 90.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 15.w,
                  ),
                  SizedBox(
                    width: 62.w,
                    height: 62.h,
                    child: AppIcon.profileIcon,
                  ),
                  SizedBox(
                    width: 30.w,
                  ),
                  Expanded(
                    child: ListTile(
                      dense: false,
                      horizontalTitleGap: 10.w,
                      title: Text(
                        widget.user.name!,
                        style: Styles.textStyleBold16(normalTextColor, context),
                      ),
                      subtitle: Text(
                        widget.position ==
                                AppString.loginScreenStrings['manager']
                            ? '${widget.position} \nFinished Orders: ${widget.user.finishedOrders}'
                            : 'Current Orders: ${widget.user.currentOrders}',
                        style: Styles.textStyle14(normalTextColor, context),
                      ),
                      isThreeLine: true,
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

  void updateUserOrder({
    required String uId,
    required String field,
    required int value,
  }) {
    BlocProvider.of<UserCubit>(context)
        .updateUserOrder(uId: uId, field: field, value: value);
  }
}

class _UsersListViewItemManager extends StatefulWidget {
  final UserEntity user;
  const _UsersListViewItemManager({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<_UsersListViewItemManager> createState() =>
      _UsersListViewItemManagerState();
}

class _UsersListViewItemManagerState extends State<_UsersListViewItemManager> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(kRadius.r)),
        elevation: 5,
        child: SizedBox(
          height: 120.h,
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              SizedBox(
                width: 62.w,
                height: 62.h,
                child: AppIcon.profileIcon,
              ),
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: ListTile(
                  dense: false,
                  horizontalTitleGap: 10.w,
                  title: Text(
                    widget.user.name!.capitalize(),
                    style: Styles.textStyleBold16(normalTextColor, context),
                  ),
                  subtitle: Text(
                    '${widget.user.position} \nFinished Orders: ${widget.user.finishedOrders}'
                    '\nCurrent Orders: ${widget.user.currentOrders}',
                    style: Styles.textStyle14(normalTextColor, context),
                  ),
                  isThreeLine: true,
                ),
              ),
            ],
          ),
        ),
      ),
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
