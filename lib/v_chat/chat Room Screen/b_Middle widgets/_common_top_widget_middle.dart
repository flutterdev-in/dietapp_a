import 'package:flutter/material.dart';

class CommonTopWidgetMiddle extends StatelessWidget {
  final Widget child;
  final BoxConstraints? constraints;
  final String? text;
  const CommonTopWidgetMiddle(
      {Key? key, required this.child, required this.text, this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          width: MediaQuery.of(context).size.width * 8 / 10,
          color: Colors.blueGrey.shade200,
          constraints: constraints,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(color: Colors.blueGrey.shade900, child: child),
              if (text != null && text != "")
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(text!),
                ),
            ],
          )),
    );
  }
}
