import 'package:car2godriver/ui/widgets/core_widgets/spaces.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class DropdownButtonFormFieldWidget<T> extends StatelessWidget {
  const DropdownButtonFormFieldWidget({
    required this.hintText,
    required this.onChanged,
    super.key,
    this.value,
    this.prefixIcon,
    this.items,
    this.getItemText,
    this.prefixIconConstraints =
        const BoxConstraints(maxHeight: 48, maxWidth: 48),
    this.labelText,
    this.validator,
    this.controller,
    this.isLoading = false,
    this.getItemChild,
    this.isDense = true,
    this.lableIcon,
  });
  final T? value;
  final String hintText;
  final Widget? prefixIcon;
  final bool isLoading;
  final String? labelText;
  final Widget? lableIcon;
  final List<T>? items;
  final String Function(T item)? getItemText;
  final BoxConstraints prefixIconConstraints;
  final Widget Function(T item)? getItemChild;
  final void Function(T? selectedValue)? onChanged;
  final String? Function(T?)? validator;
  final TextEditingController? controller;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          Row(
            children: [
              if (lableIcon != null) lableIcon!,
              Text(
                labelText!,
              ),
            ],
          ),
        if (labelText != null) const VerticalGap(12),
        Builder(
          builder: (context) {
            return DropdownButtonFormField<T>(
              isExpanded: true,
              isDense: isDense,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validator,
              value: value,
              hint: Text(hintText),
              decoration: InputDecoration(
                prefixIconConstraints: prefixIconConstraints,
                prefixIcon: prefixIcon != null
                    ? Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: prefixIcon,
                      )
                    : null,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
              ),
              items: items
                  ?.map(
                    (e) => DropdownMenuItem(
                        value: e, child: _getItemChildWidget(e)),
                  )
                  .toList(),
              onChanged: onChanged,
            );
          },
        ),
      ],
    );
  }

  Widget _getItemChildWidget(T element) {
    if (getItemChild != null) {
      return getItemChild!(element);
    }
    if (getItemText != null) {
      return Text(getItemText!(element));
    }
    return const SizedBox.shrink();
  }

  bool get isDisabled =>
      onChanged == null || (items == null || (items?.isEmpty ?? true));
}

class LoadingImagePlaceholderWidget extends StatelessWidget {
  const LoadingImagePlaceholderWidget({
    super.key,
    this.height,
    this.width,
    required this.loadingAssetImageLocation,
    required this.baseColor,
    required this.highlightColor,
  });
  final double? height;
  final double? width;
  final String loadingAssetImageLocation;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: LoadingPlaceholderWidget(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Image.asset(loadingAssetImageLocation),
      ),
    );
  }
}

class LoadingPlaceholderWidget extends StatelessWidget {
  const LoadingPlaceholderWidget({
    required this.child,
    super.key,
    required this.baseColor,
    required this.highlightColor,
  });
  final Widget child;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: child,
    );
  }
}

class CenterLoaderWidget extends StatelessWidget {
  const CenterLoaderWidget({
    required this.loading,
    required this.child,
    super.key,
  });
  final bool loading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Stack(
        children: [
          child,
          const Opacity(
            opacity: 0.3,
            child: ModalBarrier(dismissible: false, color: Colors.black),
          ),
          const CenterLoaderChildWidget(),
        ],
      );
    }
    return child;
  }
}

class CenterLoaderChildWidget extends StatelessWidget {
  const CenterLoaderChildWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
