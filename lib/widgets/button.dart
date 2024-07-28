import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final void Function()? onPressed;
  final Icon? icon;
  final Widget label;
  final bool? showIcon;
  final Color? bgColor;

  const Button({
    super.key,
    this.onPressed,
    required this.label,
    this.icon,
    this.showIcon = false,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return showIcon == true
        ? Container(
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor ?? Colors.purple[500],
              ),
              onPressed: onPressed,
              label: label,
              icon: icon,
            ),
          )
        : Container(
            margin: const EdgeInsets.only(bottom: 5, top: 5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: bgColor ?? Colors.purple[500],
              ),
              onPressed: onPressed,
              child: label,
            ),
          );
  }
}
