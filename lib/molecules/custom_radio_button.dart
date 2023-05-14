import 'package:flutter/material.dart';
import 'package:todo_app/Utils/colors.dart';

class CustomRadioButton extends StatelessWidget {
  final String value;

  final List<String> options;

  final Map<String, Color> cardStyles;

  final Function onRadioButtonSelected;

  const CustomRadioButton(
      this.value, this.options, this.cardStyles, this.onRadioButtonSelected,
      {super.key});

  Widget radioButton(String title, ValueChanged<String> onRadioButtonSelected,
      isOptionSelected) {
    return GestureDetector(
        onTap: () => onRadioButtonSelected(title),
        child: Container(
          padding: const EdgeInsets.all(10),
          width: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(1),
            border: Border.all(
              width: 1,
              color: AppColors.blackColor,
            ),
            color: isOptionSelected
                ? cardStyles['selectedBackgroundColor']!
                : AppColors.whiteColor,
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                  fontSize: 16,
                  color: isOptionSelected
                      ? AppColors.whiteColor
                      : AppColors.blackColor),
            ),
          ),
        ));
  }

  List<Widget> generateRadioButtons(String val) {
    var list = options.map<List<Widget>>(
      (data) {
        var widgetList = <Widget>[];
        widgetList.add(radioButton(
            data, (val) => onRadioButtonSelected(val), value == data));
        return widgetList;
      },
    ).toList();
    var flat = list.expand((i) => i).toList();
    return flat;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: generateRadioButtons(value),
    );
  }
}
