import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/auth/auth_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import 'colors.dart';

class BackgroundEmpty extends StatelessWidget {
  final Widget child;
  final bool hasAppBarText;
  final bool hasAppBarIcon;
  const BackgroundEmpty({
    super.key,
    required this.child,
    this.hasAppBarText = false,
    this.hasAppBarIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          if (hasAppBarIcon == true)
            Positioned(
              top: 56.h,
              left: 36.w,
              child: customAppBarArrowButton(context: context),
            ),
          if (hasAppBarText == true)
            Positioned(
              top: 56.h,
              left: 36.w,
              child: customAppBarArrowButton(
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
