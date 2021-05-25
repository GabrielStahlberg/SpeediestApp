import 'package:flutter/material.dart';

class AlertDialogPopup extends StatelessWidget {

  final Widget content;
  final Function onPress;
  final String title;
  final Color titleColor;
  final String negativeButton;
  final String positiveButton;
  final TextEditingController controller;
  final bool showCancelButton;
  final bool showOkButton;
  final double titleSize;

  const AlertDialogPopup({
    Key key,
    @required this.content,
    this.title = "",
    this.titleColor = Colors.black,
    this.negativeButton = "Cancelar",
    this.positiveButton = "Ok",
    this.controller,
    this.onPress,
    this.showCancelButton = true,
    this.showOkButton = true,
    this.titleSize
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title, style: TextStyle(fontSize: titleSize, color: titleColor, fontWeight: FontWeight.bold)),
      content: content,
      actions: <Widget>[
        showCancelButton ? FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              negativeButton,
              style: TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            )
        ) : Container(),
        showOkButton ? FlatButton(
            onPressed: onPress,
            child: Text(
              positiveButton,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
        ) : Container()
      ],
    );
  }
}
