import 'package:flutter/material.dart';

alertDialogueW(
  BuildContext context, {
  EdgeInsets insetPadding = const EdgeInsets.all(10),
  EdgeInsetsGeometry contentPadding =
      const EdgeInsets.fromLTRB(8.0, 20.0, 8.0, 24.0),
  bool scrollable = true,
  MainAxisAlignment? actionsAlignment = MainAxisAlignment.start,
  required Widget body,
}) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      insetPadding: insetPadding,
      contentPadding: contentPadding,
      scrollable: true,
      actionsAlignment: actionsAlignment,
      content: body,
    ),
  );
}
