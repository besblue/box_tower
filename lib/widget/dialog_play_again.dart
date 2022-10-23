import 'package:flutter/material.dart';

class DialogPlayAgain extends StatelessWidget {
  const DialogPlayAgain({Key? key, required this.txtContent, required this.function}) : super(key: key);
  final String txtContent;
  final Function()? function;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
      backgroundColor: Colors.purple.shade50,
      content: SingleChildScrollView(
        child: ListBody(
          children: [
            const Text('Total Time',
                textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text('$txtContent second', textAlign: TextAlign.center),
          ],
        ),
      ),
      actions: <Widget>[
        Align(
          alignment: Alignment.center,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
                side:  BorderSide(color: Colors.purple.shade800),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
            onPressed: function!,
            child: Text(
              'Play Again',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.purple.shade800),
            ),
          ),
        )
      ],
    );
  }
}
