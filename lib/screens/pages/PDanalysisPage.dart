import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:iconsax/iconsax.dart';
import 'package:permission_handler/permission_handler.dart';

class PDanalysisPage extends StatefulWidget {
  const PDanalysisPage({super.key});

  @override
  State<PDanalysisPage> createState() => _PDanalysisPageState();
}

class _PDanalysisPageState extends State<PDanalysisPage> {
  final record = FlutterSoundRecorder();
  final player = FlutterSoundPlayer();
  late File audio;
  bool isRecordReady = false;
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  AnimationController? _controller;
  // final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    initRecorder();
    initPlayer();
  }

  @override
  void dispose() {
    record.closeRecorder();
    player.closePlayer();
    super.dispose();
  }

  Future initPlayer() async {
    await player.openPlayer();
  }

  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      log('Permission denied');
      return;
    }

    await record.openRecorder();
    isRecordReady = true;
    record.setSubscriptionDuration(Duration(milliseconds: 500));
  }

  Future playAudio() async {
    await player.startPlayer(
      fromURI: audio.path,
      codec: Codec.pcm16WAV,
      whenFinished: () {
        setState(() {
          isPlaying = false;
        });
      },
    );
    setState(() {
      isPlaying = true;
    });
  }

  Future stopPlaying() async {
    await player.stopPlayer();
  }

  Future recordAudio() async {
    if (!isRecordReady) return;

    await record.startRecorder(
      toFile: 'test.aac',
      codec: Codec.aacADTS,
    );
  }

  Future stopRecording() async {
    final path = await record.stopRecorder();
    audio = File(path!);
    log('Audio file: $audio');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('PD Analysis'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              StreamBuilder(
                  stream: record.onProgress,
                  builder: (context, snapshot) {
                    final duration = snapshot.hasData
                        ? snapshot.data!.duration
                        : Duration.zero;
                    String twoDigits(int n) => n.toString().padLeft(2, '0');
                    final twoDigitMinutes =
                        twoDigits(duration.inMinutes.remainder(60));
                    final twoDigitSeconds =
                        twoDigits(duration.inSeconds.remainder(60));
                    return Text('$twoDigitMinutes:$twoDigitSeconds',
                        style: TextStyle(
                            color: const Color.fromARGB(255, 0, 0, 0),
                            fontSize: 20));
                  }),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    shape: CircleBorder(),
                    padding: EdgeInsets.all(20),
                  ),
                  onPressed: () async {
                    if (record.isStopped) {
                      await recordAudio();
                      player.onProgress!.listen((event) {
                        position = event.position;
                        setState(() {});
                      });
                    } else {
                      await stopRecording();
                    }
                    setState(() {});
                  },
                  child: Icon(
                      record.isRecording
                          ? Iconsax.stop_circle
                          : Iconsax.microphone,
                      color: Color.fromARGB(255, 0, 0, 0),
                      size: 40)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      onPressed: () async {
                        if (player.isPlaying) {
                          await stopPlaying();
                        } else {
                          await playAudio();

                          player.onProgress!.listen((event) {
                            position = event.position;
                            duration = event.duration;
                            setState(() {});
                          });
                        }
                        setState(() {});
                      },
                      child: Row(
                        children: [
                          Text('Play', style: TextStyle(color: Colors.black)),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(
                              player.isPlaying
                                  ? Iconsax.stop_circle
                                  : Iconsax.play,
                              color: Color.fromARGB(255, 0, 0, 0),
                              size: 20),
                        ],
                      )),
                  SizedBox(
                    width: 20,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 86, 222, 90),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text('Upload', style: TextStyle(color: Colors.black)),
                        SizedBox(
                          width: 5,
                        ),
                        Icon(Iconsax.document_upload, color: Colors.black),
                      ],
                    ),
                    onPressed: () {
                      showModalBottomSheet<void>(
                          showDragHandle: true,
                          anchorPoint: Offset(double.maxFinite, 0),
                          isScrollControlled: true,
                          scrollControlDisabledMaxHeightRatio: 0.2,
                          context: context,
                          builder: ((context) {
                            return Container(
                              height: 200,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  ListTile(
                                    title: Text('Upload'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  ListTile(
                                    title: Text('Record'),
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          }));
                    },
                  )
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
