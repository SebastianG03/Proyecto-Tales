// ignore_for_file: slash_for_doc_comments

import 'package:flutter/material.dart';

/**** 
 * *Custom Text Button
 * *<br>onPressed</br> is the function that will be executed when the button is pressed
 * *the correct format is () => onPressed()
 * *<br>label</br> is the text that will be displayed on the button.
 * ***/

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  const CustomTextButton(
      {super.key, required this.onPressed, required this.label});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
          child: Text(
            label,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w500, color: Colors.black),
          ),
        ),
      ),
    );
  }
}
