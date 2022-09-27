import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final bool isPassword;
  final TextEditingController textEditingController;
  final VoidCallback? onTap;
  final String labelText;
  final String suffixText;
  const TextFieldWidget({
    Key? key,
    required this.labelText,
    required this.suffixText,
    required this.onTap, required this.textEditingController, required this.isPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(
              color: Color(0xFF9F9F9F),
              fontFamily: 'Noah',
              fontSize: 18,
              fontWeight: FontWeight.w400,
              letterSpacing: 0.02),
        ),
        TextField(
          obscureText: isPassword,
          controller: textEditingController,
          style: const TextStyle(fontSize: 18),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: onTap,
              child: Text(
                suffixText,
                style: const TextStyle(
                    color: Color(0xFF01A8E9),
                    fontFamily: 'Noah',
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.02),
              ),
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF2F2F2), width: 3, style: BorderStyle.solid),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF2F2F2), width: 3, style: BorderStyle.solid),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFF2F2F2), width: 3, style: BorderStyle.solid),
            ),
          ),
        ),
      ],
    );
  }
}
