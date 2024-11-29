/* class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RequestScreenController>(
        global: false,
        init: RequestScreenController(),
        builder: (controller) => Scaffold(
                        /* <-------- AppBar --------> */
              appBar: AppBar(
                actions: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SvgPictureAssetWidget(AppAssetImages.drawerSVGLogoLine),
                      Text(AppLanguageTranslation
                          .requestTransKey.toCurrentLanguage),
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
}
 */
