import 'package:car2godriver/controller/payment_method_screen_controller.dart';
import 'package:car2godriver/models/api_responses/get_withdraw_saved_methods.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_page_names.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PaymentMethodScreen extends StatelessWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentMethodScreenController>(
        global: false,
        init: PaymentMethodScreenController(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.backgroundColor,
              appBar: CoreWidgets.appBarWidget(
                  screenContext: context,
                  titleWidget: const Text('Payment Method')),
              body: ScaffoldBodyWidget(
                child: RefreshIndicator(
                  onRefresh: () async {
                    return controller.getWithdrawMethod();
                  },
                  child: CustomScrollView(
                    slivers: [
                      const SliverToBoxAdapter(
                        child: AppGaps.hGap10,
                      ),
                      SliverList.separated(
                        itemCount: controller.withdrawMethods.length,
                        itemBuilder: (context, index) {
                          WithdrawMethodsItem withdrawMethod =
                              controller.withdrawMethods[index];
                          return PaymentWithdrawMethod(
                            onDeleteTap: () =>
                                controller.deleteCard(withdrawMethod.id),
                            id: withdrawMethod.id,
                            accountType: withdrawMethod.type,
                            accountName: withdrawMethod.details.accountName,
                            accountEmail: withdrawMethod.details.accountEmail,
                            cardName: withdrawMethod.details.cardName,
                            cardNumber: withdrawMethod.details.cardNumber,
                            cardExpiry: withdrawMethod.details.cardExpiry,
                            cardCvvNumber: withdrawMethod.details.cardCvvNumber,
                            postalCode: withdrawMethod.details.postalCode,
                            bankAccountName:
                                withdrawMethod.details.bankAccountName,
                            bankName: withdrawMethod.details.bankName,
                            branchCode: withdrawMethod.details.branchCode,
                            accountNumber: withdrawMethod.details.accountNumber,
                          );
                        },
                        separatorBuilder: (context, index) => AppGaps.hGap16,
                      ),
                      const SliverToBoxAdapter(
                        child: AppGaps.hGap50,
                      ),
                    ],
                  ),
                ),
              ),
              floatingActionButton: controller.withdrawMethods.length < 3
                  ? SpeedDial(
                      visible: true,
                      animatedIcon: AnimatedIcons.add_event,
                      curve: Curves.bounceOut,
                      overlayColor: Colors.black,
                      overlayOpacity: 0.75,
                      onOpen: () {
                        print('Opened');
                      },
                      onClose: () => print('Closed'),
                      tooltip: 'Actions',
                      heroTag: 'speed-dial-hero-tag',
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 8.0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      children: [
                        controller.withdrawMethods
                                .any((method) => method.type == 'paypal')
                            ? SpeedDialChild()
                            : SpeedDialChild(
                                child: const Icon(Icons.paypal),
                                backgroundColor: Colors.blue,
                                label: 'PayPal',
                                onTap: () async {
                                  await Get.toNamed(
                                      AppPageNames.paymentMethodPaypalScreen);
                                  await controller.getWithdrawMethod();
                                  controller.update();
                                },
                              ),
                        controller.withdrawMethods
                                .any((method) => method.type == 'card')
                            ? SpeedDialChild()
                            : SpeedDialChild(
                                child: const Icon(Icons.credit_card),
                                backgroundColor: Colors.red,
                                label: 'Card',
                                onTap: () async {
                                  await Get.toNamed(
                                      AppPageNames.paymentMethodCardScreen);
                                  await controller.getWithdrawMethod();
                                  controller.update();
                                },
                              ),
                        controller.withdrawMethods
                                .any((method) => method.type == 'bank')
                            ? SpeedDialChild()
                            : SpeedDialChild(
                                child: const Icon(Icons.account_balance),
                                backgroundColor: Colors.green,
                                label: 'Bank',
                                onTap: () async {
                                  await Get.toNamed(
                                      AppPageNames.paymentMethodBankScreen);
                                  await controller.getWithdrawMethod();
                                  controller.update();
                                },
                              ),
                      ],
                    )
                  : null,
            ));
  }
}

