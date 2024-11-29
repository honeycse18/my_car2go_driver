/* 
class UpcomingScreen extends StatelessWidget {
  const UpcomingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UpcomingScreenController>(
        global: false,
        init: UpcomingScreenController(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPictureAssetWidget(AppAssetImages.drawerSVGLogoLine),
                      Text(AppLanguageTranslation
                          .upComingTransKey.toCurrentLanguage),
                      SvgPictureAssetWidget(
                        AppAssetImages.notificationSVGLogoLine,
                        color: AppColors.bodyTextColor,
                      ),
                    ],
                  )
                ],
              ),
            ));
  }
} */
