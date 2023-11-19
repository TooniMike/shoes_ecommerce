import 'package:flutter/material.dart';
import 'package:shoes/views/shared/appstyle.dart';

class CategoryBtn extends StatelessWidget {
  final void Function()? onPress;
  final Color buttonClr;
  final String label;
  const CategoryBtn(
      {super.key, this.onPress, required this.buttonClr, required this.label});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      child: Container(
        height: 40,
        width: MediaQuery.of(context).size.width * 0.244,
        decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: buttonClr,
              style: BorderStyle.solid,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(9))),
        child: Center(
          child: Text(
            label,
            style: appStyle(14, buttonClr, FontWeight.w600),
          ),
        ),
      ),
    );
  }
}