class PaymentWithdrawMethod extends StatelessWidget {
  final String id;
  final String accountType;
  final String accountName;
  final String accountEmail;
  final String cardName;
  final String cardNumber;
  final String cardExpiry;
  final String cardCvvNumber;
  final String postalCode;
  final String bankAccountName;
  final String bankName;
  final String branchCode;
  final String accountNumber;
  final void Function()? onDeleteTap;
  const PaymentWithdrawMethod({
    super.key,
    required this.id,
    required this.accountType,
    required this.accountName,
    required this.accountEmail,
    required this.cardName,
    required this.cardNumber,
    required this.cardExpiry,
    required this.cardCvvNumber,
    required this.postalCode,
    required this.bankAccountName,
    required this.bankName,
    required this.branchCode,
    required this.accountNumber,
    this.onDeleteTap,
  });
  String getFormattedDate(String date) {
    DateTime parsedDate = DateTime.parse(date);
    return DateFormat('dd MMM, yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return accountType == 'paypal'
        ? Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 5,
            margin: const EdgeInsets.all(5),
            child: Container(
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: const DecorationImage(
                  image: AssetImage(AppAssetImages.paypalPng),
                  opacity: 0.8,
                  fit: BoxFit.cover,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          height: 40,
                          width: 40,
                          child: CachedNetworkImageWidget(
                            imageURL:
                                'https://cdn.icon-icons.com/icons2/1195/PNG/512/1490889684-paypal_82515.png',
                            imageBuilder: (context, imageProvider) => Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: AppComponents.imageBorderRadius,
                                  image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.contain)),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            RawButtonWidget(
                              onTap: () {
                                Get.toNamed(
                                    AppPageNames.paymentMethodPaypalScreen,
                                    arguments: id);
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ),
                            AppGaps.wGap15,
                            /* RawButtonWidget(
                              onTap: onDeleteTap,
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ) */
                          ],
                        )
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          accountName.toUpperCase(),
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        AppGaps.hGap10,
                        Text(
                          accountEmail,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )
        : accountType == 'card'
            ? Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: const EdgeInsets.all(5),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage(AppAssetImages.atm2Png),
                      opacity: 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Master Card',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            Row(
                              children: [
                                RawButtonWidget(
                                  onTap: () {
                                    Get.toNamed(
                                        AppPageNames.paymentMethodCardScreen,
                                        arguments: id);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                AppGaps.wGap15,
                                /* RawButtonWidget(
                                  onTap: onDeleteTap,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ) */
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cardNumber,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                            AppGaps.hGap10,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Cardholder Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  'Expiry Date',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  cardName.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  getFormattedDate(cardExpiry),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'CVV',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  cardCvvNumber,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Postal Code',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  postalCode,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                margin: const EdgeInsets.all(5),
                child: Container(
                  height: 220,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                      image: AssetImage(AppAssetImages.bankPng),
                      opacity: 0.8,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                RawButtonWidget(
                                  onTap: () {
                                    Get.toNamed(
                                        AppPageNames.paymentMethodBankScreen,
                                        arguments: id);
                                  },
                                  child: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                AppGaps.wGap15,
                                /* RawButtonWidget(
                                  onTap: onDeleteTap,
                                  child: const Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ),
                                ) */
                              ],
                            )
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    bankName.toUpperCase(),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            AppGaps.hGap15,
                            Text(
                              accountNumber.toUpperCase(),
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 2.0,
                              ),
                            ),
                            AppGaps.hGap10,
                            const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Account Name',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white70,
                                  ),
                                ),
                                Text(
                                  'Branch Code',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  bankAccountName.toUpperCase(),
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  branchCode,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
  }
}
