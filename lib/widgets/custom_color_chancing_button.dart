import 'package:flutter/material.dart';

class ColorChangingButton extends InheritedWidget {
  final Color color;
  final Function(Color) setColor;

  ColorChangingButton({
    required this.color,
    required this.setColor,
    required Widget child,
  }) : super(child: child);

  @override
  bool updateShouldNotify(ColorChangingButton oldWidget) {
    return color != oldWidget.color;
  }

  static ColorChangingButton of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ColorChangingButton>()!;
  }
}
