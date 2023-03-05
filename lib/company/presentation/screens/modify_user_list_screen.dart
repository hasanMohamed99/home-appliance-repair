import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:company/company/domain/entities/user_entity.dart';
import 'package:company/company/presentation/components/components.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/utils/app_icons.dart';
import 'package:company/core/utils/app_router.dart';
import 'package:company/core/utils/background_empty.dart';
import 'package:company/core/utils/colors.dart';
import 'package:company/core/utils/app_constants.dart';
import 'package:company/core/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ModifyUserListScreen extends StatelessWidget {
  final Map<String, dynamic> modifyUserListParameters;
  // 'position': AppString.mainStrings['manager'],
  // 'screenType': AppString.managerScreenStrings['delete_account'],

  const ModifyUserListScreen({
    Key? key,
    required this.modifyUserListParameters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<UserCubit, UserState>(
        builder: (context, userState) {
          if (userState is UsersLoaded) {
            return BackgroundEmpty(
              hasAppBarText: false,
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                    primary: true,
                    iconTheme: const IconThemeData(color: normalTextColor),
                    toolbarHeight: 80.h,
                    titleTextStyle:
                        Styles.textStyleBold16(normalTextColor, context),
                    backgroundColor: backgroundColor,
                    pinned: true,
                    title: Text(modifyUserListParameters['position']),
                    centerTitle: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _UsersListViewItem(
                          modifyUserListParameters: modifyUserListParameters,
                          user: userState.users[index],
                        );
                      },
                      childCount: userState.users.length,
                    ),
                  ),
                ],
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class _UsersListViewItem extends StatelessWidget {
  final Map<String, dynamic> modifyUserListParameters;
  final UserEntity user;
  const _UsersListViewItem({
    Key? key,
    required this.modifyUserListParameters,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0.h, horizontal: 20.w),
      child: Material(
        borderRadius: BorderRadius.all(Radius.circular(kRadius.r)),
        elevation: 5,
        child: SizedBox(
          height: 120.h,
          child: Row(
            children: [
              SizedBox(
                width: 15.w,
              ),
              SizedBox(
                width: 62.w,
                height: 62.h,
                child: AppIcon.profileIcon,
              ),
              SizedBox(
                width: 30.w,
              ),
              Expanded(
                child: ListTile(
                  dense: false,
                  horizontalTitleGap: 10.w,
                  title: Text(
                    user.name!.capitalize(),
                    style: Styles.textStyleBold16(normalTextColor, context),
                  ),
                  subtitle: Text(
                    '${user.position} \nFinished Orders: ${user.finishedOrders}'
                        '\nCurrent Orders: ${user.currentOrders}',
                    style: Styles.textStyle14(normalTextColor, context),
                  ),
                  isThreeLine: true,
                  trailing: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => SimpleDialog(
                          title: Text(
                            'Confirm removing account',
                            style: Styles.textStyle16(normalTextColor, context),
                          ),
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: defaultTextButton(
                                        function: () {
                                          Navigator.pop(context);
                                        },
                                        text: 'Cancel')),
                                Expanded(
                                  child: defaultTextButton(
                                      function: () async {
                                        // deleteUsers(userEntity: user);
                                        BlocProvider.of<UserCubit>(context).deleteUser(user: user);
                                        showToast(
                                            text:
                                                'account removed successfully ',
                                            state: ToastStates.SUCCESS);
                                        GoRouter.of(context).go(AppRouter.kManagerScreen, extra: modifyUserListParameters);
                                      },
                                      text: 'Confirm'),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    icon: AppIcon.removeIcon,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteUsers({required UserEntity userEntity}) async {
    final orderCollectionRef =
    FirebaseFirestore.instance.collection('users');
    orderCollectionRef.doc(userEntity.uId).get().then((user) {
      if (user.exists) {
        orderCollectionRef.doc(userEntity.uId).delete();
      }
      return;
    });
  }
}
