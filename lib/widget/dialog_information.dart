import 'package:flutter/material.dart';

class DialogInformation extends StatelessWidget {
  const DialogInformation({Key? key, required this.txtContent}) : super(key: key);
  final String txtContent;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Colors.purple.shade50,
      content: Text(txtContent),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'ตกลง',
            style: TextStyle(color: Colors.purple.shade800, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
