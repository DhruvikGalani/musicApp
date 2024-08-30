import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:music_app/Lecture/provider_example.dart';
import 'package:music_app/by_asset_music.dart';
import 'package:music_app/provider.dart';
import 'package:music_app/setDrawerButton.dart';
import 'package:music_app/playPage.dart';
import 'package:music_app/variable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'catchMusic.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  pref = await SharedPreferences.getInstance();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarBrightness:
        (isDarkMode == true) ? Brightness.dark : Brightness.light,
  ));
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (context) => ThemeProvider(),
          ),
          ChangeNotifierProvider(
            create: (context) => ProviderClass(),
          )
        ],
        // child: catchMusic(),
        child: myapp(),
        // child: ProviderExample(),
      ),
    ), // for asset music
    // home: Songs(),
  );
}

class myapp extends StatefulWidget {
  const myapp({super.key});

  @override
  State<myapp> createState() => _myappState();
}

class _myappState extends State<myapp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isDarkMode = pref!.getBool("mode") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themedata,
      // home: MusicByAsset(),

      home: setButton(),
      // home: MusicByAsset(),
      // home: catchMusic(),
      // home: MusicforTry(),
    );
  }
}
