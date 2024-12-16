import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class NavigationService {
  void push(
    BuildContext context, {
    required String path,
    Map<String, dynamic>? queryParameters,
    Function? afterClose,
    bool isAfterClose = false,
  }) {
    try {
      context.pushNamed(path, extra: queryParameters).then((value) {
        if (isAfterClose) {
          afterClose?.call();
        }
      });
    } catch (e) {
      debugPrint('Navigation Error: $e');
    }
  }

  // designed to pop all routes until the navigation stack is cleared
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
    clearAndNavigate(context);
    context.goNamed(path, queryParameters: queryParameters ?? {});
  }


  void pushWithBottomSheet(
  BuildContext context, {
  required Widget child,
  VoidCallback? onClose,
  bool useOnClose = false,
  double heightFactor = 0.85,
}) {
  showBarModalBottomSheet(
    context: context,
    useRootNavigator: true,
    shape:  RoundedRectangleBorder(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(8),
        topRight: Radius.circular(8),
      ).r,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    builder: (context) => FractionallySizedBox(
      heightFactor: heightFactor,
      child: child,
    ),
  ).then((_) {
    if (useOnClose && onClose != null) {
      onClose();
    }
  });
}

}
