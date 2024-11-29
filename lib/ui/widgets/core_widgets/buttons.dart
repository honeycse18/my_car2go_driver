import 'package:flutter/material.dart';

import 'others.dart';

class TightOutlinedButtonWidget extends StatelessWidget {
  const TightOutlinedButtonWidget({
    required this.label,
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.baseColor,
    required this.highlightColor,
  });

  final void Function()? onTap;
  final String label;
  final bool isLoading;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingPlaceholderWidget(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(40, 30),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
            visualDensity: const VisualDensity(
              horizontal: VisualDensity.minimumDensity,
              vertical: VisualDensity.minimumDensity,
            ),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(40, 30),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
        visualDensity: const VisualDensity(
          horizontal: VisualDensity.minimumDensity,
          vertical: VisualDensity.minimumDensity,
        ),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class OutlinedButtonWidget extends StatelessWidget {
  const OutlinedButtonWidget({
    required this.label,
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.baseColor,
    required this.highlightColor,
  });

  final void Function()? onTap;
  final String label;
  final bool isLoading;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingPlaceholderWidget(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: OutlinedButton(
          onPressed: null,
          style: OutlinedButton.styleFrom(
            // minimumSize: const Size(40, 30),
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return OutlinedButton(
      onPressed: onTap,
      style: OutlinedButton.styleFrom(
        // minimumSize: const Size(40, 30),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
      ),
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class FilledButtonWidget extends StatelessWidget {
  const FilledButtonWidget({
    required this.label,
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.baseColor,
    required this.highlightColor,
  });

  final void Function()? onTap;
  final String label;
  final bool isLoading;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingFilledButtonWidget(
          baseColor: baseColor, highlightColor: highlightColor, label: label);
    }
    return FilledButton(
      onPressed: onTap,
      child: Text(
        label,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class IconedFilledButtonWidget extends StatelessWidget {
  const IconedFilledButtonWidget({
    required this.label,
    required this.icon,
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.baseColor,
    required this.highlightColor,
  });

  final void Function()? onTap;
  final String label;
  final Widget icon;
  final bool isLoading;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return LoadingIconedFilledButtonWidget(
          baseColor: baseColor,
          highlightColor: highlightColor,
          icon: icon,
          label: label);
    }
    return FilledButton.icon(
      onPressed: onTap,
      label: Text(
        label,
        textAlign: TextAlign.center,
      ),
      icon: icon,
    );
  }
}

class LoadingFilledButtonWidget extends StatelessWidget {
  const LoadingFilledButtonWidget({
    required this.label,
    super.key,
    required this.baseColor,
    required this.highlightColor,
  });

  final String label;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: FilledButtonWidget(
        baseColor: baseColor,
        highlightColor: highlightColor,
        label: label,
      ),
    );
  }
}

class LoadingIconedFilledButtonWidget extends StatelessWidget {
  const LoadingIconedFilledButtonWidget({
    required this.label,
    required this.icon,
    super.key,
    required this.baseColor,
    required this.highlightColor,
  });

  final String label;
  final Widget icon;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return LoadingPlaceholderWidget(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: IconedFilledButtonWidget(
        baseColor: baseColor,
        highlightColor: highlightColor,
        label: label,
        icon: icon,
      ),
    );
  }
}

class StretchedIconFilledButtonWidget extends StatelessWidget {
  const StretchedIconFilledButtonWidget({
    required this.label,
    required this.icon,
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.baseColor,
    required this.highlightColor,
  });

  final void Function()? onTap;
  final String label;
  final Widget icon;
  final bool isLoading;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: isLoading
              ? LoadingIconedFilledButtonWidget(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  label: label,
                  icon: icon)
              : IconedFilledButtonWidget(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  onTap: onTap,
                  label: label,
                  icon: icon,
                ),
        ),
      ],
    );
  }
}

class StretchedFilledButtonWidget extends StatelessWidget {
  const StretchedFilledButtonWidget({
    required this.label,
    super.key,
    this.onTap,
    this.isLoading = false,
    required this.baseColor,
    required this.highlightColor,
  });

  final void Function()? onTap;
  final String label;
  final bool isLoading;
  final Color baseColor;
  final Color highlightColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: isLoading
              ? LoadingFilledButtonWidget(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  label: label)
              : FilledButtonWidget(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  onTap: onTap,
                  label: label,
                ),
        ),
      ],
    );
  }
}

class DrawerButtonWidget extends StatelessWidget {
  const DrawerButtonWidget({
    required this.labelText,
    required this.icon,
    super.key,
    this.onTap,
  });

  final String labelText;
  final Widget icon;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton.icon(
            onPressed: onTap,
            label: Text(
              labelText,
            ),
            icon: icon,
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
      ],
    );
  }
}

/// Raw button widget
/* class RawButtonWidget extends StatelessWidget {
  const RawButtonWidget({
    required this.child,
    super.key,
    this.onTap,
    this.borderRadiusValue,
    this.backgroundColor = Colors.transparent,
    this.shape,
  });
  final Widget child;
  final void Function()? onTap;
  final double? borderRadiusValue;
  final Color backgroundColor;
  final ShapeBorder? shape;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      shape: shape,
      borderRadius: (shape == null)
          ? borderRadiusValue != null
              ? BorderRadius.all(Radius.circular(borderRadiusValue!))
              : null
          : null,
      child: InkWell(
        onTap: onTap,
        customBorder: shape,
        borderRadius: (shape == null)
            ? borderRadiusValue != null
                ? BorderRadius.all(Radius.circular(borderRadiusValue!))
                : null
            : null,
        child: child,
      ),
    );
  }
} */
