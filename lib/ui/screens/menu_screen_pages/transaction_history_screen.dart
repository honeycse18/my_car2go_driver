// import 'package:car2godriver/controller/introscreen_controller.dart';
import 'package:car2godriver/controller/menu_screen_controller/transaction_history_screen_controller.dart';
import 'package:car2godriver/models/api_responses/wallet_details.dart';
import 'package:car2godriver/models/api_responses/wallet_history_response.dart';
import 'package:car2godriver/ui/bottomsheets/wallet/transaction_details/wallet_transaction_details_bottomsheet.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/double.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/utils/helpers/helpers.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:car2godriver/ui/widgets/screen_widget/wallet_screen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //  var valueChoose = "-1";
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<TransactionHistoryScreenController>(
      init: TransactionHistoryScreenController(),
      global: true,
      builder: (controller) => CustomScaffold(
        /* <-------- AppBar --------> */
        appBar: CoreWidgets.appBarWidget(
          screenContext: context,
          titleText:
              AppLanguageTranslation.allTransactionTransKey.toCurrentLanguage,
          hasBackButton: true,
        ),
        /* <-------- Body Content --------> */
        /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
        body: ScaffoldBodyWidget(
            child: RefreshIndicator(
          onRefresh: () async =>
              controller.transactionHistoryPagingController.refresh(),
          child: CustomScrollView(
            slivers: [
              /* <-------- 24px height gap --------> */
              const SliverToBoxAdapter(
                child: AppGaps.hGap24,
              ),
              SliverToBoxAdapter(
                child: Text(
                  AppLanguageTranslation.transactionsTransKey.toCurrentLanguage,
                  style: AppTextStyles.titleSemiSmallSemiboldTextStyle,
                ),
              ),
              /* <-------- 20px height gap --------> */
              const SliverToBoxAdapter(
                child: AppGaps.hGap20,
              ),

              /* <-------- Transaction history list --------> */
              PagedSliverList.separated(
                pagingController: controller.transactionHistoryPagingController,
                builderDelegate: PagedChildBuilderDelegate<WalletTransaction>(
                    noItemsFoundIndicatorBuilder: (context) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      EmptyScreenWidget(
                          localImageAssetURL: AppAssetImages.confirmIconImage,
                          title: AppLanguageTranslation
                              .youHaveNoTransactionHistoryTransKey
                              .toCurrentLanguage,
                          shortTitle: '')
                    ],
                  );
                }, itemBuilder: (context, item, index) {
                  final WalletTransaction transactionHistoryList = item;
                  return TransactionListWidget(
                    onTap: () => Get.bottomSheet(
                        const WalletTransactionDetailsBottomSheet(),
                        settings:
                            RouteSettings(arguments: transactionHistoryList)),
                    dateTime: transactionHistoryList.createdAt,
                    title: transactionHistoryList.mode,
                    text1: transactionHistoryList.status,
                    text2: transactionHistoryList.amount
                        .getCurrencyFormattedText(),
                    type: transactionHistoryList.type,
                  );
                }),
                separatorBuilder: (context, index) => AppGaps.hGap16,
              )
            ],
          ),
        )),
      ),
    );
  }
}
