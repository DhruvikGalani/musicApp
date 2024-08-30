import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gradient_slider/gradient_slider.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_app/variable.dart';
import 'package:music_visualizer/music_visualizer.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';
import 'package:sleek_circular_slider/sleek_circular_slider.dart';

class music_ByAsset extends StatefulWidget {
  const music_ByAsset({super.key});

  @override
  State<music_ByAsset> createState() => _music_ByAssetState();
}

class _music_ByAssetState extends State<music_ByAsset> {
  final player = AudioPlayer();
  String formateDuration(Duration d) {
    final min = d.inMinutes.remainder(60);
    final sec = d.inSeconds.remainder(60);
    return "${min.toString().padLeft(2, '0')} : ${sec.toString().padLeft(2, '0')}";
  }

  void handleplaypause() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  void handleseek(double value) {
    player.seek(
      Duration(seconds: value.toInt()),
    );
  }

  Duration pos = Duration.zero;
  Duration duration = Duration.zero;

  List<String> temp = [
    'asset/music/Aabaad Barbaad (From +Ludo+)_Pritam,Arijit Singh.mp3',
    'asset/music/Dil Galti Kar Baitha Hai.mp3',
    'asset/music/Dhokha (Feat. Khushalii Kumar)_Arijit Singh.mp3',
    'asset/music/Dil Ko Maine Di Kasam_Arijit Singh_Dil Ko Maine Di Kasam.mp3',
    'asset/music/Ae_Dil_Hai_Mushkil_Title_Track.mp3',
    'asset/music/Dekh_Lena_(From__Tum_Bin_2_).mp3',
    'asset/music/Aashiqui Aa Gayi_Arijit Singh.mp3',
    'asset/music/Kaise_Hua.mp3',
    'asset/music/Jeena_Jeena_(Audio_Song)___Badlapur___Varun_Dhawan,_Yami_Gautam___Nawazuddin_Sid.mp3',
    'asset/music/Jo Tum Aa Gaye Ho_Arijit Singh.mp3',
    'asset/music/Kabhi_Jo_Baadal_Barse_(From__Jackpot_).mp3',
    'asset/music/Kabhi_Yaadon_Mein_(From__Kabhi_Yaadon_Mein_).mp3',
  ];
  final List<Color> colors = [
    const Color(0xFFAF6CFA),
    const Color(0xFF833EAB),
    const Color(0xFF9D4097),
    const Color(0xFFBD41B3),
    const Color(0xCF9A4695),
    const Color(0xFFEF95FF),
  ];

