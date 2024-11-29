import 'package:car2godriver/controller/menu_screen_controller/wallet_screen_controller.dart';
import 'package:car2godriver/models/api_responses/site_settings.dart';
import 'package:car2godriver/models/api_responses/wallet_history_response.dart';
import 'package:car2godriver/ui/bottomsheets/wallet/select_withdraw_method/select_wallet_withdraw_method_bottomsheet.dart';
import 'package:car2godriver/ui/bottomsheets/wallet/transaction_details/wallet_transaction_details_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:car2godriver/ui/widgets/screen_widget/wallet_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<WalletScreenController>(
        init: WalletScreenController(),
        global: true,
        builder: (controller) => Scaffold(
              /* appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleText:
                      AppLanguageTranslation.walletTransKey.toCurrentLanguage,
                  hasBackButton: true), */
              /* <-------- Body Content --------> */
              body: Container(
                height: screenHeight,
                // clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: AppColors.backgroundColor,
                ),
                child: Stack(alignment: Alignment.topCenter, children: [
                  Positioned(
                    top: -2,
                    left: -2,
                    right: -2,
                    child: Container(
                      // height: screenHeight * 0.235,
                      height: 250,
                      decoration: const ShapeDecoration(
                        color: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(15),
                            bottomRight: Radius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned.fill(
                      child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                              margin: const EdgeInsets.only(top: 108),
                              // height: screenHeight * 0.85,
                              decoration: const ShapeDecoration(
                                color: AppColors.primaryButtonColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(30),
                                    topRight: Radius.circular(30),
                                  ),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 20),
                                child: Column(
                                  children: [
                                    /* <-------- 60px height gap --------> */
                                    AppGaps.hGap60,
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                height: 55,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .secondaryFont2Color)),
                                                child: RawButtonWidget(
                                                    borderRadiusValue: 8.0,
                                                    backgroundColor: AppColors
                                                        .primaryButtonColor,
                                                    onTap: () async {
                                                      final result =
                                                          await Get.bottomSheet(
                                                              const SelectWalletWithdrawMethodBottomSheet());
                                                      if (result
                                                          is SettingsWithdrawMethodsInfo) {
                                                        Get.toNamed(
                                                            AppPageNames
                                                                .walletWithdrawScreen,
                                                            arguments: result);
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              15.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SvgPictureAssetWidget(
                                                            AppAssetImages
                                                                .withdrawSVGLogoLine,
                                                            color: AppColors
                                                                .primaryColor,
                                                          ),
                                                          /* <-------- 10px width gap --------> */
                                                          AppGaps.wGap8,
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                AppLanguageTranslation
                                                                    .withdrawTransKey
                                                                    .toCurrentLanguage,
                                                                style: AppTextStyles
                                                                    .bodyLargeSemiboldTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .primaryColor),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                            /* <-------- 15px weight gap --------> */
                                            AppGaps.wGap16,
                                            Expanded(
                                              child: Container(
                                                height: 55,
                                                width: 160,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .secondaryFont2Color)),
                                                child: RawButtonWidget(
                                                    borderRadiusValue: 8.0,
                                                    backgroundColor:
                                                        AppColors.primaryColor,
                                                    onTap: () async {
                                                      await Get.toNamed(
                                                          AppPageNames
                                                              .topUpScreen);
                                                      controller
                                                          .getWalletDetails();
                                                      controller.update();
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          const SvgPictureAssetWidget(
                                                            AppAssetImages
                                                                .topUpSVGLogoLine,
                                                            color: AppColors
                                                                .secondaryColor,
                                                          ),
                                                          /* <-------- 10px width gap --------> */
                                                          AppGaps.wGap8,
                                                          Expanded(
                                                            child: Center(
                                                              child: Text(
                                                                AppLanguageTranslation
                                                                    .topUpTransKey
                                                                    .toCurrentLanguage,
                                                                maxLines: 1,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                style: AppTextStyles
                                                                    .bodyLargeSemiboldTextStyle
                                                                    .copyWith(
                                                                        color: AppColors
                                                                            .secondaryColor),
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ),
                                          ]),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            AppLanguageTranslation
                                                .transactionsTransKey
                                                .toCurrentLanguage,
                                            style: AppTextStyles
                                                .titleBoldTextStyle),
                                        Container(
                                          alignment: Alignment.bottomCenter,
                                          child: GestureDetector(
                                            onTap: () {
                                              Get.toNamed(AppPageNames
                                                  .transactionHistoryScreen);
                                            },
                                            child: RichText(
                                              text: TextSpan(
                                                  text: AppLanguageTranslation
                                                      .seeAllTransKey
                                                      .toCurrentLanguage,
                                                  style: AppTextStyles
                                                      .bodySmallSemiboldTextStyle
                                                      .copyWith(
                                                          decoration:
                                                              TextDecoration
                                                                  .underline,
                                                          color: AppColors
                                                              .primaryColor)),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    /* <-------- 10px height gap --------> */
                                    AppGaps.hGap10,
                                    Expanded(
                                        child: RefreshIndicator(
                                            onRefresh: () async => controller
                                                .getWalletDetails(),
                                            child: /* PagedListView.separated(
                                        pagingController: controller
                                            .transactionHistoryPagingController,
                                        builderDelegate:
                                            PagedChildBuilderDelegate<
                                                    TransactionHistoryItems>(
                                                noItemsFoundIndicatorBuilder:
                                                    (context) {
                                          return Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              EmptyScreenWidget(
                                                //-----------------------
                                                localImageAssetURL:
                                                    AppAssetImages
                                                        .confirmIconImage,
                                                title: AppLanguageTranslation
                                                    .noTransactionTranskey
                                                    .toCurrentLanguage,
                                                shortTitle: AppLanguageTranslation
                                                    .youHaveNoTransactionYetTranskey
                                                    .toCurrentLanguage,
                                              )
                                            ],
                                          );
                                        }, itemBuilder:
                                                    (context, item, index) {
                                          final TransactionHistoryItems
                                              transactionHistoryList = item;
                                          return TransactionListWidget(
                                            dateTime: transactionHistoryList
                                                .createdAt,
                                            title: controller.formatTitle(
                                                transactionHistoryList.type),
                                            text1:
                                                transactionHistoryList.method,
                                            text2: Helper
                                                .getCurrencyFormattedWithDecimalAmountText(
                                                    transactionHistoryList
                                                        .amount),
                                            type: transactionHistoryList.type,
                                          );
                                        }),
                                        separatorBuilder: (context, index) =>
                                            AppGaps.hGap16,
                                      ), */
                                                controller.isLoading
                                                    ? const Center(
                                                        child:
                                                            CircularProgressIndicator())
                                                    : controller
                                                            .walletDetails
                                                            .transactions
                                                            .isEmpty
                                                        ? SingleChildScrollView(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                        100),
                                                            child: Column(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .center,
                                                              children: [
                                                                EmptyScreenWidget(
                                                                  //-----------------------
                                                                  localImageAssetURL:
                                                                      AppAssetImages
                                                                          .confirmIconImage,
                                                                  title: AppLanguageTranslation
                                                                      .noTransactionTranskey
                                                                      .toCurrentLanguage,
                                                                  shortTitle: AppLanguageTranslation
                                                                      .youHaveNoTransactionYetTranskey
                                                                      .toCurrentLanguage,
                                                                )
                                                              ],
                                                            ),
                                                          )
                                                        : ListView.separated(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                        100),
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final transactionHistoryList =
                                                                  controller
                                                                      .walletDetails
                                                                      .transactions[index];
                                                              return TransactionListWidget(
                                                                onTap: () => Get.bottomSheet(
                                                                    const WalletTransactionDetailsBottomSheet(),
                                                                    settings: RouteSettings(
                                                                        arguments:
                                                                            transactionHistoryList)),
                                                                dateTime:
                                                                    transactionHistoryList
                                                                        .createdAt,
                                                                title:
                                                                    transactionHistoryList
                                                                        .mode,
                                                                text1:
                                                                    transactionHistoryList
                                                                        .status,
                                                                text2: transactionHistoryList
                                                                    .amount
                                                                    .getCurrencyFormattedText(),
                                                                type:
                                                                    transactionHistoryList
                                                                        .type,
                                                              );
                                                            },
                                                            separatorBuilder:
                                                                (context,
                                                                        index) =>
                                                                    const VerticalGap(
                                                                        16),
                                                            itemCount: controller
                                                                .walletDetails
                                                                .transactions
                                                                .length)
                                            /* CustomScrollView(
                                        slivers: [
                                          PagedSliverList.separated(
                                            
                                          ),
                                          const SliverToBoxAdapter(
                                            child: AppGaps.hGap80,
                                          )
                                        ],
                                      ), */
                                            ))
                                  ],
                                ),
                              )))),
                  Positioned(
                    top: 15,
                    left: 0,
                    right: 0,
                    child: SidePaddedWidget(
                      padding: 12,
                      child: Container(
                        // height: screenHeight * 0.18,
                        height: 158,
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage(
                                    AppAssetImages.transactionStatus),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12)),
                        child: Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              // controller.walletDetails.balance .toStringAsFixed(2),
                              controller.walletDetails.currentBalance.total
                                  .getCurrencyFormattedText(),
                              style: AppTextStyles.titleExtraLargeBoldTextStyle
                                  .copyWith(
                                      color: AppColors.primaryButtonColor),
                            ),
                            /* <-------- 6px height gap --------> */
                            AppGaps.hGap6,
                            /* <-------- Wallet Balance --------> */
                            Text(
                              AppLanguageTranslation
                                  .walletBalanceTranskey.toCurrentLanguage,
                              style: AppTextStyles.notificationBoldDateSection
                                  .copyWith(
                                      color: AppColors.primaryButtonColor),
                            )
                          ],
                        )),
                      ),
                    ),
                  ),
                ]),
              ),
            ));
  }
}
