import 'package:flutter/material.dart';
import 'package:animated_digit/animated_digit.dart';

import '../model/product.dart';

class DetailScreen extends StatefulWidget {
  Product model;
  String tag;
  bool start = true;
  Color _color = Colors.white;
  Color color = Colors.white;
  double _width = 0;
  Color _textColor = Colors.white;
  DetailScreen({required this.model, required this.tag});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 1)).then((value) {
      setState(() {
        widget.color = const Color.fromRGBO(221, 221, 221, 1);
        widget._color = const Color.fromRGBO(242, 241, 239, 1);
        widget._textColor = Colors.black;
      });
    }).then((value) => widget._width = 250);
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        width: width,
        height: height * 1.1,
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(children: [
                Container(
                  color: widget.color,
                  child: topInformationWidget(width, height),
                ),
                Positioned(
                  child: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  top: 50,
                  left: 20,
                ),
              ]),
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                height: height / 3,
                width: width,
                color: widget._color,
                child: Column(
                  children: [
                    Text(
                      widget.model.name,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: widget._textColor),
                    ),
                    Text(
                      widget.model.description,
                      style: TextStyle(fontSize: 20, color: widget._textColor),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Total Price"),
                      Row(
                        children: [
                          const SizedBox(height: 3),
                          const Text(
                            "\$",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          AnimatedDigitWidget(
                            value: widget.model.price,
                            textStyle: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      )
                    ],
                  ),
                  AnimatedContainer(
                    duration: const Duration(seconds: 1),
                    width: widget._width,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Center(
                      child: Text(
                        "Buy now",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  topInformationWidget(width, height) {
    return Container(
      width: width,
      height: height / 1.8,
      child: Positioned(
        top: 100,
        left: 30,
        child: Hero(
          tag: widget.tag,
          child: AnimatedContainer(
            duration: const Duration(seconds: 2),
            decoration: const BoxDecoration(
              color: Color.fromRGBO(221, 221, 221, 1),
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            height: widget.start ? height / 4.3 : 250,
            width: widget.start ? width / 1.3 : 250,
            child: Image(image: AssetImage(widget.model.imgAddress)),
          ),
        ),
      ),
    );
  }
}
