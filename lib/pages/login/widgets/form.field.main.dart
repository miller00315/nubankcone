import 'package:drawer_app/src/utils/values/colors.dart';
import 'package:flutter/material.dart';

class FormFieldMain extends StatelessWidget {
  final Key key;
  final double marginLeft;
  final double marginRight;
  final double marginTop;
  final TextInputType textInputType;
  final String hintText;
  final bool obscured;
  final void Function(void) onChange;

  const FormFieldMain(
      {
      @required this.key,
      @required this.marginLeft,
      @required this.marginRight,
      @required this.marginTop,
      @required this.textInputType,
      @required this.hintText,
      @required this.obscured,
      @required this.onChange})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: marginLeft, right: marginRight, top: marginTop),
      child: TextField(
        key: key,
        onChanged: (value) {},
        obscureText: obscured,
        decoration: InputDecoration(
          filled: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 1,
              color: Color(0xCC000000),
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          fillColor: Colors.white,
          hintText: hintText,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: ColorConstant.colorAccentPurple),
          ),
        ),
      ),
    );
  }
}
