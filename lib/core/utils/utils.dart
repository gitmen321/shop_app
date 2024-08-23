import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void showSnackBar(BuildContext context, String text){
  ScaffoldMessenger.of(context)
  ..hideCurrentSnackBar()
  ..showSnackBar(SnackBar(content: Text(text),),);
}

void showOtpDialogue({required BuildContext context,
required TextEditingController codeController,
required VoidCallback onPressed,
} ){



}