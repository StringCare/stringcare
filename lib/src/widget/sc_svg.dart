import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stringcare/stringcare.dart';

class ScSvg extends StatelessWidget {
  final String name;

  final double? width;

  final double? height;

  final BoxFit fit;

  final Alignment alignment;

  final bool matchTextDirection;

  final bool allowDrawingOutsideViewBox;

  final Widget Function(BuildContext context)? placeholderBuilder;

  final ui.ColorFilter? colorFilter;

  final String? semanticsLabel;

  final bool excludeFromSemantics;

  final Clip clipBehavior;

  ScSvg(
    this.name, {
    Key? key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.alignment = Alignment.center,
    this.matchTextDirection = false,
    this.allowDrawingOutsideViewBox = false,
    this.placeholderBuilder,
    this.colorFilter,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: Stringcare().revealAsset(name),
      builder: (context, promiseData) {
        if (!promiseData.hasData) {
          return Container();
        }
        return SvgPicture.memory(
          promiseData.data!,
          width: width,
          height: height,
          fit: fit,
          alignment: alignment,
          matchTextDirection: matchTextDirection,
          allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
          placeholderBuilder: placeholderBuilder,
          semanticsLabel: semanticsLabel,
          excludeFromSemantics: excludeFromSemantics,
          clipBehavior: clipBehavior,
        );
      },
    );
  }
}
