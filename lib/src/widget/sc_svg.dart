import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stringcare/stringcare.dart';

class ScSvg extends StatefulWidget {
  final String name;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Alignment alignment;
  final bool matchTextDirection;
  final bool allowDrawingOutsideViewBox;
  final Widget Function(BuildContext context)? placeholderBuilder;
  final Color? color;
  final BlendMode colorBlendMode;
  final String? semanticsLabel;
  final bool excludeFromSemantics;
  final Clip clipBehavior;
  final bool cacheColorFilter;

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
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.semanticsLabel,
    this.excludeFromSemantics = false,
    this.clipBehavior = Clip.hardEdge,
    this.cacheColorFilter = false,
  }) : super(key: key);

  @override
  _ScSvgState createState() => _ScSvgState();
}

class _ScSvgState extends State<ScSvg> {
  Uint8List? data;

  @override
  void initState() {
    super.initState();
    Stringcare.revealAsset(widget.name).then((value) {
      setState(() {
        data = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (data == null) {
      return Container();
    }
    return SvgPicture.memory(
      data!,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      alignment: widget.alignment,
      matchTextDirection: widget.matchTextDirection,
      allowDrawingOutsideViewBox: widget.allowDrawingOutsideViewBox,
      placeholderBuilder: widget.placeholderBuilder,
      color: widget.color,
      colorBlendMode: widget.colorBlendMode,
      semanticsLabel: widget.semanticsLabel,
      excludeFromSemantics: widget.excludeFromSemantics,
      clipBehavior: widget.clipBehavior,
      cacheColorFilter: widget.cacheColorFilter,
    );
  }
}
