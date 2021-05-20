import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'color.dart';

class StandardInput extends StatelessWidget {
  final onChanged;
  final String hintText;
  final TextInputType textInputType;
  final String errorStr;
  final String value;

  final TextEditingController _controller = TextEditingController();

  StandardInput(
      {@required this.onChanged,
      @required this.hintText,
      this.textInputType = TextInputType.text,
      this.errorStr,
      this.value = ""});

  @override
  Widget build(BuildContext context) {
    _controller.value = TextEditingValue(text: value);
    return TextField(
        keyboardType: textInputType,
        onChanged: onChanged,
        controller: _controller,
        decoration: InputDecoration(
          fillColor: foregroundColor,
          filled: true,
          hintText: hintText,
          errorText: errorStr,
          hintStyle: TextStyle(
              fontFamily: 'RobotoMedium', fontSize: 16.0, color: Colors.grey),
          contentPadding:
              EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.transparent),
              borderRadius: BorderRadius.circular(6.0)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: mainColor),
              borderRadius: BorderRadius.circular(6.0)),
          errorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red[600]),
              borderRadius: BorderRadius.circular(6.0)),
          focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1, color: Colors.red[600]),
              borderRadius: BorderRadius.circular(6.0)),
        ));
  }
}
