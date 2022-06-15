import 'package:dietapp_a/app%20Constants/colors.dart';
import 'package:flutter/material.dart';

class CommonTopWidgetMiddle extends StatelessWidget {
  final Widget child;
  final BoxConstraints? constraints;
  final String? text;
  final Color? color;

  const CommonTopWidgetMiddle(
      {Key? key,
      required this.child,
      required this.text,
      this.color,
      this.constraints})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
          width: MediaQuery.of(context).size.width * 8 / 10,
          // decoration: BoxDecoration(

          //   borderRadius: BorderRadius.only(
          //     topLeft: isSentByMe ? const Radius.circular(7) : Radius.zero,
          //     topRight: const Radius.circular(7),
          //     bottomLeft: const Radius.circular(7),
          //     bottomRight: isSentByMe ? Radius.zero : const Radius.circular(7),
          //   ),
          // ),
          color: color ?? chatPlanWidgetColor,
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
