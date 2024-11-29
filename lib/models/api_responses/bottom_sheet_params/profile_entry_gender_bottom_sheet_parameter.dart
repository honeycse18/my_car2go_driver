// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:car2godriver/models/enums/gender.dart';
import 'package:car2godriver/models/enums/api/profile_field_name.dart';

class ProfileEntryTextFieldBottomSheetParameter {
  final ProfileFieldName profileFieldName;
  final String initialValue;

  ProfileEntryTextFieldBottomSheetParameter({
    required this.profileFieldName,
    required this.initialValue,
  });
}

class ProfileEntryGenderBottomSheetParameter {
  final Gender profileGenderName;

  ProfileEntryGenderBottomSheetParameter({
    required this.profileGenderName,
  });
}

class ProfileEntrySingleImageBottomSheetParameter {
  final ProfileFieldName profileFieldName;
  final String image;

  ProfileEntrySingleImageBottomSheetParameter({
    required this.profileFieldName,
    required this.image,
  });
}

class ProfileEntryDoubleImageBottomSheetParameter {
  final ProfileFieldName profileFieldName;
  final String frontImage;
  final String backImage;

  ProfileEntryDoubleImageBottomSheetParameter({
    required this.profileFieldName,
    required this.frontImage,
    required this.backImage,
  });
}
