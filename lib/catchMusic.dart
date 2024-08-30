import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:music_app/by_asset_music.dart';
import 'package:music_app/variable.dart';
import 'package:on_audio_query/on_audio_query.dart';

class catchMusic extends StatefulWidget {
  const catchMusic({super.key});
  @override
  _catchMusicState createState() => _catchMusicState();
}

class _catchMusicState extends State<catchMusic> {
  final OnAudioQuery _audioQuery = OnAudioQuery();
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _audioQuery.setLogConfig(LogConfig(logType: LogType.DEBUG));
    _checkAndRequestPermissions(); // Ensure the method is called in initState
  }

  Future<void> _checkAndRequestPermissions({bool retry = false}) async {
    final player = AudioPlayer();
    await player.dispose();
    try {
      _hasPermission = await _audioQuery.checkAndRequest(retryRequest: retry);
      if (_hasPermission) {
        debugPrint('Permission granted');
        setState(() {});
      } else {
        debugPrint('Permission denied');
      }
    } catch (e) {
      debugPrint('Error checking permissions: $e');
    }
  }

  AudioPlayer player = AudioPlayer();
  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              // Navigator.pushReplacement(
              //     context,
              //     CupertinoPageRoute(
              //       builder: (context) => music_ByAsset(),
              //     ));
            },
            icon: Icon(
              CupertinoIcons.back,
            )),
        title: Text("Get Music"),
      ),
      body: Center(
        child: !_hasPermission
            ? noAccessToLibraryWidget()
            : FutureBuilder<List<SongModel>>(
                future: _audioQuery.querySongs(
                  sortType: null,
                  orderType: OrderType.ASC_OR_SMALLER,
                  uriType: UriType.EXTERNAL,
                  ignoreCase: true,
                ),
                builder: (context, item) {
                  if (item.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (item.hasError) {
                    debugPrint('Error: ${item.error}');
                    return Text('Error: ${item.error}');
                  } else if (!item.hasData || item.data!.isEmpty) {
                    return const Text("Nothing found!");
                  } else {
                    return ListView.builder(
                      itemCount: item.data!.length,
                      itemBuilder: (context, index) {
                        print('+++ ++ ++ ${item.data![index]}');
                        return ListTile(
                          onTap: () async {
                            print("===${player.state}");
                            // if (player.state == PlayerState.disposed ||
                            //     player.state == PlayerState.stopped) {
                            //   player = AudioPlayer();
                            //   await player.play(
                            //       DeviceFileSource(item.data![index].data));
                            // }
                            if (player.state == PlayerState.playing) {
                              await player.release();
                              await player.play(
                                  DeviceFileSource(item.data![index].data));
                            } else {
                              player = AudioPlayer();
                              await player.play(
                                  DeviceFileSource(item.data![index].data));
                            }
                          },
                          title: Text(item.data![index].title),
                          subtitle:
                              Text(item.data![index].artist ?? "No Artist"),
                          trailing: const Icon(Icons.arrow_forward_rounded),
                          leading: QueryArtworkWidget(
                            errorBuilder: (p0, p1, p2) {
                              return Text("No image");
                            },
                            nullArtworkWidget: Text("No"),
                            controller: _audioQuery,
                            id: item.data![index].id,
                            type: ArtworkType.AUDIO,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
      ),
    );
  }

  Widget noAccessToLibraryWidget() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.redAccent.withOpacity(0.5),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text("Application doesn't have access to the library"),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => _checkAndRequestPermissions(retry: true),
            child: const Text("Allow"),
          ),
        ],
      ),
    );
  }
}
