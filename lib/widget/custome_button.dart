import 'package:flutter/material.dart';

class CustomeButton extends StatelessWidget {
  final Size? size;
  final String? text;
  final Function? function;
  final TextStyle? textStyle;
  final Color? colors;

  const CustomeButton({super.key, this.text, this.textStyle, this.size, this.function,this.colors});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: size!.height * .07,
        width: size!.width * .7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
             color: colors),
        child: MaterialButton(
          onPressed: () async {
            function!();
          },
          child: Center(
            child: Text(text!, style: textStyle),
          ),
        ));
  }
}
