import 'package:flutter/material.dart';
import 'package:sign_go/SignScreen.dart';
import 'package:sign_go/data.dart';
import 'package:sign_go/model.dart';

import 'home.dart';

class PharseToSign extends StatefulWidget {
  const PharseToSign({Key? key}) : super(key: key);

  @override
  State<PharseToSign> createState() => _PharseToSign();
}

class _PharseToSign extends State<PharseToSign> {
  List<Model> ls = [];
  void mapping() {
    Data().mp1.forEach((k, v) {
      Model model = Model();
      model.text = k;
      model.url = v;
      ls.add(model);
    });
    print(ls);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mapping();
  }

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
            height: 50,
          ),
          Expanded(
            child: Container(
                height: 800,
                width: width,
                child: SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                        ls.length,
                        (index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 5),
                              child: InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            SignScreen(model: ls[index]))),
                                child: Container(
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(10)),
                                  height: 60,
                                  width: width,
                                  child: Text(
                                    ls[index].text!,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 17,
                                        color: Colors.white),
                                  ),
                                ),
                              ),
                            )),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
