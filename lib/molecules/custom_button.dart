import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String labelText;

  final Function onButtonPressed;

  CustomButton(this.labelText, this.onButtonPressed, {super.key});

  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: Colors.blue,
    minimumSize: const Size(250, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(2)),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: raisedButtonStyle,
      onPressed: () {
        onButtonPressed();
      },
      child: Text(
        labelText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.white,
        ),
      ),
    );
  }
}
