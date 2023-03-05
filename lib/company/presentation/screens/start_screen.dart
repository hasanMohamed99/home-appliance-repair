import 'package:company/company/presentation/components/components.dart';
import 'package:company/core/utils/app_router.dart';
import 'package:company/core/utils/app_strings.dart';
import 'package:company/core/utils/background_main.dart';
import 'package:company/core/utils/colors.dart';
import 'package:company/core/utils/app_constants.dart';
import 'package:company/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundMain(
        hasAppBarIcon: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: kLoginPadding.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              defaultButton(
                width: kButtonWidth.w,
                height: kButtonHeight.h,
                text: AppString.startScreenStrings['manager']!,
                function: () {
                  GoRouter.of(context).push(AppRouter.kLoginScreen, extra: 'Manager');
                },
                style: Styles.textStyle20(iconTextColor, context),
                radius: kRadius.r,
              ),
              SizedBox(
                height: 65.h,
              ),
              defaultButton(
                width: kButtonWidth.w,
                height: kButtonHeight.h,
                text: AppString.startScreenStrings['secretary']!,
                function: () {
                  GoRouter.of(context).push(AppRouter.kLoginScreen, extra: 'Secretary');
                },
                style: Styles.textStyle20(iconTextColor, context),
                radius: kRadius.r,
              ),
              SizedBox(
                height: 65.h,
              ),
              defaultButton(
                width: kButtonWidth.w,
                height: kButtonHeight.h,
                text: AppString.startScreenStrings['representative']!,
                function: () {
                  GoRouter.of(context).push(AppRouter.kLoginScreen, extra: 'Representative');
                },
                style: Styles.textStyle20(iconTextColor, context),
                radius: kRadius.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
