import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AppIcon {
  static const Icon userNameIcon = Icon(Icons.account_circle);
  static const Icon backIcon = Icon(Icons.arrow_back_ios);
  static const Icon passwordIcon = Icon(Icons.lock);
  static const Icon eyeIconOn = Icon(Icons.visibility);
  static const Icon eyeIconOff = Icon(Icons.visibility_off);
  static const Icon ordersIcon = Icon(Icons.menu);
  static const Icon accountsIcon = Icon(Icons.account_circle);
  static const Icon representativesIcon = Icon(Icons.person);
  static const Icon orderClientNameIcon = Icon(Icons.person_outline);
  static const Icon orderAddressIcon = Icon(Icons.location_pin);
  static const Icon orderPhoneIcon = Icon(Icons.phone);
  static const Icon orderProblemTypeIcon = Icon(Icons.build);
  static const Icon orderRegisterDateIcon = Icon(Icons.calendar_today);
  static const Icon removeIcon = Icon(Icons.delete);


  static const String _newOrdersIconPath = 'assets/images/new_order_icon.svg';
  static final Widget newOrderIcon = SvgPicture.asset(
    _newOrdersIconPath,
    width: 45.w,
    height: 45.h,
  );
  static const String _checkoutOrdersIconPath =
      'assets/images/checkout_orders_icon.svg';
  static final Widget checkoutOrdersIcon = SvgPicture.asset(
    _checkoutOrdersIconPath,
    width: 45.w,
    height: 45.h,
  );
  static const String _deliveredOrdersIconPath =
      'assets/images/delivered_orders_icon.svg';
  static final Widget deliveredOrdersIcon = SvgPicture.asset(
    _deliveredOrdersIconPath,
    width: 45.w,
    height: 45.h,
  );
  static const String _checkedOrdersIconPath =
      'assets/images/checked_orders_icon.svg';
  static final Widget checkedOrdersIcon = SvgPicture.asset(
    _checkedOrdersIconPath,
    width: 45.w,
    height: 45.h,
  );
  static const String _addAccountIconPath =
      'assets/images/add_account_icon.svg';
  static final Widget addAccountIcon = SvgPicture.asset(
    _addAccountIconPath,
    width: 45.32.w,
    height: 32.96.h,
  );
  static const String _modifyAccountIconPath =
      'assets/images/modify_account_icon.svg';
  static final Widget modifyAccountIcon = SvgPicture.asset(
    _modifyAccountIconPath,
    width: 44.968.w,
    height: 32.96.h,
  );
  static const String _secretaryIconPath = 'assets/images/secretary_icon.svg';
  static final Widget secretaryIcon = SvgPicture.asset(
    _secretaryIconPath,
    width: 33.w,
    height: 50.h,
  );
  static const String _representativeIconPath =
      'assets/images/representative_icon.svg';
  static final Widget representativeIcon = SvgPicture.asset(
    _representativeIconPath,
    width: 55.65.w,
    height: 55.65.h,
  );
  static const String _secretaryModifyOrderIconPath =
      'assets/images/modify_order_icon.svg';
  static final Widget secretaryModifyOrderIcon = SvgPicture.asset(
    _secretaryModifyOrderIconPath,
    width: 43.15.w,
    height: 41.18.h,
  );

  static const String _secretaryCreateOrderIconPath =
      'assets/images/create_order_icon.svg';
  static final Widget secretaryCreateOrderIcon = SvgPicture.asset(
    _secretaryCreateOrderIconPath,
    width: 44.15.w,
    height: 39.61.h,
  );
  static const String _representativeNewOrderIconPath =
      'assets/images/representative_new_order_icon.svg';
  static final Widget representativeNewOrderIcon = SvgPicture.asset(
    _representativeNewOrderIconPath,
    width: 44.15.w,
    height: 39.61.h,
  );
  static const String _representativeDoneOrderIconPath =
      'assets/images/done_order_icon.svg';
  static final Widget representativeDoneOrderIcon = SvgPicture.asset(
    _representativeDoneOrderIconPath,
    width: 45.83.w,
    height: 40.18.h,
  );
  static const String _profileIconPath =
      'assets/images/profile_icon.svg';
  static final Widget profileIcon = SvgPicture.asset(
    _profileIconPath,
    width: 61.78.w,
    height: 61.78.h,
  );
}
