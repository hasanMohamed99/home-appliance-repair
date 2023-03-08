import 'package:carousel_slider/carousel_slider.dart';
import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/auth/auth_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/utils/app_icons.dart';
import 'package:company/core/utils/app_router.dart';
import 'package:company/core/utils/app_strings.dart';
import 'package:company/core/utils/background_top.dart';
import 'package:company/core/utils/colors.dart';
import 'package:company/core/utils/app_constants.dart';
import 'package:company/core/utils/styles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../domain/entities/user_entity.dart';
import '../controller/order/order_cubit.dart';

class ManagerScreen extends StatefulWidget {
  final Map<String, dynamic> managerParameter;
  //{'uid':authState.uid,'position': 'Manager','user': authState.user}
  const ManagerScreen({Key? key, required this.managerParameter})
      : super(key: key);

  @override
  State<ManagerScreen> createState() => _ManagerScreenState();
}

class _ManagerScreenState extends State<ManagerScreen> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundTop(
        hasAppBarText: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 180.h,
            ),
            Text(
              widget.managerParameter['position'],
              style: Styles.textStyleBold24(mainColor, context),
            ),
            SizedBox(
              height: 60.h,
            ),
            CarouselSlider(
              items: [
                ManagerOrdersScreenBody(
                  managerParameter: widget.managerParameter,
                ),
                ManagerAddUserScreenBody(
                  managerParameter: widget.managerParameter,
                ),
                ManagerShowEmployeesScreenBody(
                  managerParameter: widget.managerParameter,
                ),
              ],
              options: CarouselOptions(
                aspectRatio: 171.w / 180.h,
                initialPage: selectedIndex,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  carouselNavChange(index);
                },
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            AnimatedSmoothIndicator(
              activeIndex: selectedIndex,
              count: 3,
              effect: ScrollingDotsEffect(
                activeDotColor: mainColor,
                spacing: 15.w,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void carouselNavChange(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
}

class ManagerOrdersScreenBody extends StatelessWidget {
  final Map<String, dynamic> managerParameter;
  const ManagerOrdersScreenBody({Key? key, required this.managerParameter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomCard> cards = [
      CustomCard(
        title: AppString.managerScreenStrings['new_orders']!,
        icon: AppIcon.newOrderIcon,
        function: () {
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'orderStatus',
              value: AppString.orderScreenStrings['new']!);
          GoRouter.of(context).push(AppRouter.kOrderListViewScreen, extra: {
            'manager': managerParameter['user'],
            'position': AppString.mainStrings['manager'],
            'orderType': AppString.managerScreenStrings['new_orders'],
          });
        },
      ),
      CustomCard(
        title: AppString.managerScreenStrings['checked_orders']!,
        icon: AppIcon.checkedOrdersIcon,
        function: () {
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'orderStatus',
              value: AppString.orderScreenStrings['checked']!);
          GoRouter.of(context).push(AppRouter.kOrderListViewScreen, extra: {
            'manager': managerParameter['user'],
            'position': AppString.mainStrings['manager'],
            'orderType': AppString.managerScreenStrings['checked_orders'],
          });
        },
      ),
      CustomCard(
        title: AppString.managerScreenStrings['delivered_orders']!,
        icon: AppIcon.deliveredOrdersIcon,
        function: () {
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'orderStatus',
              value: AppString.orderScreenStrings['delivered']!);
          GoRouter.of(context).push(AppRouter.kOrderListViewScreen, extra: {
            'manager': managerParameter['user'],
            'position': AppString.mainStrings['manager'],
            'orderType': AppString.managerScreenStrings['delivered_orders'],
          });
        },
      ),
      CustomCard(
        title: AppString.managerScreenStrings['checkout_orders']!,
        icon: AppIcon.checkoutOrdersIcon,
        function: () {
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'orderStatus',
              value: AppString.orderScreenStrings['checkout']!);
          GoRouter.of(context).push(AppRouter.kOrderListViewScreen, extra: {
            'manager': managerParameter['user'],
            'position': AppString.mainStrings['manager'],
            'orderType': AppString.managerScreenStrings['checkout_orders'],
          });
        },
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kManagerOrdersPadding.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 2,
        crossAxisSpacing: 20.w,
        mainAxisSpacing: 20.h,
        childAspectRatio: 171.w / 180.h,
        children: List.generate(
          cards.length,
          (index) => cards[index],
        ),
      ),
    );
  }
}

class ManagerAddUserScreenBody extends StatelessWidget {
  final Map<String, dynamic> managerParameter;
  const ManagerAddUserScreenBody({Key? key, required this.managerParameter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomCard> cards = [
      CustomCard(
        title: AppString.managerScreenStrings['add_account']!,
        icon: AppIcon.addAccountIcon,
        function: () {
          GoRouter.of(context).push(AppRouter.kCreateUserScreen, extra: {
            'position': AppString.mainStrings['manager'],
            'screenType': AppString.managerScreenStrings['add_account'],
          });
        },
      ),
      CustomCard(
        title: AppString.managerScreenStrings['delete_account']!,
        icon: AppIcon.modifyAccountIcon,
        function: () {
          // BlocProvider.of<UserCubit>(context).getUsers();
          // GoRouter.of(context).push(AppRouter.kModifyUserListViewScreen,
          //     extra: {
          //       'position': AppString.mainStrings['manager'],
          //       'screenType': AppString.managerScreenStrings['delete_account'],
          //     });
        },
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kManagerAddUserPadding.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        mainAxisSpacing: 20.h,
        childAspectRatio: 180.w / 140.h,
        children: List.generate(
          cards.length,
          (index) => cards[index],
        ),
      ),
    );
  }
}

class ManagerShowEmployeesScreenBody extends StatelessWidget {
  final Map<String, dynamic> managerParameter;
  const ManagerShowEmployeesScreenBody(
      {Key? key, required this.managerParameter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomCard> cards = [
      CustomCard(
        title: AppString.managerScreenStrings['secretary']!,
        icon: AppIcon.secretaryIcon,
        function: () {
          BlocProvider.of<UserCubit>(context).getUsers();
          GoRouter.of(context).push(
            AppRouter.kUserListViewScreen,
            extra: {
              'position': AppString.mainStrings['manager'],
              'screenType': AppString.managerScreenStrings['secretary'],
            },
          );
        },
      ),
      CustomCard(
        title: AppString.managerScreenStrings['representative']!,
        icon: AppIcon.representativeIcon,
        function: () {
          BlocProvider.of<UserCubit>(context).getUsers();
          GoRouter.of(context).push(
            AppRouter.kUserListViewScreen,
            extra: {
              'position': AppString.mainStrings['manager'],
              'screenType': AppString.managerScreenStrings['representative'],
            },
          );
        },
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kManagerAddUserPadding.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        mainAxisSpacing: 20.h,
        childAspectRatio: 180.w / 140.h,
        children: List.generate(
          cards.length,
          (index) => cards[index],
        ),
      ),
    );
  }
}
