import 'package:doit_today/core/resources/my_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NavigationService {
  void push(
    BuildContext context, {
    required String path,
    Function? afterClose,
    bool isAfterClose = false,
    Map<String, dynamic>? queryParameters,
  }) {
    context
        .pushNamed(
      path,
      extra: queryParameters,
    )
        .then((value) {
      if (isAfterClose) {
        afterClose?.call();
      }
    });
  }

  void clearAndNavigate(BuildContext context) {
    while (GoRouter.of(context).canPop() == true) {
      GoRouter.of(context).pop();
    }
  }

  void pushAndRemoveAll(
    BuildContext context, {
    required String path,
    Map<String, dynamic>? queryParameters,
  }) {
    // clearAndNavigate(context);
    context.pushReplacementNamed(
      path,
      queryParameters: queryParameters ?? {},
    );
  }

  void pop(BuildContext context, {List? results}) {
    context.pop(results);
  }

  void pushWithBottomSheet(
    BuildContext context, {
    required Widget path,
    Function? next,
    bool? useNext = false,
    double? height,
    bool haveDynamicSize = false,
  }) {
    FocusScope.of(context).unfocus();
   // isBottomSheetOpen = true;
    showBarModalBottomSheet(
      context: context,
      useRootNavigator: true,
      shape: RoundedRectangleBorder(
        borderRadius: MyStyles.borderRadius(type: BorderRadiusType.top),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: haveDynamicSize
            ? path
            : FractionallySizedBox(
                heightFactor: height ?? 0.60,
                child: path,
              ),
      ),
    ).then((value) {
   //   isBottomSheetOpen = false;
      if (useNext ?? false) {
        next?.call();
      }
    });
  }
}
