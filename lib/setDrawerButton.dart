import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_app/DrawerClass.dart';
import 'package:music_app/by_asset_music.dart';
import 'package:music_app/playPage.dart';
import 'package:music_app/variable.dart';

class setButton extends StatefulWidget {
  const setButton({super.key});

  @override
  State<setButton> createState() => _setButtonState();
}

class _setButtonState extends State<setButton> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: Stack(
        children: [
          AnimatedPositioned(
            child: DrawerClass(),
            duration: const Duration(milliseconds: 800),
            width: 260,
            curve: Curves.fastOutSlowIn,
            left: isDrawer ? -260 : 0,
            height: MediaQuery.of(context).size.height,
          ),
          Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, .0019)
              ..rotateY((isDrawer == true) ? 0 : 1 - 30 * pi / 180),
            child: Transform.translate(
              offset: Offset((isDrawer) ? 0 : 250, 0),
              child: Transform.scale(
                scale: isDrawer ? 1 : .7,
                child: ClipRRect(
                  borderRadius:
                      BorderRadius.circular((isDrawer == false) ? 25 : 0),
                  // child: MusicByAsset(),
                  // child: music_ByAsset(),
                  child: const MusicforTry(),
                ),
              ),
            ),
          ),
          Positioned(
            top: 40,
            left: 10,
            child: IconButton(
              splashRadius: 15,
              onPressed: () {
                setState(() {
                  print("drawer : $isDrawer");
                  isDrawer = !isDrawer;
                });
              },
              icon: Icon(
                (isDrawer) ? Icons.menu : Icons.close,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
