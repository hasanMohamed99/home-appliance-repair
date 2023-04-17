import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/auth/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'colors.dart';

class BackgroundMain extends StatelessWidget {
  final Widget child;
  final bool hasAppBarIcon;
  final bool hasAppBarText;
  final String position;
  const BackgroundMain({
    super.key,
    required this.child,
    this.hasAppBarIcon = false,
    this.hasAppBarText = false,
    this.position = '',
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 191.h,
              child: Image.asset(
                "assets/images/top1.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 251.h,
              child: Image.asset(
                "assets/images/top2.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 252.h,
              child: Image.asset(
                "assets/images/bottom1.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: SizedBox(
              width: size.width,
              height: 113.h,
              child: Image.asset(
                "assets/images/bottom2.png",
                fit: BoxFit.fill,
              ),
            ),
          ),
          if (hasAppBarIcon == true)
            Positioned(
              top: 56.h,
              left: 36.w,
              child: customAppBarArrowButton(context: context),
            ),
          if (hasAppBarText == true && position.isNotEmpty)
            Positioned(
              top: 56.h,
              left: 36.w,
              child: customAppBarTextButton(
                context: context,
                function: () {
                  clearPosition();
                  BlocProvider.of<AuthCubit>(context).loggedOut();
                  GoRouter.of(context).go('/');
                },
              ),
            ),
          child
        ],
      ),
    );
  }
}
