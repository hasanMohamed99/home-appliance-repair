import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
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

class CreateUserScreen extends StatelessWidget {
  final Map<String, dynamic> createUserParameters;
  // 'position': AppString.mainStrings['manager'],
  // 'screenType': AppString.managerScreenStrings['delete_account'],
  const CreateUserScreen({
    Key? key,
    required this.createUserParameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BackgroundEmpty(
        hasAppBarIcon: true,
        child: _CreateUserBody(
          createUserParameters: createUserParameters,
        ),
      ),
    );
  }
}

class _CreateUserBody extends StatefulWidget {
  final Map<String, dynamic> createUserParameters;

  const _CreateUserBody({
    Key? key,
    required this.createUserParameters,
  }) : super(key: key);

  @override
  State<_CreateUserBody> createState() => _CreateUserBodyState();
}

class _CreateUserBodyState extends State<_CreateUserBody> {
  TextEditingController nameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  dynamic radioValue = 'none';
  var formKey = GlobalKey<FormState>();
  @override
  void dispose() {
    nameController.dispose();
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kCreateUserPadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: kButtonWidth.w,
              height: kButtonHeight.h,
              child: defaultTextFormField(
                style: Styles.textStyle16(normalTextColor, context),
                label: AppString.createUserScreenStrings['name']!,
                controller: nameController,
                type: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppString.createUserScreenStrings['name_warning'];
                  }
                  return null;
                },
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
              ),
            ),
            SizedBox(
              height: 33.h,
            ),
            SizedBox(
              width: kButtonWidth.w,
              height: kButtonHeight.h,
              child: defaultTextFormField(
                style: Styles.textStyle16(normalTextColor, context),
                label: AppString.createUserScreenStrings['username']!,
                controller: userNameController,
                type: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppString
                        .createUserScreenStrings['username_warning'];
                  }
                  return null;
                },
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
              ),
            ),
            SizedBox(
              height: 33.h,
            ),
            SizedBox(
              width: kButtonWidth.w,
              height: kButtonHeight.h,
              child: defaultTextFormField(
                style: Styles.textStyle16(normalTextColor, context),
                label: AppString.createUserScreenStrings['password']!,
                controller: passwordController,
                type: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppString
                        .createUserScreenStrings['password_warning'];
                  }
                  return null;
                },
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(kRadius.r),
                ),
                contentPadding:
                    EdgeInsets.symmetric(vertical: 15.h, horizontal: 25.w),
              ),
            ),
            SizedBox(
              height: 33.h,
            ),
            Row(
              children: [
                Flexible(
                  child: FittedBox(
                    child: LinkedLabelRadio(
                      label: AppString.createUserScreenStrings['secretary']!,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      value: AppString.createUserScreenStrings['secretary'],
                      groupValue: radioValue,
                      onChanged: (dynamic newValue) {
                        setState(() {
                          radioValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.w,
                ),
                Flexible(
                  child: FittedBox(
                    child: LinkedLabelRadio(
                      label:
                          AppString.createUserScreenStrings['representative']!,
                      padding: const EdgeInsets.symmetric(horizontal: 0),
                      value:
                          AppString.createUserScreenStrings['representative'],
                      groupValue: radioValue,
                      onChanged: (dynamic newValue) {
                        setState(() {
                          radioValue = newValue;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 33.h,
            ),
            defaultButton(
              function: () {
                submitNewUser();
              },
              text: AppString.managerScreenStrings['save']!,
              width: kButtonWidth.w,
              height: kButtonHeight.h,
              radius: kRadius.r,
              style: Styles.textStyle20(iconTextColor, context),
            )
          ],
        ),
      ),
    );
  }

  void submitNewUser() {
    if (formKey.currentState!.validate() && radioValue != 'none') {
      BlocProvider.of<UserCubit>(context).submitSignUp(
        user: UserEntity(
          name: nameController.text,
          username: '${userNameController.text}@mc.com',
          password: passwordController.text,
          position: radioValue.toString().toLowerCase(),
          deviceToken: '',
          currentOrders: 0,
          finishedOrders: 0,
        ),
      );
      showToast(text: 'account created', state: ToastStates.SUCCESS);
      GoRouter.of(context)
          .go(AppRouter.kManagerScreen, extra: widget.createUserParameters);
    }
    if (radioValue == 'none') {
      showToast(text: 'please, select employee type', state: ToastStates.ERROR);
    }
  }
}
