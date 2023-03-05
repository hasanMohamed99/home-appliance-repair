import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/auth/auth_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/utils/app_icons.dart';
import 'package:company/core/utils/app_strings.dart';
import 'package:company/core/utils/background_main.dart';
import 'package:company/core/utils/colors.dart';
import 'package:company/core/utils/app_constants.dart';
import 'package:company/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'manager_screen.dart';
import 'representative_screen.dart';
import 'secretary_screen.dart';

class LoginScreen extends StatelessWidget {
  final String position;
  const LoginScreen({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocConsumer<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UserSuccess) {
            return BlocBuilder<AuthCubit, AuthState>(
              builder: (context, authState) {
                if (authState is Authenticated &&
                    authState.position == 'manager' &&
                    position.toLowerCase() == 'manager') {
                  savePosition(authState.uid,position.toLowerCase());
                  return ManagerScreen(managerParameter: {'uid':authState.uid,'position': 'Manager', 'user': authState.user});
                } else if (authState is Authenticated &&
                    authState.position == 'secretary' &&
                    position.toLowerCase() == 'secretary') {
                  savePosition(authState.uid,position.toLowerCase());
                  return SecretaryScreen(secretaryParameter: {'uid':authState.uid,'position': 'Secretary', 'user': authState.user});
                } else if (authState is Authenticated &&
                    authState.position == 'representative' &&
                    position.toLowerCase() == 'representative') {
                  savePosition(authState.uid,position.toLowerCase());
                  return RepresentativeScreen(representativeParameter: {'uid':authState.uid,'position': 'Representative', 'user': authState.user});
                } else {
                  clearPosition();
                  return BackgroundMain(
                    hasAppBarIcon: true,
                    child: _LoginBody(
                      position: position,
                    ),
                  );
                }
              },
            );
          }
          return BackgroundMain(
            hasAppBarIcon: true,
            child: _LoginBody(
              position: position,
            ),
          );
        },
        listener: (context, userState) {
          if (userState is UserSuccess) {
            BlocProvider.of<AuthCubit>(context).loggedIn();
          }
          if (userState is UserFailure) {
            showToast(text: 'Invalid email', state: ToastStates.ERROR);
          }
        },
      ),
    );
  }

  Future<void> savePosition(String userID, String userPosition) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(userID, userPosition);
  }
}

class _LoginBody extends StatefulWidget {
  final String position;

  const _LoginBody({
    Key? key,
    required this.position,
  }) : super(key: key);

  @override
  State<_LoginBody> createState() => _LoginBodyState();
}

class _LoginBodyState extends State<_LoginBody> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordShow = true;
  var formKey = GlobalKey<FormState>();
  bool rememberMe = false;
  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kLoginPadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.position,
              style: Styles.textStyleBold24(mainColor, context),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            SizedBox(
              width: kButtonWidth.w,
              height: kButtonHeight.h,
              child: defaultTextFormField(
                style: Styles.textStyle16(normalTextColor, context),
                label: AppString.loginScreenStrings['username']!,
                controller: userNameController,
                type: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppString.loginScreenStrings['username_warning'];
                  }
                  return null;
                },
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(kRadius.r)),
                prefixIcon: AppIcon.userNameIcon,
              ),
            ),
            SizedBox(
              height: size.height / 40,
            ),
            SizedBox(
              width: kButtonWidth.w,
              height: kButtonHeight.h,
              child: defaultTextFormField(
                  style: Styles.textStyle16(normalTextColor, context),
                  label: AppString.loginScreenStrings['password']!,
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  obscureText: isPasswordShow,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppString.loginScreenStrings['password_warning'];
                    }
                    return null;
                  },
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(kRadius.r)),
                  prefixIcon: AppIcon.passwordIcon,
                  suffixIcon:
                      !isPasswordShow ? AppIcon.eyeIconOn : AppIcon.eyeIconOff,
                  suffixPressed: () {
                    setState(() {
                      isPasswordShow = !isPasswordShow;
                    });
                  }),
            ),
            SizedBox(
              height: size.height / 30,
            ),
            defaultButton(
              function: () {
                if (formKey.currentState!.validate()) {
                  submitSignIn();
                }
              },
              text: AppString.loginScreenStrings['login']!,
              width: kButtonWidth.w,
              height: kButtonHeight.h,
              radius: kRadius.r,
              style: Styles.textStyle20(iconTextColor, context),
            ),
          ],
        ),
      ),
    );
  }

  void submitSignIn() {
    if (userNameController.text.isNotEmpty &&
        passwordController.text.isNotEmpty) {
      BlocProvider.of<UserCubit>(context).submitSignIn(
          user: UserEntity(
        username: userNameController.text,
        password: passwordController.text,
      ));
    }
  }
}
