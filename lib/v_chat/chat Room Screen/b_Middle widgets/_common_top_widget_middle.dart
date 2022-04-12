import 'package:flutter/material.dart';

class CommonTopWidgetMiddle extends StatelessWidget {
  final Widget child;
  final BoxConstraints? constraints;
  const CommonTopWidgetMiddle({Key? key, required this.child, this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          width: MediaQuery.of(context).size.width * 8 / 10,
          color: Colors.blueGrey.shade200,
          constraints: constraints,
          child: child),
    );
  }
}
