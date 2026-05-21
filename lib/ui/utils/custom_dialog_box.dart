import "package:flutter/material.dart";

class CustomDialogBox {
  static void showMessage(
    BuildContext context,
    String title,
    String message,
    String buttonText,
    final VoidCallback onPressed,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: .rtl,
          child: AlertDialog(
            title: Center(
              child: Text(title, style: const TextStyle(fontFamily: "laleh")),
            ),
            content: Text(
              message,
              style: TextStyle(fontFamily: 'yekan', fontSize: 14),
            ),
            actions: [
              ElevatedButton(
                onPressed: onPressed,
                child: Text(buttonText, style: TextStyle(fontFamily: 'yekan')),
              ),
            ],
          ),
        );
      },
    );
  }
}
