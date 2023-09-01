import 'package:demo_publicarea/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  const LoadingIndicator({this.size = 150.0, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: LoadingAnimationWidget.newtonCradle(
            color: mainBackgroundColor,
            size: size) //CircularProgressIndicator(),
        );
  }
}
