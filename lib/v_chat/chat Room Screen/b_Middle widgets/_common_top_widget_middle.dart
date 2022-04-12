import 'package:flutter/material.dart';

class CommonTopWidgetMiddle extends StatelessWidget {
  final Widget child;
  const CommonTopWidgetMiddle({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          width: MediaQuery.of(context).size.width * 7.5 / 10,
          color: Colors.green.shade200,
          child: child),
    );
  }
}
