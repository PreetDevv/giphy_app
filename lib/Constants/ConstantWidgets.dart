import 'package:flutter/material.dart';

class ConstantWidgets {
  // Private constructor to prevent instantiation
  ConstantWidgets._();

  // Static method to create a TextFormField
  static Widget customTextFormField({
    required TextEditingController controller,
    String? labelText,
    String? hintText,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    FormFieldValidator<String>? validator,
    InputDecoration? decoration,
    bool enabled = true,
    bool readOnly = false,
    TextStyle? style,
    TextCapitalization textCapitalization = TextCapitalization.none,
    int? maxLength,
    Widget? prefixIcon,
    Widget? suffixIcon,
    TextInputAction? textInputAction,
    FocusNode? focusNode,
    InputBorder? border,
    EdgeInsetsGeometry? contentPadding,
    Function()? onTap,
    Function()? onEditingComplete,
    Function(String)? onTextChange
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
      enabled: enabled,
      style: style,
      readOnly: readOnly,
      textCapitalization: textCapitalization,
      maxLength: maxLength,
      textInputAction: textInputAction,
      focusNode: focusNode,
      onTap: onTap,
      onChanged: onTextChange,
      onEditingComplete:onEditingComplete ,
      decoration: decoration ??
          InputDecoration(
            labelText: labelText,
            hintText: hintText,
            labelStyle:  TextStyle(
              fontSize: 14
            ),
            contentPadding: contentPadding == null ? EdgeInsets.symmetric(
              vertical: 5,
              // horizontal: 6,
            ) : contentPadding,
            border:border,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
          ),
    );
  }
}
