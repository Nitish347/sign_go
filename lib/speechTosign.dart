import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';

import 'package:sign_go/data.dart';

class SpeechToSign extends StatefulWidget {
  const SpeechToSign({Key? key}) : super(key: key);

  @override
  State<SpeechToSign> createState() => _SpeechToSignState();
}

class _SpeechToSignState extends State<SpeechToSign> {
  SpeechToText speechToText = SpeechToText();
  var text = "hello";
  bool isListening = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        text.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  alignment: Alignment.center,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(Data().mp[text]),
                          fit: BoxFit.fill),
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                ),
              )
            : CircularProgressIndicator(),
        Text(
          text,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w500,
          ),
        ),
        Center(
          child: GestureDetector(
              onTapDown: (value) async {
                print("tapped");
                if (!isListening) {
                  print("tapped");
                  var available = await speechToText.initialize();
                  if (available) {
                    setState(() {
                      isListening = true;
                      speechToText.listen(onResult: (result) {
                        setState(() {
                          text = result.recognizedWords;
                          print(text);
                        });
                      });
                    });
                  }
                }
              },
              onTapUp: (val) {
                print("untapped");
                setState(() {
                  isListening = false;
                });
                speechToText.stop();
              },
              child: AvatarGlow(
                endRadius: 100,
                // duration: Duration(milliseconds: 500),
                // repeatPauseDuration: Duration(milliseconds: 500),
                animate: isListening,
                glowColor: Colors.red,
                repeat: true,
                child: CircleAvatar(
                  backgroundColor: isListening ? Colors.red : Colors.blue,
                  maxRadius: 40,
                  child: Icon(
                    Icons.mic,
                    size: 30,
                  ),
                ),
              )),
        )
      ],
    );
  }
}
