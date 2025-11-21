import 'package:flutter/material.dart';
import 'package:loyola_app22/app_components/form_field_controller.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    Key? key,
    required this.icon,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.buttonSize,
    this.fillColor,
    this.disabledColor,
    this.disabledIconColor,
    this.onPressed,
    this.showLoadingIndicator = false,
  }) : super(key: key);

  final Widget icon;
  final double? borderRadius;
  final double? buttonSize;
  final Color? fillColor;
  final Color? disabledColor;
  final Color? disabledIconColor;
  final Color? borderColor;
  final double? borderWidth;
  final bool showLoadingIndicator;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius:
          borderRadius != null ? BorderRadius.circular(borderRadius!) : null,
      color: Colors.transparent,
      clipBehavior: Clip.antiAlias,
      child: Ink(
        width: buttonSize,
        height: buttonSize,
        decoration: BoxDecoration(
          color: fillColor,
          border: borderColor != null
              ? Border.all(
                  color: borderColor!,
                  width: borderWidth ?? 1,
                )
              : null,
          borderRadius: borderRadius != null
              ? BorderRadius.circular(borderRadius!)
              : null,
        ),
        child: IconButton(
          icon: showLoadingIndicator
              ? Container(
                  width: buttonSize,
                  height: buttonSize,
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      disabledIconColor ?? Colors.white,
                    ),
                  ),
                )
              : icon,
          onPressed: onPressed,
          splashRadius: buttonSize,
        ),
      ),
    );
  }
}
