import 'package:car2godriver/ui/dialogs/vehicle_year_picker/vehicle_year_picker_dialog_controller.dart';
import 'package:car2godriver/ui/widgets/core_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VehicleYearPickerDialog extends StatelessWidget {
  const VehicleYearPickerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<VehicleYearPickerDialogController>(
        init: VehicleYearPickerDialogController(),
        global: false,
        builder: (controller) => AlertDialogWidget(
              titleWidget: const Center(child: Text('Select vehicle year')),
              contentWidget: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: context.height / 3,
                    width: context.width,
                    child: YearPicker(
                      firstDate: controller.firstDate,
                      lastDate: controller.lastDate,
                      selectedDate: controller.selectedYear,
                      currentDate: controller.selectedYear,
                      onChanged: controller.onDateChanged,
                    ),
                  ),
                ],
              ),
              actionWidgets: [
                CustomStretchedTextButtonWidget(
                  minimumSize: const Size.fromHeight(20),
                  buttonText: 'Close',
                  onTap: () {
                    Get.back();
                  },
                ),
              ],
            ));
  }
}
