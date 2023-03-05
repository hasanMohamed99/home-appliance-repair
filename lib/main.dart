import 'package:company/company/presentation/controller/auth/auth_cubit.dart';
import 'package:company/company/presentation/controller/order/order_cubit.dart';
import 'package:company/company/presentation/controller/user/user_cubit.dart';
import 'package:company/core/utils/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/utils/colors.dart';
import 'core/services/services_locator.dart' as service;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await service.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<AuthCubit>(create: (_) => service.sl<AuthCubit>()..appStarted()),
            BlocProvider<UserCubit>(create: (_) => service.sl<UserCubit>()),
            BlocProvider<OrderCubit>(create: (_) => service.sl<OrderCubit>()),
          ],
          child: MaterialApp.router(
            themeAnimationCurve: Curves.linear,
            routerConfig: AppRouter.router,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: primarySwatchColor,
            ),
          ),
        );
      },
    );
  }
}
