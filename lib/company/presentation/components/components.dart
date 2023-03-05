import 'package:company/core/utils/app_icons.dart';
import 'package:company/core/utils/colors.dart';
import 'package:company/core/utils/app_constants.dart';
import 'package:company/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

Widget defaultButton({
  double width = double.infinity,
  double? height,
  Color backgroundColor = buttonColor,
  Color textColor = iconTextColor,
  double? fontSize,
  TextStyle? style,
  double radius = 0.0,
  required String text,
  @required function,
}) =>
    Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: backgroundColor,
      ),
      child: MaterialButton(
        onPressed: function,
        child: FittedBox(
          child: Text(
            text,
            style: style,
          ),
        ),
      ),
    );

Widget defaultTextFormField({
  required String label,
  required TextEditingController controller,
  required TextInputType type,
  required validator,
  border, //OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
  bool obscureText = false,
  Icon? prefixIcon,
  Icon? suffixIcon,
  onFieldSubmitted,
  onChanged,
  suffixPressed,
  onTap,
  enabled,
  TextStyle? style,
  EdgeInsets? contentPadding,
  double? errorMessageHeight,
  bool readOnly = false,
}) =>
    TextFormField(
      readOnly: readOnly,
      textAlignVertical: TextAlignVertical.top,
      style: style,
      enabled: enabled,
      controller: controller,
      keyboardType: type,
      obscureText: obscureText,
      onFieldSubmitted: onFieldSubmitted,
      onChanged: onChanged,
      onTap: onTap,
      validator: validator,
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 0.01),
        contentPadding: contentPadding,
        border: border,
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: suffixIcon,
              )
            : null,
      ),
    );

PreferredSizeWidget defaultAppBar({
  required BuildContext context,
  String? title,
  List<Widget>? actions,
}) =>
    AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(Icons.arrow_back),
      ),
      titleSpacing: 5.0,
      title: Text(title!),
      actions: actions,
    );

Widget defaultTextButton({
  required function,
  required String text,
  TextStyle? textStyle,
}) =>
    TextButton(
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: textStyle,
      ),
    );
Widget customAppBarTextButton({
  required context,
  required function,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defaultTextButton(
          function: function,
          text: 'Logout',
          textStyle: Styles.textStyle14(mainColor, context),
        ),
      ],
    );
Widget customAppBarArrowButton({
  required context,
  function,
}) =>
    Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: function ??
              () {
                GoRouter.of(context).pop(context);
              },
          icon: AppIcon.backIcon,
          color: mainColor,
        ),
      ],
    );

class CustomCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final VoidCallback function;
  const CustomCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: SizedBox(
        width: 171.w,
        height: 180.h,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kRadius.r),
          ),
          color: iconTextColor,
          elevation: 5.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              icon,
              SizedBox(
                height: 15.h,
              ),
              Text(
                title,
                style: Styles.textStyle16(mainColor, context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LinkedLabelRadio extends StatelessWidget {
  const LinkedLabelRadio({
    super.key,
    required this.label,
    required this.padding,
    required this.groupValue,
    required this.value,
    required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final dynamic groupValue;
  final dynamic value;
  final ValueChanged<dynamic> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: <Widget>[
          Radio<dynamic>(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            groupValue: groupValue,
            value: value,
            onChanged: (dynamic newValue) {
              onChanged(newValue!);
            },
          ),
          RichText(
            overflow: TextOverflow.fade,
            text: TextSpan(
              text: label,
              style: Styles.textStyle16(normalTextColor, context),
            ),
          ),
        ],
      ),
    );
  }
}

Widget myDivider() => Padding(
      padding: EdgeInsets.symmetric(horizontal: 6.0.w),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey[300],
      ),
    );

Widget myShimmer({
  required double height,
  required double verticalPadding,
  required double horizontalPadding,
}) =>
    Padding(
      padding: EdgeInsets.symmetric(
          vertical: verticalPadding, horizontal: horizontalPadding),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[500]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(kRadius.r),
            color: backgroundColor,
          ),
          height: height,
        ),
      ),
    );

void showToast({required String text, required ToastStates state, textColor}) =>
    Fluttertoast.showToast(
      msg: text,
      textColor: Colors.white,
      backgroundColor: chooseToastColor(state),
      toastLength: Toast.LENGTH_LONG,
    );

// ignore: constant_identifier_names
enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates state) {
  Color color;
  switch (state) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Future<void> clearPosition() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.clear();
}

extension MyExtention on String{
  String capitalize(){
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
