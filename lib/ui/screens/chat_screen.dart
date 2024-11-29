import 'package:car2godriver/controller/chat_screen_controller.dart';
import 'package:car2godriver/models/api_responses/chat_message_list_response.dart';
import 'package:car2godriver/utils/constants/app_colors.dart';
import 'package:car2godriver/utils/constants/app_components.dart';
import 'package:car2godriver/utils/constants/app_gaps.dart';
import 'package:car2godriver/utils/constants/app_images.dart';
import 'package:car2godriver/utils/constants/app_text_styles.dart';
import 'package:car2godriver/ui/widgets/chat_screen_widgets.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:super_tooltip/super_tooltip.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomInsetPaddingValue = MediaQuery.of(context).viewInsets.bottom;
    /* <-------- Initialize Screen Controller  --------> */
    return GetBuilder<ChatScreenController>(
        init: ChatScreenController(),
        builder: (controller) => CustomScaffold(
              /* <-------- AppBar --------> */
              appBar: CoreWidgets.appBarWidget(
                automaticallyImplyLeading: false,
                screenContext: context,
                titleText: controller.getUser.name,
                hasBackButton: true,
                actions: [
                  SuperTooltip(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 250,
                          width: 250,
                          /* <-------- Fetch user image from API --------> */
                          child: CachedNetworkImageWidget(
                            imageURL: controller.getUser.image,
                            imageBuilder: (context, imageProvider) => Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: AppComponents.imageBorderRadius,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover)),
                            ),
                          ),
                        ),
                        /* <-------- 10px height gap --------> */
                        AppGaps.hGap10,
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              controller.getUser.name,
                              style: AppTextStyles.bodyLargeMediumTextStyle,
                            ),
                            /* <-------- 8px width gap --------> */
                            AppGaps.wGap8,
                            Text(
                              '(${controller.getUser.role})',
                              style: AppTextStyles.bodyTextStyle
                                  .copyWith(color: AppColors.bodyTextColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    child: SizedBox(
                      height: 30,
                      width: 30,
                      /* <-------- Fetch user image from API --------> */
                      child: CachedNetworkImageWidget(
                        imageURL: controller.getUser.image,
                        imageBuilder: (context, imageProvider) => Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ),
                  /* <-------- 15px width gap --------> */
                  AppGaps.wGap15,
                ],
              ),
              /* <-------- Body Content --------> */
              body: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  children: [
                    Expanded(
                      /* <-------- ScaffoldBodyWidget used for Side padding for scaffold body contents  --------> */
                      child: ScaffoldBodyWidget(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            /* <-------- Chat message list item --------> */
                            Expanded(
                              child: PagedListView.separated(
                                  reverse: true,
                                  pagingController:
                                      controller.chatMessagePagingController,
                                  builderDelegate: PagedChildBuilderDelegate<
                                          ChatMessageListItem>(
                                      noItemsFoundIndicatorBuilder: (context) {
                                    return Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          height: 65,
                                          width: 65,
                                          /* <-------- Fetch user image from API --------> */
                                          child: CachedNetworkImageWidget(
                                            imageURL: controller.getUser.image,
                                            imageBuilder:
                                                (context, imageProvider) =>
                                                    Container(
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                  borderRadius: AppComponents
                                                      .imageBorderRadius,
                                                  image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover)),
                                            ),
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              controller.getUser.name,
                                              style: AppTextStyles
                                                  .bodyLargeSemiboldTextStyle,
                                            ),
                                            /* <-------- 5px width gap --------> */
                                            AppGaps.wGap5,
                                            Text('(${controller.getUser.role})',
                                                style: AppTextStyles
                                                    .bodyTextStyle
                                                    .copyWith(
                                                  color:
                                                      AppColors.bodyTextColor,
                                                )),
                                          ],
                                        ),
                                      ],
                                    );
                                  }, itemBuilder: (context, item, index) {
                                    final ChatMessageListItem chatMessage =
                                        item;
                                    return ChatDeliveryManScreenWidgets
                                        .getCustomDeliveryChatWidget(
                                            image: chatMessage.from.image,
                                            name: chatMessage.from.name,
                                            dateTime: chatMessage.createdAt,
                                            message: chatMessage.message,
                                            isMyMessage: controller
                                                .isMyChatMessage(chatMessage));
                                  }),
                                  separatorBuilder: (context, index) =>
                                      AppGaps.hGap24),
                            ),
                            /* <-------- 20px height gap --------> */
                            AppGaps.hGap20,
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding: AppGaps.bottomNavBarPadding
                    .copyWith(bottom: 15 + bottomInsetPaddingValue),
                /* <---- Chat message text field ----> */
                child: CustomTextFormField(
                  controller: controller.messageController,
                  hintText: 'Type your message',
                  suffixIcon: CustomIconButtonWidget(
                    onTap: () {
                      controller.sendMessage(controller.chatUserId);
                    },
                    child: SvgPicture.asset(
                      AppAssetImages.sendIconSvgLogoLine,
                      height: 24,
                      width: 24,
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(maxHeight: 48),
                  prefixIcon: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      /* <---- Attachment icon button ----> */
                      CustomIconButtonWidget(
                        child: SvgPicture.asset(
                          AppAssetImages.attachmentSVGLogoLine,
                          height: 20,
                          width: 20,
                          color: AppColors.bodyTextColor,
                        ),
                        onTap: () {},
                      ),
                      AppGaps.wGap8,

                      /* <---- Camera icon button ----> */
                      CustomIconButtonWidget(
                        child: SvgPicture.asset(
                          AppAssetImages.cameraButtonSVGLogoLine,
                          height: 20,
                          width: 20,
                          color: AppColors.bodyTextColor,
                        ),
                        onTap: () {},
                      ),
                      /* <-------- 8px width gap --------> */
                    ],
                  ),
                ),
              ),
            ));
  }
}
