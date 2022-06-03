import 'package:flutter/material.dart';
import 'package:traval/const/appstyle.dart';

class Button extends StatelessWidget {
  Button({Key? key,this.isColor,this.onTap,this.title}) : super(key: key);
  String? title;
  bool? isColor;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      color: isColor == null? Color(0xFF5EDFFF):Colors.transparent,
      child: Text('${title}',style: textStyle,),
      height: 50,
      minWidth: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: isColor == null?Colors.transparent:Color(0xFF5EDFFF))
      ),
    );
  }
}
