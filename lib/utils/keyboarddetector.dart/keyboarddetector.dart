import 'package:flutter/material.dart';

class KeyBoardDetector extends StatefulWidget {
  Widget child;
  VoidCallback? onkeyboardopen;
  VoidCallback? onkeyboardclose;
  KeyBoardDetector(
      {Key? key,
      required this.child,
      this.onkeyboardopen,
      this.onkeyboardclose})
      : super(key: key);

  @override
  State<KeyBoardDetector> createState() => _KeyBoardDetectorState();
}

class _KeyBoardDetectorState extends State<KeyBoardDetector> {
  @override
  Widget build(BuildContext context) {
    double keyboardCurrentState = MediaQuery.of(context).viewInsets.bottom;
    if (keyboardCurrentState < keyboardstate1.prevkeyboardstate) {
      // called when keyboard closed completely
      if (keyboardCurrentState == 0) {
        if (widget.onkeyboardclose != null) {
          Future.delayed(Duration.zero, () {
            //your code goes here
            keyboardstate1.lock = false;
            widget.onkeyboardclose!();
          });
        }
      }
    }
    if (keyboardCurrentState > keyboardstate1.prevkeyboardstate) {
      if (keyboardstate1.lock == false) {
        keyboardstate1.lock = true;
        // called when keyboard open
        if (widget.onkeyboardopen != null) {
          Future.delayed(Duration.zero, () {
            //your code goes here
            keyboardstate1.lock = false;
            widget.onkeyboardopen!();
          });
        }
      }
    }
    keyboardstate1.prevkeyboardstate = keyboardCurrentState;
    return widget.child;
  }
}

class keyboardstate1 {
  static double prevkeyboardstate = 0;
  static bool lock = false;
}
