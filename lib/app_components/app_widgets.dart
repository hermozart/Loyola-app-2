import 'package:flutter/material.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.options,
  }) : super(key: key);

  final String text;
  final VoidCallback? onPressed;
  final AppButtonOptions options;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: options.width,
      height: options.height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: options.color,
          foregroundColor: options.textStyle?.color,
          elevation: options.elevation,
          padding: options.padding,
          shape: RoundedRectangleBorder(
            borderRadius: options.borderRadius ?? BorderRadius.circular(8),
            side: options.borderSide ?? BorderSide.none,
          ),
        ),
        child: Text(
          text,
          style: options.textStyle,
        ),
      ),
    );
  }
}

class AppButtonOptions {
  const AppButtonOptions({
    this.width,
    this.height,
    this.padding,
    this.iconPadding,
    this.color,
    this.textStyle,
    this.elevation,
    this.borderSide,
    this.borderRadius,
  });

  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? iconPadding;
  final Color? color;
  final TextStyle? textStyle;
  final double? elevation;
  final BorderSide? borderSide;
  final BorderRadius? borderRadius;
}
