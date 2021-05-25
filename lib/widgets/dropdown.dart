import 'package:flutter/material.dart';

class DropDown extends StatelessWidget {

  final String value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String> onChanged;
  final String hint;
  final double textSize;
  final bool isExpanded;

  const DropDown({
    Key key,
    this.value,
    this.items,
    this.onChanged,
    this.hint = "",
    this.textSize,
    this.isExpanded = false
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: value,
      items: items,
      onChanged: onChanged,
      isExpanded: isExpanded,
      icon: Icon(Icons.arrow_drop_down),
      hint: Text(hint),
      style: TextStyle(
          color: Colors.black,
          fontSize: textSize
      ),
    );
  }
}

