import 'package:flutter/material.dart';

class CustomMessage {
  void showMessage({required BuildContext context, required String message, required bool isSuccess}){
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        content: Text(message),
      )
    );
  }
}