import 'package:flutter/material.dart';
import 'package:todo_app/Utils/colors.dart';

class CustomTextInput extends StatelessWidget {
  final String value;

  final String placeHolderText;

  final String labelText;

  final TextEditingController textEditingController;

  final ValueChanged<String> onTextInputBlur;

  final bool? isTextAreaField;

  const CustomTextInput(this.value, this.placeHolderText, this.labelText,
      this.textEditingController, this.onTextInputBlur,
      {super.key, this.isTextAreaField});

  @override
  Widget build(BuildContext context) {
    return Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            onTextInputBlur(textEditingController.text);
          }
        },
        child: SingleChildScrollView(
          child: TextField(
            controller: textEditingController,
            decoration: InputDecoration(
              filled: false,
              hintText: placeHolderText,
              hintStyle: const TextStyle(color: Colors.grey),
              labelText: labelText,
              labelStyle: const TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
              focusedBorder: isTextAreaField != null
                  ? const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.black))
                  : const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
            ),
            cursorColor: AppColors.blackColor,
            minLines: isTextAreaField != null ? 2 : 1,
            maxLines: isTextAreaField != null ? 3 : 1,
          ),
        ));
  }
}
