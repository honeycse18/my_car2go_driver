import 'dart:math';

import 'package:car2godriver/controller/menu_screen_controller/earning_screen_controller.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_language_translations.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/utils/extensions/datetime.dart';
import 'package:car2godriver/utils/extensions/string.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:collection/collection.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

// ignore: must_be_immutable
class EarningScreen extends StatelessWidget {
  EarningScreen({super.key});

  List<Color> gradientColors = [
    AppColors.contentColorGreen,
    AppColors.primaryColor,
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<EarningScreenController>(
        init: EarningScreenController(),
        global: false,
        builder: (controller) => CustomScaffold(
            /* <-------- AppBar --------> */
            appBar: CoreWidgets.appBarWidget(
              screenContext: context,
              titleText:
                  AppLanguageTranslation.earningTransKey.toCurrentLanguage,
              hasBackButton: true,
            ),
            /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
            body: ScaffoldBodyWidget(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                  /* <-------- 30px height gap --------> */
                  AppGaps.hGap30,
                  Expanded(
                      child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: AppColors.earningBoxColor,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text('\$0',
                                                style: AppTextStyles
                                                    .poppinsExtraLargeBoldTextStyle
                                                    .copyWith(
                                                        color: AppColors
                                                            .earningColor)),
                                            Row(children: [
                                              Text('Today',
                                                  style: AppTextStyles
                                                      .bodyMediumTextStyle
                                                      .copyWith(
                                                          color: AppColors
                                                              .primaryColor)),
                                              const Icon(
                                                Icons.arrow_drop_down,
                                                color: AppColors.primaryColor,
                                              ),
                                            ])
                                          ]),
                                      AppGaps.hGap2,
                                      Text('Total Earning',
                                          style: AppTextStyles.bodyTextStyle
                                              .copyWith(
                                                  color: AppColors
                                                      .primaryTextColor)),
                                    ],
                                  ),
                                ),
                                AppGaps.hGap33,
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Earnings',
                                      style: AppTextStyles
                                          .titleSemiSmallSemiboldTextStyle
                                          .copyWith(
                                              color:
                                                  AppColors.primaryTextColor),
                                    ),
                                    Row(children: [
                                      Text('Today',
                                          style: AppTextStyles
                                              .bodyMediumTextStyle
                                              .copyWith(
                                                  color:
                                                      AppColors.primaryColor)),
                                      const Icon(
                                        Icons.arrow_drop_down,
                                        color: AppColors.primaryColor,
                                      ),
                                    ])
                                  ],
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.start,
                                //   children: [
                                //     const Text(
                                //       'Date : ',
                                //       style: AppTextStyles.titleBoldTextStyle,
                                //     ),
                                //     AppGaps.wGap16,
                                //     Text(
                                //       Helper.ddMMyyyyFormattedDateTime(
                                //           controller.selectedDate),
                                //       style: AppTextStyles.titleBoldTextStyle,
                                //     ),
                                //   ],
                                // ),
                                // AppGaps.hGap16,
                                // Container(
                                //   margin: const EdgeInsets.only(top: 10),
                                //   child: DatePicker(
                                //     DateTime.now()
                                //         .subtract(const Duration(days: 60)),
                                //     height: 100,
                                //     width: 60,
                                //     daysCount: 61,
                                //     initialSelectedDate: DateTime.now(),
                                //     selectionColor: AppColors.primaryColor,
                                //     selectedTextColor:
                                //         AppColors.primaryButtonColor,
                                //     onDateChange: (selectedDate) {
                                //       // Update the selected date in controller
                                //       controller
                                //           .updateSelectedDate(selectedDate);
                                //       controller.update();
                                //     },
                                //   ),
                                // ),
                                Stack(
                                  children: <Widget>[
                                    AspectRatio(
                                      aspectRatio: 1.0,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          right: 10,
                                          top: 24,
                                          left: 5,
                                          bottom: 12,
                                        ),
                                        child: LineChart(LineChartData(
                                          gridData: FlGridData(
                                            show: true,
                                            drawVerticalLine: true,
                                            horizontalInterval: 1,
                                            verticalInterval: 1,
                                            getDrawingHorizontalLine: (value) {
                                              return const FlLine(
                                                color: AppColors
                                                    .primaryButtonColor,
                                                strokeWidth: 1,
                                              );
                                            },
                                            getDrawingVerticalLine: (value) {
                                              return const FlLine(
                                                color: AppColors.gridColor,
                                                strokeWidth: 1,
                                              );
                                            },
                                          ),
                                          titlesData: FlTitlesData(
                                            show: true,
                                            rightTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            topTitles: const AxisTitles(
                                              sideTitles:
                                                  SideTitles(showTitles: false),
                                            ),
                                            bottomTitles: AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: true,
                                                reservedSize: 30,
                                                interval: 1,
                                                // getTitlesWidget: bottomTitleWidgets,
                                                getTitlesWidget: (value, meta) {
                                                  try {
                                                    final earning = controller
                                                            .earningCartList[
                                                        value.toInt()];
                                                    const style = TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 16,
                                                    );
                                                    return SideTitleWidget(
                                                      axisSide: meta.axisSide,
                                                      child: Text(
                                                          earning.date
                                                              .formatted('EEE'),
                                                          style: style),
                                                    );
                                                  } catch (e) {
                                                    return SideTitleWidget(
                                                      axisSide: meta.axisSide,
                                                      child: const SizedBox
                                                          .shrink(),
                                                    );
                                                  }
                                                },
                                              ),
                                            ),
                                            leftTitles: const AxisTitles(
                                              sideTitles: SideTitles(
                                                showTitles: false,
                                                interval: 5,
                                                reservedSize: 12,
                                              ),
                                            ),
                                          ),
                                          minX: 0,
                                          maxX: controller
                                              .earningCartList.length
                                              .toDouble(),
                                          minY: 0,
                                          maxY: controller.earningCartList.fold(
                                              0,
                                              (previousValue, element) => max(
                                                  previousValue ?? 0,
                                                  element.trips.toDouble())),
                                          lineBarsData: [
                                            LineChartBarData(
                                              spots: controller.earningCartList
                                                  .mapIndexed(
                                                      (index, earning) =>
                                                          FlSpot(
                                                              index.toDouble(),
                                                              earning.trips
                                                                  .toDouble()))
                                                  .toList(),
                                              isCurved: true,
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.topCenter,
                                                colors: gradientColors,
                                              ),
                                              barWidth: 2,
                                              isStrokeCapRound: true,
                                              dotData: const FlDotData(
                                                show: false,
                                              ),
                                              belowBarData: BarAreaData(
                                                show: true,
                                                gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: gradientColors
                                                      .map((color) => color
                                                          .withOpacity(0.3))
                                                      .toList(),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Earnings History',
                                        style: AppTextStyles
                                            .titleSemiSmallSemiboldTextStyle),
                                    Container(
                                      alignment: Alignment.bottomCenter,
                                      child: GestureDetector(
                                        onTap: () {},
                                        child: RichText(
                                          text: TextSpan(
                                              text: AppLanguageTranslation
                                                  .seeAllTransKey
                                                  .toCurrentLanguage,
                                              style: AppTextStyles
                                                  .bodySmallSemiboldTextStyle
                                                  .copyWith(
                                                      decoration: TextDecoration
                                                          .underline,
                                                      color: AppColors
                                                          .primaryColor)),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ])))
                ]))));
  }
}
