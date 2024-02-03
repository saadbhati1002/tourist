import 'package:flutter/material.dart';
import 'package:tourist/utility/color.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField(
      {this.alignment,
      this.width,
      this.margin,
      this.controller,
      this.focusNode,
      this.isObscureText = false,
      this.textInputAction = TextInputAction.next,
      this.maxLines,
      this.hintText,
      this.prefix,
      this.prefixConstraints,
      this.suffix,
      this.keyboardType,
      this.onChanged,
      this.suffixConstraints,
      this.validator,
      this.onTap,
      this.context,
      this.isMaxLine});

  final Alignment? alignment;

  final double? width;
  final Function(String)? onChanged;

  final EdgeInsetsGeometry? margin;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? isObscureText;

  final TextInputAction? textInputAction;

  final int? maxLines;

  final String? hintText;

  final Widget? prefix;
  final Function()? onTap;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;
  final keyboardType;
  final BuildContext? context;
  final BoxConstraints? suffixConstraints;
  final bool? isMaxLine;

  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: _buildTextFormFieldWidget(),
          )
        : _buildTextFormFieldWidget();
  }

  _buildTextFormFieldWidget() {
    return Container(
      width: MediaQuery.of(context!).size.width,
      margin: margin,
      height: isMaxLine == true ? 180 : 45,
      child: TextField(
        onTap: onTap,
        onChanged: onChanged,
        cursorColor: ColorConstants.mainColor,
        keyboardType: keyboardType,
        controller: controller,
        focusNode: focusNode,
        style: TextStyle(
          color: ColorConstants.black,
          fontSize: 14,
          fontFamily: "inter",
          fontWeight: FontWeight.w500,
        ),
        obscureText: isObscureText!,
        textInputAction: textInputAction,
        maxLines: isMaxLine == true ? 7 : 1,
        decoration: InputDecoration(
          hintText: hintText ?? "",
          hintStyle: const TextStyle(
            color: ColorConstants.greyLight,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: ColorConstants.greyLight,
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ColorConstants.greyLight,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ColorConstants.greyLight,
              width: 1,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: ColorConstants.greyLight,
              width: 1,
            ),
          ),
          prefixIcon: prefix,
          prefixIconConstraints: prefixConstraints,
          suffixIcon: suffix,
          suffixIconConstraints: suffixConstraints,
          fillColor: ColorConstants.white,
          filled: true,
          isDense: true,
          contentPadding: const EdgeInsets.all(15),
        ),
        // validator: validator,
      ),
    );
  }
}
