import 'dart:typed_data';

import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vibration/vibration.dart';

class AppDialogs {
  /* static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle = titleText ?? 'Success';
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: AppColors.successBackgroundColor,
      titleWidget: Text(dialogTitle,
          style: AppTextStyles.titleSmallSemiboldTextStyle
              .copyWith(color: AppColors.successColor),
          textAlign: TextAlign.center),
      contentWidget:
          Text(messageText, style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomStretchedTextButtonWidget(
          buttonText: '',
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        )
      ],
    ));
  } */

  /* <--------Success Dialog --------> */
  static Future<Object?> showSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.successTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.successImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: AppColors.successColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        /* CustomStretchedTextButtonWidget(
          buttonText: 'Okay',
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        ) */
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  static Future<Object?> showPendingDialog({
    required String messageText,
  }) async {
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.pendingImage),
        ],
      ),
      contentWidget: Text(
        messageText,
        textAlign: TextAlign.center,
        style: AppTextStyles.titleSemiboldTextStyle,
      ),
      actionWidgets: [
        CustomStretchedButtonWidget(
          onTap: () {
            Get.back();
          },
          child: Text(
            AppLanguageTranslation.okTransKey.toCurrentLanguage,
          ),
        )
      ],
    ));
  }

  /* <-------- Confirm Payment Dialog --------> */
  static Future<Object?> showConfirmPaymentDialog({
    String titleText = '',
    required double amount,
    required double totalAmount,
    required String symbol,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String noButtonText = 'Cancel',
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: AppColors.backgroundColor,
        titleWidget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppGaps.hGap16,
            Center(
              child: Text(titleText,
                  style: AppTextStyles.titleSmallSemiboldTextStyle
                      .copyWith(color: const Color(0xFF3B82F6)),
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentWidget: Row(
          children: [
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(24),
              height: 185,
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(14))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLanguageTranslation
                        .paymentDetailsTranskey.toCurrentLanguage,
                    style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  ),
                  AppGaps.hGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLanguageTranslation.amountTranskey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeMediumTextStyle
                            .copyWith(color: AppColors.bodyTextColor),
                      ),
                      Row(
                        children: [
                          Text(symbol,
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor)),
                          AppGaps.wGap4,
                          Text(amount.toStringAsFixed(2),
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.bodyTextColor)),
                        ],
                      ),
                    ],
                  ),
                  AppGaps.hGap8,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLanguageTranslation
                            .discountTranskey.toCurrentLanguage,
                        style: AppTextStyles.bodyLargeMediumTextStyle
                            .copyWith(color: AppColors.errorColor),
                      ),
                      Row(
                        children: [
                          Text(symbol,
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.errorColor)),
                          AppGaps.wGap4,
                          Text(0.toStringAsFixed(2),
                              style: AppTextStyles.bodyLargeMediumTextStyle
                                  .copyWith(color: AppColors.errorColor)),
                        ],
                      ),
                    ],
                  ),
                  AppGaps.hGap12,
                  Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        decoration: const BoxDecoration(
                            color: AppColors.formBorderColor),
                      ))
                    ],
                  ),
                  AppGaps.hGap12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppLanguageTranslation
                            .grandTotalTranskey.toCurrentLanguage,
                        style: AppTextStyles.bodyBoldTextStyle,
                      ),
                      Row(
                        children: [
                          Text(symbol, style: AppTextStyles.bodyBoldTextStyle),
                          AppGaps.wGap4,
                          Text(totalAmount.toStringAsFixed(2),
                              style: AppTextStyles.bodyBoldTextStyle),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ))
          ],
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation
                          .confirmToPayTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  /* <--------  share Ride Success Dialog --------> */
  static Future<Object?> shareRideSuccessDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() homeButtonTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? homeButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(
              AppAssetImages.successImage,
            ),
            AppGaps.hGap16,
            Center(
              child: Text(
                  titleText ??
                      AppLanguageTranslation
                          .yourRequestSendSuccessfulTranskey.toCurrentLanguage,
                  style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                  textAlign: TextAlign.center),
            ),
          ],
        ),
        contentWidget: Text(messageText,
            style: AppTextStyles.bodyLargeSemiboldTextStyle,
            textAlign: TextAlign.center),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: homeButtonText ??
                      AppLanguageTranslation.goHomeTransKey.toCurrentLanguage,
                  onTap: () async {
                    await homeButtonTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  /* <--------  Accept Location Dialouge --------> */
  static Future<Object?> showAcceptLocationDialouge({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.enableLocationIconImage),
          AppGaps.hGap16,
          Text(
              titleText ??
                  AppLanguageTranslation
                      .enableYourLocationTransKey.toCurrentLanguage,
              style: AppTextStyles.titleLargeBoldTextStyle
                  .copyWith(color: AppColors.primaryTextColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          style: AppTextStyles.bodyLargeSemiboldTextStyle
              .copyWith(color: AppColors.bodyTextColor),
          textAlign: TextAlign.center),
      actionWidgets: [
        Column(
          children: [
            CustomStretchedTextButtonWidget(
              buttonText: AppLanguageTranslation.yesTransKey.toCurrentLanguage,
              onTap: () async {
                await onYesTap();
                if (shouldCloseDialogOnceYesTapped) Get.back();
              },
            ),
            AppGaps.hGap10,
            CustomStretchedOnlyTextButtonWidget(
              buttonText:
                  AppLanguageTranslation.skipForNowTransKey.toCurrentLanguage,
              onTap: onNoTap ??
                  () {
                    Get.back();
                  },
            ),
          ],
        )
      ],
    ));
  }

  /* <--------  Sign Up Success Dialog --------> */
  static Future<Object?> signUpSuccessDialog(
      {String? titleText,
      required Future<void> Function() onYesTap,
      bool barrierDismissible = false,
      required String messageText}) async {
    final String dialogTitle = titleText ??
        AppLanguageTranslation.congratulationTransKey.toCurrentLanguage;
    return await Get.dialog(
        barrierDismissible: barrierDismissible,
        AlertDialogWidget(
          backgroundColor: Colors.white,
          titleWidget: Column(
            children: [
              // Image.asset(AppAssetImages.successIconImage),
              AppGaps.hGap16,
              Text(dialogTitle,
                  style: AppTextStyles.titleBoldTextStyle
                      .copyWith(color: AppColors.primaryTextColor),
                  textAlign: TextAlign.center),
            ],
          ),
          contentWidget: Text(messageText,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyLargeSemiboldTextStyle),
          actionWidgets: [
            /* CustomStretchedTextButtonWidget(
          buttonText: 'Okay',
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        ) */
            /* CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            )) */
            CustomStretchedButtonWidget(
                onTap: () async {
                  await onYesTap();
                },
                child: Text(
                  AppLanguageTranslation.getStartedTransKey.toCurrentLanguage,
                  style: AppTextStyles.bodyLargeSemiboldTextStyle
                      .copyWith(color: Colors.white),
                ))
          ],
        ));
  }

  /* <--------  Update Success Dialog --------> */
  static Future<Object?> updateSuccessDialog(
      {String? titleText,
      required Future<void> Function() onYesTap,
      bool barrierDismissible = false,
      required String messageText}) async {
    final String dialogTitle = titleText ??
        AppLanguageTranslation.congratulationTransKey.toCurrentLanguage;
    return await Get.dialog(
        barrierDismissible: barrierDismissible,
        PopScope(
          canPop: false,
          child: AlertDialogWidget(
            backgroundColor: Colors.white,
            titleWidget: Column(
              children: [
                // Image.asset(AppAssetImages.successIconImage),
                AppGaps.hGap16,
                Text(dialogTitle,
                    style: AppTextStyles.titleBoldTextStyle
                        .copyWith(color: AppColors.primaryTextColor),
                    textAlign: TextAlign.center),
              ],
            ),
            contentWidget: Text(messageText,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLargeSemiboldTextStyle),
            actionWidgets: [
              /* CustomStretchedTextButtonWidget(
            buttonText: 'Okay',
            // backgroundColor: AppColors.successColor,
            onTap: () {
              Get.back();
            },
          ) */
              /* CustomDialogButtonWidget(
              // backgroundColor: AppColors.alertColor,
              onTap: () {
                Get.back();
              },
              child: Text(
                AppLanguageTranslation.okTransKey.toCurrentLanguage,
              )) */
              CustomStretchedButtonWidget(
                  onTap: () async {
                    await onYesTap();
                  },
                  child: Text(
                    AppLanguageTranslation.goHomeTransKey.toCurrentLanguage,
                    style: AppTextStyles.bodyLargeSemiboldTextStyle
                        .copyWith(color: Colors.white),
                  ))
            ],
          ),
        ));
  }

  /* <--------  Password Changed Success Dialog --------> */
  static Future<Object?> showPassChangedSuccessDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle = titleText ??
        AppLanguageTranslation.successfullyChangedTransKey.toCurrentLanguage;
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          // Image.asset(AppAssetImages.successIconImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: AppColors.successColor),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        /* CustomStretchedTextButtonWidget(
          buttonText: 'Okay',
          // backgroundColor: AppColors.successColor,
          onTap: () {
            Get.back();
          },
        ) */
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.loginTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  /* <--------  Error Dialog --------> */
  static Future<Object?> showErrorDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    // Vibrate the phone
    final hasVibrator = await Vibration.hasVibrator();

    // Check if hasVibrator is not null and is true
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          Image.asset(AppAssetImages.errorImage),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  /* <--------  Expire Dialog --------> */
  static Future<Object?> showExpireDialog(
      {String? titleText, required String messageText}) async {
    final String dialogTitle =
        titleText ?? AppLanguageTranslation.sorryTransKey.toCurrentLanguage;
    // Vibrate the phone
    final hasVibrator = await Vibration.hasVibrator();

    // Check if hasVibrator is not null and is true
    if (hasVibrator == true) {
      Vibration.vibrate(duration: 500); // Vibrate for 500 milliseconds
    }
    return await Get.dialog(AlertDialogWidget(
      backgroundColor: Colors.white,
      titleWidget: Column(
        children: [
          // Image.asset(AppAssetImages.showErrorAlert),
          AppGaps.hGap16,
          Text(dialogTitle,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: Colors.red),
              textAlign: TextAlign.center),
        ],
      ),
      contentWidget: Text(messageText,
          textAlign: TextAlign.center,
          style: AppTextStyles.bodyLargeSemiboldTextStyle),
      actionWidgets: [
        CustomDialogButtonWidget(
            // backgroundColor: AppColors.alertColor,
            onTap: () {
              Get.back();
            },
            child: Text(
              AppLanguageTranslation.okTransKey.toCurrentLanguage,
            ))
      ],
    ));
  }

  /* <--------  Confirm Dialog --------> */
  static Future<Object?> showConfirmDialog({
    String? titleText,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          children: [
            Image.asset(AppAssetImages.confirmImage),
            AppGaps.hGap16,
            Text(
                titleText ??
                    AppLanguageTranslation.confirmTransKey.toCurrentLanguage,
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Text(messageText,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyLargeSemiboldTextStyle),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.noTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  /* <--------  Confirm Dialog --------> */
  static Future<dynamic> showSingleImageUploadConfirmDialog({
    String? titleText,
    required Uint8List selectedImageData,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox( height: 120, child: Image.asset(AppAssetImages.confirmImage)),
            // AppGaps.hGap16,
            Text(
                titleText ??
                    AppLanguageTranslation
                        .confirmationTransKey.toCurrentLanguage,
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: 64,
                width: 80,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                          image:
                              Image.memory(selectedImageData, fit: BoxFit.cover)
                                  .image,
                          fit: BoxFit.cover)),
                )),
            const VerticalGap(8),
            Text(messageText,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLargeSemiboldTextStyle),
          ],
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.noTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  static Future<dynamic> showMultipleImageUploadConfirmDialog({
    String? titleText,
    required List<Uint8List?> selectedImageData,
    required String messageText,
    required Future<void> Function() onYesTap,
    void Function()? onNoTap,
    bool shouldCloseDialogOnceYesTapped = true,
    String? yesButtonText,
    String? noButtonText,
  }) async {
    return await Get.dialog(
      AlertDialogWidget(
        backgroundColor: Colors.white,
        titleWidget: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // SizedBox( height: 120, child: Image.asset(AppAssetImages.confirmImage)),
            // AppGaps.hGap16,
            Text(
                titleText ??
                    AppLanguageTranslation
                        .confirmationTransKey.toCurrentLanguage,
                style: AppTextStyles.titleSmallSemiboldTextStyle
                    .copyWith(color: const Color(0xFF3B82F6)),
                textAlign: TextAlign.center),
          ],
        ),
        contentWidget: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Builder(builder: (context) {
              return SizedBox(
                  height: 64,
                  width: context.width * 0.7,
                  // width: 200,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        final imageData = selectedImageData[index];
                        return Container(
                          height: 64,
                          width: 80,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                  image: imageData == null
                                      ? Image.asset(AppAssetImages
                                              .imagePlaceholderIconImage)
                                          .image
                                      : Image.memory(imageData,
                                              fit: BoxFit.cover)
                                          .image,
                                  fit: BoxFit.cover)),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const HorizontalGap(10),
                      itemCount: selectedImageData.length));
            }),
            const VerticalGap(8),
            Text(messageText,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodyLargeSemiboldTextStyle),
          ],
        ),
        actionWidgets: [
          Row(
            children: [
              Expanded(
                child: CustomStretchedOutlinedTextButtonWidget(
                  buttonText: noButtonText ??
                      AppLanguageTranslation.noTransKey.toCurrentLanguage,
                  onTap: onNoTap ??
                      () {
                        Get.back();
                      },
                ),
              ),
              AppGaps.wGap12,
              Expanded(
                child: CustomStretchedTextButtonWidget(
                  buttonText: yesButtonText ??
                      AppLanguageTranslation.yesTransKey.toCurrentLanguage,
                  onTap: () async {
                    await onYesTap();
                    if (shouldCloseDialogOnceYesTapped) Get.back();
                  },
                ),
              ),
            ],
          )
        ],
      ),
      barrierDismissible: false,
    );
  }

  /* <--------  Actionable Dialog --------> */
  static Future<Object?> showActionableDialog(
      {String? titleText,
      required String messageText,
      Color titleTextColor = AppColors.errorColor,
      String? buttonText,
      int? waitTime,
      bool barrierDismissible = true,
      void Function()? onTap}) async {
    return await Get.dialog(
        barrierDismissible: barrierDismissible,
        AlertDialogWidget(
          backgroundColor: AppColors.errorColor,
          titleWidget: Text(
              titleText ??
                  AppLanguageTranslation.errorTransKey.toCurrentLanguage,
              style: AppTextStyles.titleSmallSemiboldTextStyle
                  .copyWith(color: titleTextColor),
              textAlign: TextAlign.center),
          contentWidget: Text(messageText,
              style: AppTextStyles.bodyLargeSemiboldTextStyle),
          actionWidgets: [
            CustomStretchedTextButtonWidget(
              buttonText: buttonText ??
                  AppLanguageTranslation.okTransKey.toCurrentLanguage,
              // backgroundColor: AppColors.alertColor,
              onTap: onTap,
            )
          ],
        ));
  }

  /* <--------  Image Processing Dialog --------> */
  static Future<Object?> showImageProcessingDialog() async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              AppLanguageTranslation.imageProcessingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }

  /* <-------- Processing Dialog --------> */
  static Future<Object?> showProcessingDialog({String? message}) async {
    return await Get.dialog(
        AlertDialogWidget(
          titleWidget: Text(
              message ??
                  AppLanguageTranslation.processingTransKey.toCurrentLanguage,
              style: AppTextStyles.headlineLargeBoldTextStyle,
              textAlign: TextAlign.center),
          contentWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              AppGaps.hGap16,
              Text(AppLanguageTranslation.pleaseWaitTransKey.toCurrentLanguage),
            ],
          ),
        ),
        barrierDismissible: false);
  }
}
