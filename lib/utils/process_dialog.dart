import 'package:flutter/material.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

class ProcessDialog {

  late BuildContext context;
  late String message;
  late ProgressDialog pd;
  ProcessDialog(this.context, {this.message = "加載中..."}) {
    pd = ProgressDialog(context);
    pd.style(
        message: message,
        borderRadius: 10.0,
        backgroundColor: Colors.white,
        padding: const EdgeInsets.all(10),
        progressWidget: const SizedBox(
          height: 10.0,
          width: 10.0,
          child: Center(
              child: CircularProgressIndicator()
          ),
        ),
        elevation: 10.0,
        insetAnimCurve: Curves.easeInOut,
        messageTextStyle: const TextStyle(
            color: Colors.black87, fontSize: 17.0, fontWeight: FontWeight.w500)
    );
  }

  Future<bool> show() async {
    return await pd.show();
  }

  Future<bool> cancel() async {
    return await pd.hide();
  }
}