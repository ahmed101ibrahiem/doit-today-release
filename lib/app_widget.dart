import "package:bot_toast/bot_toast.dart";
import "package:doit_today/core/base/bloc/global_blocs/base_bloc_providers.dart";
import "package:doit_today/core/base/router/app_navigation.dart";
import "package:doit_today/core/constants/app_settings.dart";
import "package:doit_today/core/resources/my_color.dart";
import "package:doit_today/core/resources/my_styles.dart";
import "package:doit_today/widgets/custom_text/custom_text.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final botToastBuilder = BotToastInit();

    errorWidget();
    return ScreenUtilInit(
      designSize: AppSettings.designSize,
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MultiBlocProvider(
          providers: BaseBlocProviders.providers(context),
            child: MaterialApp.router(
              routerConfig: AppNavigation.router,
              debugShowCheckedModeBanner: false,
              themeMode: ThemeMode.light,
              builder: (context, child) {
                child = botToastBuilder(context, child);
                child = FlutterEasyLoading(child: child);
                return child;
              },
            ));
      },
    );
  }

  Function errorWidget() {
    return ErrorWidget.builder = (errorDetails) {
      return Scaffold(
        backgroundColor: MyColors.primary,
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10).r,
            child: SingleChildScrollView(
              child: CustomText(
                title: errorDetails.exceptionAsString(),
                style: MyStyles.textStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      );
    };
  }
}