  final List<int> durationmusic = [
    3500, // 3 seconds
    1500, // 2 seconds
    3700, // 4 seconds
    1000, // 1 second
    4500, // 2.5 seconds
    400,
  ];
  List<String> songs = [];
  // 3:54,3:55,3:59,4:14,5:12
  int i = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getVolume();
    songs.addAll(temp);
    isDarkMode = pref!.getBool("mode") ?? false;
    init();
  }

  void getVolume() {
    PerfectVolumeControl.hideUI = false;
    Future.delayed(Duration.zero, () async {
      volume = await PerfectVolumeControl.getVolume();
      setState(() {});
    });

    PerfectVolumeControl.stream.listen((event) {
      setState(() {
        volume = event;
      });
    });
  }

  void init() {
    player.setAsset(songs[i]);
    player.positionStream.listen((event) {
      setState(() {
        pos = event;
      });
    });

    player.durationStream.listen((event) {
      setState(() {
        duration = event!;
      });
    });

    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        if (i == songs.length - 1 && repeat != true) {
          setState(() {
            pos = Duration.zero;
          });
          player.pause();
          player.seek(pos);
        } else {
          // i++;
          // player.setAsset('${songs[i]}');

          if (repeat == false) {
            i++;
            player.setAsset(songs[i]);
            print("repeat up : $repeat");
          } else {
            player.setAsset(songs[i]);
          }
        }
        print("i : $i");
        print("len : ${songs.length}");
      }
    });
  }

  bool repeat = false;
  bool shuffle = false;
  bool editbool = false;
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            right: 15,
            top: 30,
            child: IconButton(
              onPressed: () {
                print("like");
              },
              icon: const Icon(
                CupertinoIcons.heart,
              ),
              splashRadius: 10,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(
                height: 30,
              ),
              Text("Music",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w900)),
              const Spacer(),
              Transform.scale(
                scale: 1.6,
                child: Stack(
                  children: [
                    SleekCircularSlider(
                      innerWidget: (percentage) {
                        return Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(400),
                                color: (isDarkMode == false)
                                    ? Colors.grey.shade100
                                    : Colors.black87,
                                boxShadow: [
                                  (isDarkMode == false)
                                      ? BoxShadow(
                                          color: Colors.black.withOpacity(0.15),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: const Offset(2, 2),
                                        )
                                      : BoxShadow(
                                          color: Colors.white.withOpacity(0.15),
                                          blurRadius: 5,
                                          spreadRadius: 2,
                                          offset: const Offset(2, 2),
                                        ),
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(250),
                                  child: Image.asset(
                                    "asset/pic/shiva.jpg",
                                    filterQuality: FilterQuality.medium,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      appearance: CircularSliderAppearance(
                          customWidths: CustomSliderWidths(
                            trackWidth: 1,
                            handlerSize: 1.5,
                            shadowWidth: 2,
                            progressBarWidth: 7,
                          ),
                          counterClockwise: false),
                      min: 0,
                      max: 1,
                      initialValue: volume,
                      onChange: (double value) {
                        volume = value;
                        PerfectVolumeControl.setVolume(volume);
                        print("volume : $volume");
                        setState(() {});
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: IconButton(
                        onPressed: () {
                          volume = 0;
                          PerfectVolumeControl.setVolume(volume);
                          print("volume : $volume");
                          setState(() {});
                        },
                        splashRadius: 12,
                        icon: const Icon(
                          CupertinoIcons.volume_mute,
                          size: 10,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          volume = 1;
                          PerfectVolumeControl.setVolume(volume);
                          print("volume : $volume");
                          setState(() {});
                        },
                        splashRadius: 12,
                        icon: const Icon(
                          CupertinoIcons.volume_up,
                          size: 10,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(songs[i]),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: (player.playing)
                      ? MusicVisualizer(
                          barCount: 20,
                          curve: Curves.easeIn,
                          colors: colors,
                          duration: durationmusic,
                        )
                      : Center(
                          child: Container(
                          height: 2,
                          decoration: const BoxDecoration(
                              gradient: LinearGradient(colors: [
                            Color(0xFFAF6CFA),
                            Color(0xFF833EAB),
                            Color(0xFF9D4097),
                            Color(0xFFBD41B3),
                            Color(0xCF9A4695),
                            Color(0xFFEF95FF),
                          ])),
                        )),
                ),
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(formateDuration(pos)),
                  ),
                  Expanded(
                    child: SliderTheme(
                      data: SliderThemeData(trackHeight: 8),
                      // child: Slider(
                      //   min: 00,
                      //   max: duration.inSeconds.toDouble(),
                      //   value: pos.inSeconds.toDouble(),
                      //   onChanged: handleseek,
                      // ),
                      child: GradientSlider(
                        thumbHeight: 1,
                        thumbWidth: 1,
                        activeTrackGradient: LinearGradient(colors: [
                          Color(0xFFAF6CFA),
                          Color(0xFF833EAB),
                          Color(0xFF9D4097),
                          Color(0xFFBD41B3),
                        ]),
                        inactiveTrackGradient: LinearGradient(colors: [
                          Color(0xFFAF6CFA).withOpacity(.30),
                          Color(0xFF833EAB).withOpacity(.30),
                          Color(0xFF9D4097).withOpacity(.30),
                          Color(0xFFBD41B3).withOpacity(.30),
                        ]),
                        slider: Slider(
                            min: 00,
                            max: duration.inSeconds.toDouble(),
                            value: pos.inSeconds.toDouble(),
                            onChanged: handleseek,
                            thumbColor: Color(0xff7c266c)),
                        thumbAsset: '',
                        trackHeight: 8,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: Text(formateDuration(duration)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        repeat = !repeat;
                        if (repeat == true) {
                          shuffle = false;
                        }
                        print("repeat : $repeat");
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            behavior: SnackBarBehavior.floating,
                            margin: const EdgeInsets.only(
                                left: 50, right: 50, bottom: 40),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            backgroundColor: (isDarkMode == false)
                                ? Colors.black87
                                : Colors.white54,
                            duration: const Duration(milliseconds: 800),
                            content: Center(
                              child: Text((repeat)
                                  ? "single loop mode"
                                  : "current playlist is looped"),
                            ),
                          ),
                        );
                      });
                    },
                    icon: Icon(
                      (repeat == false)
                          ? CupertinoIcons.repeat
                          : CupertinoIcons.repeat_1,
                      size: 18,
                    ),
                    splashRadius: 18,
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: (isDarkMode == false)
                              ? Colors.grey.shade50
                              : Colors.black,
                          boxShadow: [
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(2, 2),
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.20),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: const Offset(1, 2),
                                  ),
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.white.withOpacity(.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  )
                                : BoxShadow(
                                    color: Colors.black.withOpacity(0.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (i != 0) {
                              i--;
                              player.setAsset(songs[i]);
                            }
                          },
                          icon: const Icon(
                            CupertinoIcons.backward_end_fill,
                            size: 20,
                          ),
                          splashRadius: 15,
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: (isDarkMode == false)
                              ? Colors.grey.shade50
                              : Colors.black,
                          boxShadow: [
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(2, 2),
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.20),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: const Offset(1, 2),
                                  ),
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.white.withOpacity(.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  )
                                : BoxShadow(
                                    color: Colors.black.withOpacity(0.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (pos >= const Duration(seconds: 10)) {
                              setState(() {
                                pos = pos - const Duration(seconds: 10);
                              });
                            } else {
                              setState(() {
                                pos = Duration.zero;
                              });
                            }
                            player.seek(pos);
                          },
                          icon: const Icon(
                            CupertinoIcons.backward_fill,
                            size: 20,
                          ),
                          splashRadius: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 65,
                      height: 65,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(65),
                        color: (isDarkMode == false)
                            ? Colors.grey.shade50
                            : Colors.black,
                        boxShadow: [
                          (isDarkMode == false)
                              ? BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: const Offset(2, 2),
                                )
                              : BoxShadow(
                                  color: Colors.white.withOpacity(0.20),
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                  offset: const Offset(1, 2),
                                ),
                          (isDarkMode == false)
                              ? BoxShadow(
                                  color: Colors.white.withOpacity(.9),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: const Offset(-2, -1),
                                )
                              : BoxShadow(
                                  color: Colors.black.withOpacity(0.9),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                  offset: const Offset(-2, -1),
                                ),
                        ],
                      ),
                      child: InkWell(
                        onTap: handleplaypause,
                        child: Padding(
                          padding: (player.playing)
                              ? const EdgeInsets.only(left: 0)
                              : const EdgeInsets.only(left: 4),
                          child: Icon(
                            player.playing
                                ? CupertinoIcons.pause_fill
                                : CupertinoIcons.play_fill,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 50,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: (isDarkMode == false)
                              ? Colors.grey.shade50
                              : Colors.black,
                          boxShadow: [
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(2, 2),
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.20),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: const Offset(1, 2),
                                  ),
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.white.withOpacity(.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  )
                                : BoxShadow(
                                    color: Colors.black.withOpacity(0.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (pos < duration - const Duration(seconds: 11)) {
                              setState(() {
                                pos = pos + const Duration(seconds: 10);
                              });
                            } else {
                              setState(() {
                                pos = duration;
                              });
                            }
                            player.seek(pos);
                          },
                          splashRadius: 18,
                          icon: const Icon(
                            CupertinoIcons.forward_fill,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Container(
                        width: 40,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(60),
                          color: (isDarkMode == false)
                              ? Colors.grey.shade50
                              : Colors.black,
                          boxShadow: [
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.black.withOpacity(0.15),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(2, 2),
                                  )
                                : BoxShadow(
                                    color: Colors.white.withOpacity(0.20),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                    offset: const Offset(1, 2),
                                  ),
                            (isDarkMode == false)
                                ? BoxShadow(
                                    color: Colors.white.withOpacity(.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  )
                                : BoxShadow(
                                    color: Colors.black.withOpacity(0.9),
                                    blurRadius: 5,
                                    spreadRadius: 2,
                                    offset: const Offset(-2, -1),
                                  ),
                          ],
                        ),
                        child: IconButton(
                          onPressed: () {
                            if (i < songs.length - 1) {
                              i++;
                              player.setAsset(songs[i]);
                            }
                          },
                          icon: const Icon(
                            CupertinoIcons.forward_end_fill,
                            size: 20,
                          ),
                          splashRadius: 15,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      shuffle = !shuffle;

                      if (shuffle == true) {
                        setState(() {
                          songs.clear();
                          songs.addAll(temp);
                          songs.shuffle();
                          repeat = false;
                          i = 0;
                          player.setAsset(songs[i]);
                        });
                      } else {
                        setState(() {
                          songs.clear();
                          songs.addAll(temp);
                          i = 0;
                          player.setAsset(songs[i]);
                        });
                      }
                      for (int i = 0; i < temp.length; i++) {
                        if (temp[i] == songs[i]) {
                          print("yes same");
                        } else {
                          print("no same");
                        }
                      }
                      print("list ===== $songs");

                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          behavior: SnackBarBehavior.floating,
                          margin: const EdgeInsets.only(
                              left: 50, right: 50, bottom: 40),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          backgroundColor: (isDarkMode == false)
                              ? Colors.black87
                              : Colors.white54,
                          duration: const Duration(milliseconds: 800),
                          content: Center(
                            child: Text((shuffle)
                                ? 'suffle mode on'
                                : "suffle mode off"),
                          ),
                        ),
                      );
                    },
                    icon: Icon(
                      (!shuffle)
                          ? CupertinoIcons.shuffle
                          : CupertinoIcons.clear,
                      size: 18,
                    ),
                    splashRadius: 18,
                  ),
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
