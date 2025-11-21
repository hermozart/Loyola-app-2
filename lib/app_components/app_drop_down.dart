import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'form_field_controller.dart';

class AppDropDown<T> extends StatelessWidget {
  const AppDropDown({
    Key? key,
    required this.options,
    this.onChanged,
    this.width,
    this.height,
    this.textStyle,
    this.hintText,
    this.icon,
    this.fillColor,
    this.elevation = 2,
    this.borderColor,
    this.borderWidth = 1,
    this.borderRadius = 8,
    this.margin,
    this.hidesUnderline = false,
    this.isOverButton = false,
    this.isSearchable = false,
    this.isMultiSelect = false,
    this.controller,
  }) : super(key: key);

  final List<T> options;
  final Function(T?)? onChanged;
  final double? width;
  final double? height;
  final TextStyle? textStyle;
  final String? hintText;
  final Widget? icon;
  final Color? fillColor;
  final double elevation;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final bool hidesUnderline;
  final bool isOverButton;
  final bool isSearchable;
  final bool isMultiSelect;
  final FormFieldController<T>? controller;

  @override
  Widget build(BuildContext context) {
    final value = controller?.value;

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(
          color: borderColor ?? Colors.transparent,
          width: borderWidth,
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          value: value,
          hint: hintText != null
              ? Text(
                  hintText!,
                  style: textStyle,
                )
              : null,
          items: options
              .map((item) => DropdownMenuItem<T>(
                    value: item,
                    child: Text(
                      item.toString(),
                      style: textStyle,
                    ),
                  ))
              .toList(),
          onChanged: (T? newValue) {
            if (controller != null) {
              controller!.value = newValue;
            }
            if (onChanged != null) {
              onChanged!(newValue);
            }
          },
          buttonStyleData: ButtonStyleData(
            height: height,
            width: width,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: fillColor,
            ),
            elevation: elevation.toInt(),
          ),
          iconStyleData: IconStyleData(
            icon: icon ?? const Icon(Icons.keyboard_arrow_down),
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              color: fillColor ?? Colors.white,
            ),
            elevation: elevation.toInt(),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: MaterialStateProperty.all(6),
              thumbVisibility: MaterialStateProperty.all(true),
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 16),
          ),
        ),
      ),
    );
  }
}
