import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:sign_go/data.dart';
import 'package:speech_to_text/speech_to_text.dart';

import 'PhraseToSign.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SpeechToText speechToText = SpeechToText();
  var text = "hello";
  bool isListening = false;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Speech to sign",
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 35,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () => Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Home())),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Speech To Sign Language",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => PharseToSign())),
                child: Container(
                  alignment: Alignment.center,
                  height: 50,
                  width: width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Phrase To Sign Language",
                      style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 40,
          ),
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
          SizedBox(
            height: 30,
          ),
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
      ),
    );
  }
}
