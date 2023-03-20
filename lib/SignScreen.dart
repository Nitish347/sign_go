import 'package:flutter/material.dart';

import 'model.dart';

class SignScreen extends StatefulWidget {
  Model model = Model();
  SignScreen({required this.model});

  @override
  State<SignScreen> createState() => _SignScreenState();
}

class _SignScreenState extends State<SignScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Language"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Center(
            child: Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(
                        widget.model.url!,
                      ),
                      fit: BoxFit.fill)),
            ),
          ),
          Center(
            child: Text(
              widget.model.text!,
              style: TextStyle(fontSize: 20),
            ),
          )
        ],
      ),
    );
  }
}
