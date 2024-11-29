import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';

import 'spaces.dart';

/// Custom TextFormField configured with Theme.
class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.textInputType,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.validator,
    this.autoValidatorMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onSubmit,
    this.lableIcon,
    this.isDisabled = false,
    this.maxLength,
  });
  final String? labelText;
  final Widget? lableIcon;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isDisabled;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final TextInputType? textInputType;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode autoValidatorMode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: isReadOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      obscureText: isPasswordTextField,
      maxLength: maxLength,
      keyboardType: textInputType,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      autovalidateMode: autoValidatorMode,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: hintText,
        labelText: labelText,
        // fillColor: isDisabled ? Colors.black.withOpacity(0.05) : Colors.white,
        prefixIconConstraints: prefixIconConstraints,
        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class EmailTextFormFieldWidget extends StatelessWidget {
  const EmailTextFormFieldWidget({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.validator,
    this.autoValidatorMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onSubmit,
    this.lableIcon,
    this.isDisabled = false,
    this.maxLength,
  });
  final String? labelText;
  final Widget? lableIcon;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isDisabled;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode autoValidatorMode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: isReadOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      obscureText: isPasswordTextField,
      maxLength: maxLength,
      keyboardType: TextInputType.emailAddress,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      autovalidateMode: autoValidatorMode,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: hintText,
        labelText: labelText,
        // fillColor: isDisabled ? Colors.black.withOpacity(0.05) : Colors.white,
        prefixIconConstraints: prefixIconConstraints,
        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class PhoneTextFormFieldWidget extends StatelessWidget {
  const PhoneTextFormFieldWidget({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.validator,
    this.autoValidatorMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onSubmit,
    this.lableIcon,
    this.isDisabled = false,
    this.maxLength,
  });
  final String? labelText;
  final Widget? lableIcon;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isDisabled;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode autoValidatorMode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: isReadOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      obscureText: isPasswordTextField,
      maxLength: maxLength,
      keyboardType: TextInputType.phone,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      autovalidateMode: autoValidatorMode,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: hintText,
        labelText: labelText,
        // fillColor: isDisabled ? Colors.black.withOpacity(0.05) : Colors.white,
        prefixIconConstraints: prefixIconConstraints,
        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixIcon,
      ),
    );
  }
}

class PhoneCountryCodeTextFormFieldWidget extends StatelessWidget {
  const PhoneCountryCodeTextFormFieldWidget({
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.isPasswordTextField = false,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.validator,
    this.autoValidatorMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onSubmit,
    this.lableIcon,
    this.isDisabled = false,
    this.maxLength,
    required this.initialCountryCode,
    this.onCountryChanged,
  });
  final String? labelText;
  final Widget? lableIcon;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isDisabled;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode autoValidatorMode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;

  final CountryCode initialCountryCode;
  final void Function(CountryCode selectedCountry)? onCountryChanged;

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CountryCodePicker(
          onChanged: onCountryChanged,
          initialSelection: initialCountryCode.code,
          builder: (country) {
            if (country == null) {}
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border:
                    Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      right: 16,
                    ),
                    child: Image.asset(
                      country!.flagUri!,
                      package: 'country_code_picker',
                      width: 32,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      country.toLongString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 8,
                    ),
                    child: RotatedBox(
                      quarterTurns: 1,
                      child: Icon(
                        Icons.chevron_right_rounded,
                        size: 32,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        const VerticalGap(10),
        TextFormField(
          controller: controller,
          onTap: onTap,
          readOnly: isReadOnly,
          onChanged: onChanged,
          onFieldSubmitted: onSubmit,
          obscureText: isPasswordTextField,
          maxLength: maxLength,
          keyboardType: TextInputType.phone,
          validator: validator,
          minLines: minLines,
          maxLines: maxLines,
          autovalidateMode: autoValidatorMode,
          decoration: InputDecoration(
            errorMaxLines: 2,
            hintText: hintText,
            labelText: labelText,
            // fillColor: isDisabled ? Colors.black.withOpacity(0.05) : Colors.white,
            prefixIconConstraints: prefixIconConstraints,
            prefixIcon: prefixIcon,
            // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
            suffixIconConstraints: suffixIconConstraints,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

class PasswordTextFormFieldWidget extends StatelessWidget {
  const PasswordTextFormFieldWidget({
    required this.isPasswordTextField,
    super.key,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.hasShadow = false,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.suffixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.isReadOnly = false,
    this.controller,
    this.minLines,
    this.maxLines = 1,
    this.onTap,
    this.validator,
    this.autoValidatorMode = AutovalidateMode.onUserInteraction,
    this.onChanged,
    this.onSubmit,
    this.lableIcon,
    this.isDisabled = false,
    this.maxLength,
    this.onPasswordVisibilityIconButtonTap,
  });
  final String? labelText;
  final Widget? lableIcon;
  final String? hintText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPasswordTextField;
  final bool hasShadow;
  final bool isDisabled;
  final bool isReadOnly;
  final BoxConstraints prefixIconConstraints;
  final BoxConstraints suffixIconConstraints;
  final TextEditingController? controller;
  final int? minLines;
  final int maxLines;
  final int? maxLength;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final AutovalidateMode autoValidatorMode;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmit;
  final void Function(bool changedPasswordVisibility)?
      onPasswordVisibilityIconButtonTap;

  @override
  Widget build(BuildContext context) {
    // If label text is not null, then show label as a separate Text widget
    // wrapped inside column widget.
    // Else, just return the TextFormField widget.
    return TextFormField(
      controller: controller,
      onTap: onTap,
      readOnly: isReadOnly,
      onChanged: onChanged,
      onFieldSubmitted: onSubmit,
      obscureText: isPasswordTextField,
      maxLength: maxLength,
      keyboardType: isPasswordTextField
          ? TextInputType.visiblePassword
          : TextInputType.text,
      validator: validator,
      minLines: minLines,
      maxLines: maxLines,
      autovalidateMode: autoValidatorMode,
      decoration: InputDecoration(
        errorMaxLines: 2,
        hintText: hintText,
        labelText: labelText,
        // fillColor: isDisabled ? Colors.black.withOpacity(0.05) : Colors.white,
        prefixIconConstraints: prefixIconConstraints,
        prefixIcon: prefixIcon,
        // contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 14),
        suffixIconConstraints: suffixIconConstraints,
        suffixIcon: suffixIcon ??
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: IconButton(
                icon: Icon(
                  isPasswordTextField
                      ? Icons.visibility_off_rounded
                      : Icons.visibility_rounded,
                  size: 24,
                ),
                onPressed: () => onPasswordVisibilityIconButtonTap
                    ?.call(!isPasswordTextField),
              ),
            ),
      ),
    );
  }
}
