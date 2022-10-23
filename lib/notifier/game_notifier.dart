import 'dart:async';
import 'dart:math';
import 'package:chom_chob_test/widget/dialog_information.dart';
import 'package:chom_chob_test/widget/dialog_play_again.dart';
import 'package:flutter/material.dart';

import '../model/box_model.dart';

class GameNotifier with ChangeNotifier {
  GameNotifier({required this.context}) {
    _setColor();
    _startScreen();
  }

  final BuildContext context;

  final List<Color> _listColors = [Colors.blueAccent, Colors.greenAccent, Colors.redAccent];
  List<BoxModel> listBox = [];
  List<Color> listButtonColor = [];
  ScrollController scrollController = ScrollController();

  int timeCount = 0;
  late Timer timer;
  bool isStartCount = false;
  bool isPressButtonLeft = false;
  bool isPressButtonRight = false;
  bool startAnimation = false;
  bool isProcessing = false;

  _setColor() {
    _setBoxColor();
    _setButtonColor();
    notifyListeners();
  }

  Color _getColorRandom() {
    return _listColors[Random().nextInt(_listColors.length)];
  }

  _setBoxColor() {
    listBox.clear();
    for (int i = 0; i < 10; i++) {
      BoxModel md = BoxModel();

      if (i == 0) {
        md.color = Colors.purple;
      } else {
        md.color = _getColorRandom();
      }
      listBox.add(md);
    }
  }

  _setButtonColor() {
    listButtonColor.clear();
    Color colorFocus = _getColorBoxFocus();
    int indexRandom = Random().nextInt(2);

    if (listBox.length > 1) {
      for (int i = 0; i < 2; i++) {
        Color color;
        if (i == indexRandom) {
          color = colorFocus;
        } else {
          color = _getButtonRandomColor(colorFocus);
        }
        listButtonColor.add(color);
      }
    } else {
      for (int i = 0; i < 2; i++) {
        listButtonColor.add(colorFocus);
      }
    }
  }

  Color _getColorBoxFocus() {
    int lastIndex = listBox.length - 1;
    if (lastIndex >= 0) {
      return listBox[lastIndex].color;
    } else {
      return Colors.purple;
    }
  }

  Color _getButtonRandomColor(Color colorFocus) {
    Color colorRandom = _getColorRandom();
    if (colorFocus != colorRandom) {
      return colorRandom;
    }
    return _getButtonRandomColor(colorFocus);
  }

  onLongPress(Color color) {
    int timeMillisecond = 0;
    Color boxColor = _getColorBoxFocus();
    if (boxColor == color) {
      runAnimation(true);
      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        timeMillisecond += 100;
        if (boxColor != Colors.purple) {
          if (isPressButtonLeft && isPressButtonRight) {
            runAnimation(false);
            timer.cancel();
          } else if (!isPressButtonLeft && !isPressButtonRight) {
            runAnimation(false);
            timer.cancel();
          } else if (timeMillisecond == 2000 && (isPressButtonLeft || isPressButtonRight)) {
            if (color == boxColor) {
              destroyBox();
            }
            runAnimation(false);
            timer.cancel();
          }
        } else {
          if (!isPressButtonLeft || !isPressButtonRight) {
            runAnimation(false);
            timer.cancel();
          } else if (timeMillisecond == 2000 && isPressButtonLeft && isPressButtonRight) {
            if (color == boxColor) {
              destroyBox();
            }
            runAnimation(false);
            timer.cancel();
          }
        }
      });
    }
  }

  runAnimation(bool isStart) {
    startAnimation = isStart;
    notifyListeners();
  }

  destroyBox() async {
    if (!isProcessing) {
      isProcessing = true;
      _startTimeCount();
      if (listBox.isNotEmpty) {
        int lastIndex = listBox.length - 1;

        await fadeOut(lastIndex);

        listBox.removeAt(lastIndex);
        _stopTimeCount();
        _setButtonColor();
        notifyListeners();
      }
      isProcessing = false;
    }
  }

  fadeOut(int lastIndex) async {
    listBox[lastIndex].visible = !listBox[lastIndex].visible;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 300));
  }

  _startScreen() async {
    await scrollEnd();
    await _dialogInformation();
  }

  _dialogInformation() async {
    await _inForBox();
    await _inForDiamonds();
  }

  scrollEnd() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      double position = scrollController.position.maxScrollExtent;
      scrollController.jumpTo(position);
    });
  }

  _inForBox() async {
    await showDialog(
        context: context,
        builder: (context) {
          return const DialogInformation(
              txtContent: 'กดปุ่มสีให้ตรงกับ สีกล่องค้างไว้ 2 วินาทีเพื่อทำลายกล่องสี่เหลี่ยม');
        });
  }

  _inForDiamonds() async {
    await showDialog(
        context: context,
        builder: (context) {
          return const DialogInformation(txtContent: 'กดปุ่ม 2 ปุ่มค้างไว้ 2 วินาทีเพื่อทำลายกล่องข้าวหลามตัด');
        });
  }

  _dialogPlayAgain() async {
    await showDialog(
        context: context,
        builder: (context) {
          return DialogPlayAgain(
            txtContent: timeCount.toString(),
            function: () {
              _resetValue();
              _setColor();
              scrollEnd();
              Navigator.pop(context);
            },
          );
        });
  }

  _startTimeCount() {
    if (!isStartCount) {
      isStartCount = true;
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeCount++;
        notifyListeners();
      });
    }
  }

  _stopTimeCount() {
    if (listBox.isEmpty) {
      timer.cancel();
      _dialogPlayAgain();
    }
  }

  _resetValue() {
    timeCount = 0;
    isStartCount = false;
  }
}
