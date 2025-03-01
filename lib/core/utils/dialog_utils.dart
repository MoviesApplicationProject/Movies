import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/theme/app_colors.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return CupertinoAlertDialog(
        content: Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 12),
              const Text(
                "Loading...",
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              const CircularProgressIndicator(
                color: AppColors.yellow,
              ),
            ],
          ),
        ),
      );
    },
  );
}

hideLoading(BuildContext context) {
  Navigator.pop(context);
}

showMessage(
  BuildContext context,
  String message, {
  String? title,
  String? posButtonTitle,
  Function? posButtonClick,
  String? negativeButtonTitle,
  Function? negativeButtonClick,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: title != null ? Text(title) : null,
          content: Text(message),
          actions: [
            if (posButtonTitle != null)
              TextButton(
                  onPressed: () {
                    hideLoading(context);
                    if (posButtonClick != null) posButtonClick();
                  },
                  child: Text(posButtonTitle)),
            if (negativeButtonTitle != null)
              TextButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColors.yellow),
                      textStyle: MaterialStateProperty.all(
                          TextStyle(color: AppColors.black))),
                  onPressed: () {
                    hideLoading(context);
                    if (negativeButtonClick != null) negativeButtonClick();
                  },
                  child: Text(negativeButtonTitle))
          ],
        );
      });
}
