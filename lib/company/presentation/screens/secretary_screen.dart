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

class SecretaryScreen extends StatelessWidget {
  final Map<String, dynamic>
  secretaryParameter; //{'uid':authState.uid,'position': 'Secretary', 'user': authState.user }
  const SecretaryScreen({Key? key, required this.secretaryParameter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundMain(
        hasAppBarText: true,
        position: secretaryParameter['position'],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${secretaryParameter['position']}:',
              style: Styles.textStyleBold24(mainColor, context),
            ),
            SizedBox(
              height: 40.h,
            ),
            SecretaryScreenBody(
              secretaryParameter: secretaryParameter,
            ),
          ],
        ),
      ),
    );
  }
}

class SecretaryScreenBody extends StatelessWidget {
  final Map<String, dynamic> secretaryParameter;

  const SecretaryScreenBody({Key? key, required this.secretaryParameter,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<CustomCard> cards = [
      CustomCard(
        title: AppString.secretaryScreenStrings['create_order']!,
        icon: AppIcon.secretaryCreateOrderIcon,
        function: () {
          GoRouter.of(context).push(
            AppRouter.kCreateOrderScreen,
            extra: {
              'secretary': secretaryParameter['user'],
              'uid': secretaryParameter['uid'],
              'position': AppString.mainStrings['secretary'],
              'orderType': AppString.secretaryScreenStrings['create_order'],
            },
          );
        },
      ),
      CustomCard(
        title: AppString.secretaryScreenStrings['modify_order']!,
        icon: AppIcon.secretaryModifyOrderIcon,
        function: () {
          BlocProvider.of<OrderCubit>(context).getOrders(
              field: 'secretaryId', value: secretaryParameter['uid']);
          GoRouter.of(context).push(AppRouter.kOrderListViewScreen, extra: {
            'secretary': secretaryParameter['user'],
            'uid': secretaryParameter['uid'],
            'position': AppString.mainStrings['secretary'],
            'orderType': AppString.secretaryScreenStrings['modify_order'],
          });
        },
      ),
    ];
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
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
      },
    );
  }
}
