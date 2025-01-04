import "package:bot_toast/bot_toast.dart";
import "package:doit_today/core/base/injection/locator.dart";
import "package:doit_today/core/resources/my_color.dart";
import "package:doit_today/core/resources/my_styles.dart";
import "package:doit_today/core/services/navigation_service/navigation_service.dart";
import "package:doit_today/widgets/custom_text/custom_text.dart";

import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_easyloading/flutter_easyloading.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_spinkit/flutter_spinkit.dart";

class AlertService {
  CancelFunc showFCMAlert({
    required String title,
    required String subTitle,
    VoidCallback? onTap,
  }) {
    return BotToast.showNotification(
      onTap: onTap,
      title: (cancel) => Row(
        children: [
          Text(
            title,
            style: MyStyles.textStyle(
              color: const Color(0xff022847),
              fontSize: 15,
              fontWeight: FontWeight.w800,
            ),
            textDirection: TextDirection.rtl,
          ),
          const Spacer(),
          GestureDetector(
            onTap: cancel,
            child: Icon(
              Icons.clear,
              color: MyColors.black,
            ),
          ),
        ],
      ),
      subtitle: (_) => Padding(
        padding: const EdgeInsets.only(top: 6).h,
        child: Row(
          children: [
            Expanded(
              child: Text(
                subTitle,
               
                style: MyStyles.textStyle(
                  color: const Color(0xff464646),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                textDirection: TextDirection.rtl,
              ),
            ),
            10.horizontalSpace,
           
          ],
        ),
      ),
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.84),
      backButtonBehavior: BackButtonBehavior.close,
      animationDuration: const Duration(milliseconds: 500),
      animationReverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 4),
      borderRadius: 12,
      contentPadding: const EdgeInsets.all(16).r,
    );
  }

  CancelFunc showAlert({
    required String title,
    bool isSuccess = false,
  }) {
    return BotToast.showNotification(
      trailing: (cancel) => GestureDetector(
        onTap: cancel,
        child: Icon(
          Icons.clear,
          color: MyColors.black,
          size: 20.r,
        ),
      ),
      title: (_) => CustomText(
        title: title,
        style: MyStyles.textStyle(
          color: MyColors.black,
          fontSize: 11,
        ),
      ),

      leading: (_) => Icon(
        isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
        color: isSuccess ? MyColors.green : MyColors.red,
        size: 35.r,
      ),
      backgroundColor: MyColors.white,
      backButtonBehavior: BackButtonBehavior.close,
      animationDuration: const Duration(milliseconds: 500),
      animationReverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 4),
      borderRadius: 12.0.r,
      margin: const EdgeInsets.all(5).r,
      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20).r,
    );
  }

  void showLoadingDialog(BuildContext context) {
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.light;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.instance.animationStyle = EasyLoadingAnimationStyle.offset;
    EasyLoading.instance.indicatorWidget = SizedBox(
      height: 40.h,
      width: 40.w,
      child: SpinKitChasingDots(
        color: MyColors.primary,
        size: 25,
      ),
    );
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      status: '',
    );
  }

  Center showLoadingView(BuildContext context) => Center(
        child: SpinKitChasingDots(
          color: MyColors.primary,
          size: 28,
        ),
      );

  void showLoadingDialogWithProgress({String? progress}) {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.clear,
      status: progress,
    );
  }

  void closeLoading() => EasyLoading.dismiss();

  Future showConfirmDialog({
    required BuildContext context,
    required VoidCallback confirm,
    required String title,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) => _alertDialog(
        confirm,
        context,
        title,
      ),
    );
  }

  Future showCustomDialog({
    required BuildContext context,
    required Widget child,
    Function? callBack,
    bool hasCallBack = false,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Dialog.fullscreen(
          backgroundColor: Colors.white,
          // surfaceTintColor: Colors.white,
          child: child,
        );
      },
    ).then((value) {
      if (hasCallBack) {
        callBack!();
      }
    });
  }

  Widget _alertDialog(
    VoidCallback confirm,
    BuildContext context,
    String title,
  ) =>
      CupertinoAlertDialog(
        title: Text(
          title,
          style: MyStyles.textStyle(
            fontSize: 14.5,
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () => locator<NavigationService>().pop(context),
            child: Text(
              'Cancel',
              style: MyStyles.textStyle(
                fontSize: 13,
                color: MyColors.black,
              ),
            ),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Navigator.pop(context);
              confirm();
            },
            child: Text(
              'Confirm',
              style: MyStyles.textStyle(
                fontSize: 13,
                color: MyColors.black,
              ),
            ),
          ),
        ],
      );
}
