import 'package:flutter/material.dart';

class CustomeTextField extends StatelessWidget {
  CustomeTextField({
    Key? key,
    this.controller,
    this.hintText,
    this.icon,
    this.title,
    this.validator,
    this.sicon,
  }) : super(key: key);

  String? title, hintText;
  TextEditingController? controller;
  dynamic? validator;
  dynamic? icon;
  dynamic? sicon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${title}",
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xFF8A8A8E))),
        SizedBox(
          height: 12,
        ),
        TextFormField(
          controller: controller,
          keyboardType: TextInputType.name,
          validator: validator,
          style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w400,
              color: Colors.white),
          decoration: InputDecoration(
            errorBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xFF8A8A8E), width: 5)),
            prefixIcon: icon,
            suffixIcon: sicon,
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xFF8A8A8E), width: 1)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(color: Color(0xFF8A8A8E), width: 1)),
            hintText: "$hintText",
            hintStyle: TextStyle(color: Color(0xFF8A8A8E)),
            labelStyle: TextStyle(color: Color(0xFF8A8A8E)),
          ),
        ),
      ],
    );
  }
}
