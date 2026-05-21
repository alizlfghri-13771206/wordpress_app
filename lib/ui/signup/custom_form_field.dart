import "package:flutter/material.dart";
import "package:wordpress_app/constants/constants.dart";

class CustomFormField extends StatelessWidget {
  final String labelName;
  final Object? initialValue;
  final TextAlign textAlign;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  const CustomFormField({
    super.key,
    required this.labelName,
    required this.initialValue,
    required this.textAlign,
    required this.onChanged,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: .rtl,
      child: TextFormField(
        initialValue: initialValue != null ? initialValue.toString() : "",
        onChanged: onChanged,
        textAlign: textAlign,
        textDirection: TextDirection.rtl,
        cursorColor: Constants.primaryColor,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontFamily: "yekan", fontSize: 13),
          border: OutlineInputBorder(),
          label: Text(
            labelName,
            style: TextStyle(
              fontFamily: "laleh",
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        validator: validator,
      ),
    );
  }
}
