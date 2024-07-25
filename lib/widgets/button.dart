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
        ? ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor ?? Colors.purple[500],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
            ),
            onPressed: onPressed,
            label: label,
            icon: icon,
          )
        : ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: bgColor ?? Colors.purple[500],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 40,
              ),
            ),
            onPressed: onPressed,
            child: label,
          );
  }
}
