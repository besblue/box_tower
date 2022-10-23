import 'package:chom_chob_test/widget/triangle_pointer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../notifier/game_notifier.dart';
import '../widget/circle_button.dart';
import '../widget/diamonds_box.dart';
import '../widget/linear_progress.dart';
import '../widget/oval_box.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GameNotifier>(
      builder: (context, game, _) {
        return SafeArea(
            child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Text('Total Time ${game.timeCount}', style: const TextStyle(color: Colors.black54)),
            bottom: game.startAnimation
                ? const PreferredSize(preferredSize: Size.fromHeight(5), child: LinearProgress())
                : null,
          ),
          backgroundColor: Colors.grey.shade300,
          body: _buildBody(game, context),
          bottomNavigationBar: _buildBottomButton(game),
        ));
      },
    );
  }

  _buildBody(GameNotifier game, BuildContext context) {
    return OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        if (orientation == Orientation.portrait) {
          game.scrollEnd();
          return _buildBoxListPortrait(game, context);
        } else {
          game.scrollEnd();
          return _buildBoxListLandScape(game, context);
        }
      },
    );
  }

  _buildBoxListLandScape(GameNotifier game, BuildContext context) {
    List<Widget> listBoxOval = [];
    Widget boxDiamonds = Container();
    Widget pointerLeft = Container();
    Widget pointerRight = Container();
    for (int i = 0; i < game.listBox.length; i++) {
      Color color = game.listBox[i].color;
      if (i == 0) {
        boxDiamonds = AnimatedOpacity(
          opacity: game.listBox[i].visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: DiamondsBox(
            size: MediaQuery.of(context).size.width * 0.7 * 0.3,
            boxColor: color,
          ),
        );
      } else {
        listBoxOval.add(AnimatedOpacity(
          opacity: game.listBox[i].visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: OvalBox(
            width: MediaQuery.of(context).size.width * 0.7 * 0.3,
            boxColor: color,
          ),
        ));
      }
    }
    if (game.listBox.isNotEmpty) {
      pointerLeft = Container(
        margin: EdgeInsets.symmetric(
            vertical: game.listBox.length > 1 ? 40 : 120, horizontal: game.listBox.length > 1 ? 10 : 30),
        child: CustomPaint(
          size: (const Size(20, 20)),
          painter: TrianglePointer(left: true),
        ),
      );

      pointerRight = Container(
        margin: EdgeInsets.symmetric(
            vertical: game.listBox.length > 1 ? 40 : 120, horizontal: game.listBox.length > 1 ? 10 : 30),
        child: CustomPaint(
          size: (const Size(20, 20)),
          painter: TrianglePointer(left: false),
        ),
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          height: MediaQuery.of(context!).size.height,
          width: MediaQuery.of(context!).size.width * 0.15,
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 15.0),
          alignment: Alignment.bottomCenter,
          child: _buildButtonLeft(
            game,
          ),
        ),
        SingleChildScrollView(
          controller: game.scrollController,
          physics: const NeverScrollableScrollPhysics(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              pointerLeft,
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: boxDiamonds,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: listBoxOval,
                  ),
                  const SizedBox(height: 20)
                ],
              ),
              pointerRight
            ],
          ),
        ),
        Container(
          height: MediaQuery.of(context!).size.height,
          width: MediaQuery.of(context!).size.width * 0.15,
          color: Colors.white,
          padding: const EdgeInsets.only(bottom: 15.0),
          alignment: Alignment.bottomCenter,
          child: _buildButtonRight(game),
        ),
      ],
    );
  }

  _buildBoxListPortrait(GameNotifier game, BuildContext context) {
    List<Widget> listBoxOval = [];
    Widget boxDiamonds = Container();
    Widget pointerLeft = Container();
    Widget pointerRight = Container();
    for (int i = 0; i < game.listBox.length; i++) {
      Color color = game.listBox[i].color;
      if (i == 0) {
        boxDiamonds = AnimatedOpacity(
          opacity: game.listBox[i].visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: DiamondsBox(
            boxColor: color,
            size: MediaQuery.of(context).size.width * 0.3,
          ),
        );
      } else {
        listBoxOval.add(AnimatedOpacity(
          opacity: game.listBox[i].visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 300),
          child: OvalBox(
            width: MediaQuery.of(context).size.width * 0.3,
            boxColor: color,
          ),
        ));
      }
    }
    if (game.listBox.isNotEmpty) {
      pointerLeft = Container(
        margin: EdgeInsets.symmetric(
            vertical: game.listBox.length > 1 ? 40 : 115, horizontal: game.listBox.length > 1 ? 10 : 30),
        child: CustomPaint(
          size: (const Size(20, 20)),
          painter: TrianglePointer(left: true),
        ),
      );

      pointerRight = Container(
        margin: EdgeInsets.symmetric(
            vertical: game.listBox.length > 1 ? 40 : 115, horizontal: game.listBox.length > 1 ? 10 : 30),
        child: CustomPaint(
          size: (const Size(20, 20)),
          painter: TrianglePointer(left: false),
        ),
      );
    }
    return SingleChildScrollView(
      controller: game.scrollController,
      physics: const NeverScrollableScrollPhysics(),
      child: Container(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            pointerLeft,
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: boxDiamonds,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: listBoxOval,
                ),
                const SizedBox(height: 20)
              ],
            ),
            pointerRight
          ],
        ),
      ),
    );
  }

  _buildBottomButton(GameNotifier game) {
    return OrientationBuilder(builder: (context, orientation) {
      if (orientation == Orientation.portrait) {
        return Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(child: _buildButtonLeft(game)),
                const SizedBox(width: 50),
                Container(child: _buildButtonRight(game))
              ],
            ),
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }

  _buildButtonLeft(GameNotifier game) {
    Color color = game.listButtonColor[0];
    return CircleButton(
      buttonColor: color,
      pressCancel: () {
        game.isPressButtonLeft = false;
        game.runAnimation(false);
      },
      pressUp: () {
        game.isPressButtonLeft = false;
        game.runAnimation(false);
      },
      pressLong: () {
        game.isPressButtonLeft = true;
        game.onLongPress(color);
      },
    );
  }

  _buildButtonRight(GameNotifier game) {
    Color color = game.listButtonColor[1];
    return CircleButton(
        buttonColor: color,
        pressCancel: () {
          game.isPressButtonRight = false;
          game.runAnimation(false);
        },
        pressUp: () {
          game.isPressButtonRight = false;
          game.runAnimation(false);
        },
        pressLong: () {
          game.isPressButtonRight = true;
          game.onLongPress(color);
        });
  }
}
