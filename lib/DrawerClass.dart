import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:music_app/provider.dart';
import 'package:music_app/variable.dart';
import 'package:provider/provider.dart';

class DrawerClass extends StatefulWidget {
  const DrawerClass({super.key});

  @override
  State<DrawerClass> createState() => _DrawerClassState();
}

class _DrawerClassState extends State<DrawerClass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      // appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Colors.blueGrey),
            ),
            Row(
              children: [
                Text("User"),
                SizedBox(
                  width: 20,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
              ],
            ),
            Divider(),
            Row(
              children: [
                Text("Dark Mode"),
                Transform.scale(
                  scale: .65,
                  child: // Switch
                      CupertinoSwitch(
                    applyTheme: true,
                    dragStartBehavior: DragStartBehavior.start,
                    value: isDarkMode!,
                    onChanged: (value) =>
                        Provider.of<ThemeProvider>(context, listen: false)
                            .toggleTheme(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
