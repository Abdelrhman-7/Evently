import 'package:evently/core/colormanager.dart';
import 'package:flutter/material.dart';

class DialogUtils {
  static void showLoading({
    required BuildContext context,
    required String message,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(color: Colormanager.gray),
              const SizedBox(width: 10),
              Text(message, style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
        );
      },
    );
  }

  static void hideLoding({required BuildContext context}) {
    Navigator.pop(context);
  }

  static void showMasseg({
    required BuildContext context,
    required String message,
    String? titel,
    String? positiveAction,
    Function? posveAction,
    String? negitiveActionName,
    Function? negitiveveAction,
  }) {
    List<Widget>? actions = [];
    if (positiveAction != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            posveAction?.call();
          },
          child: Text(
            positiveAction,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }
    if (negitiveActionName != null) {
      actions.add(
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            negitiveveAction?.call();
          },
          child: Text(
            negitiveActionName,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      );
    }
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text(message, style: Theme.of(context).textTheme.bodyLarge),
          title: Text(
            titel ?? '',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          actions: actions,
        );
      },
    );
  }

  static void showMessage({
    required BuildContext context,
    required String message,
  }) {}
}
