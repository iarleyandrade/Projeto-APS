// ignore_for_file: public_member_api_docs

import "package:flutter/material.dart";

dynamic showSnackBar({
  required BuildContext context,
  required String text,
  bool isError = true,
}) {
  final SnackBar snackBar = SnackBar(
    content: Text(text),
    backgroundColor: isError ? Colors.red : Colors.green,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    duration: const Duration(seconds: 3),
    action: SnackBarAction(
      label: "Ok",
      textColor: Colors.white,
      onPressed: () {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
      },
    ),
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
