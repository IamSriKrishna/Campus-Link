import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:campuslink/app/app_content.dart';
import 'package:campuslink/bloc/connectivity/listener.dart';
import 'package:campuslink/provider/auth_provider.dart';
import 'package:campuslink/view/auth/auth_screen.dart';
import 'package:campuslink/view/bottom/bottom_screen.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

class AppWidget {
  static ScreenUtilInit myApp() {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: AppContent.title,
            theme: ThemeData(
              useMaterial3: false,
            ),
            home:
                Consumer<AuthProvider>(builder: (context, authProvider, child) {
              if (authProvider.isAuthenticated) {
                return const ConnectivityListener(child: BottomScreen());
              } else {
                return const AuthScreen();
              }
            }),
          );
        });
  }
}
