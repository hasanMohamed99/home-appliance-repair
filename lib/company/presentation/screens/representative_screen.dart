import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/order/order_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/utils/app_icons.dart';
import 'package:company/core/utils/app_router.dart';
import 'package:company/core/utils/app_strings.dart';
import 'package:company/core/utils/background_main.dart';
import 'package:company/core/utils/colors.dart';
import 'package:company/core/utils/app_constants.dart';
import 'package:company/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RepresentativeScreen extends StatelessWidget {
  final Map<String, dynamic> representativeParameter; //{'uid':authState.uid,'position': 'Representative','user': authState.user}
  const RepresentativeScreen({Key? key, required this.representativeParameter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UserCubit>(context)
        .getUserById(uid: representativeParameter['uid']);
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, userState) {
        if (userState is UserLoaded) {
          return Scaffold(
            body: BackgroundMain(
              hasAppBarText: true,
              position: representativeParameter['position'],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppString.mainStrings['representative']!,
                    style: Styles.textStyleBold24(mainColor, context),
                  ),
                  SizedBox(
                    height: 40.h,
                  ),
                  RepresentativeScreenBody(
                    representativeParameter: userState.user,
                    repName:userState.user['name'],
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
}

class RepresentativeScreenBody extends StatelessWidget {
  final Map<String, dynamic> representativeParameter;
  final String repName;
  const RepresentativeScreenBody(
      {Key? key, required this.representativeParameter, required this.repName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomCard> cards = [
      CustomCard(
        title: AppString.representativeScreenStrings['new_orders']!,
        icon: AppIcon.representativeNewOrderIcon,
        function: () {
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'representativeId', value: representativeParameter['uId']);
          GoRouter.of(context).push(AppRouter.kOrderListViewScreen, extra: {
            'uid': representativeParameter['uId'],
            'position': AppString.mainStrings['representative'],
            'orderType': AppString.representativeScreenStrings['new_orders'],
            'repName': repName,
            'representative': representativeParameter,
          });
        },
      ),
      CustomCard(
        title: AppString.representativeScreenStrings['delivered_orders']!,
        icon: AppIcon.representativeDoneOrderIcon,
        function: () {
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'orderStatus', value: AppString.orderScreenStrings['delivered']!);
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'representativeId', value: representativeParameter['uId']);
          GoRouter.of(context).push(AppRouter.kOrderListViewScreen, extra: {
            'uid': representativeParameter['uId'],
            'position': AppString.mainStrings['representative'],
            'orderType': AppString.representativeScreenStrings['delivered_orders'],
            'repName': repName,
          });
        },
      ),
    ];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kSecretaryPadding.w),
      child: GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 1,
        mainAxisSpacing: 20.h,
        childAspectRatio: 170.w / 140.h,
        children: List.generate(
          cards.length,
          (index) => cards[index],
        ),
      ),
    );
  }
}
