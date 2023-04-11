import 'dart:async';

import 'package:flutter/material.dart';

import '../model/products.dart';
import './detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController _controller = ScrollController();
  int currentIndex = 0;
  Timer? timer;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    cancelTimer();
    super.dispose();
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 2), (timer) {
      setState(() {
        currentIndex = (currentIndex + 1) % 1000;
      });
      scrollListViewToIndex(currentIndex);
    });
  }

  void cancelTimer() {
    timer?.cancel();
    timer = null;
  }

  void scrollListViewToIndex(int index) {
    final itemExtent = MediaQuery.of(context).size.width * 0.5598;
    final offset = index * itemExtent;
    _controller.animateTo(offset,
        duration: const Duration(seconds: 1), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            ],
          ),
          elevation: 0,
        ),
        bottomNavigationBar: Container(
          clipBehavior: Clip.hardEdge,
          height: 80,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.person,
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.home,
                  size: 30,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: const Color.fromARGB(255, 185, 215, 211),
            child: Column(children: [
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 30),
                height: 100,
                child: Column(
                  children: [
                    Row(children: [
                      Container(
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                        ),
                        height: 40,
                        width: 70,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            SizedBox(width: 10),
                            Text(
                              "All",
                              style: TextStyle(color: Colors.white),
                            ),
                            Icon(
                              Icons.add_circle,
                              color: Colors.orange,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(60)),
                          color: Colors.white,
                        ),
                        height: 40,
                        width: 160,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: const [
                            SizedBox(width: 10),
                            Text(
                              "Mobile Controller",
                            ),
                            Icon(
                              Icons.add_circle,
                              color: Colors.orange,
                              size: 35,
                            )
                          ],
                        ),
                      ),
                    ]),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: Colors.white,
                          ),
                          height: 40,
                          width: 120,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              SizedBox(width: 10),
                              Text(
                                "Razorose",
                              ),
                              Icon(
                                Icons.add_circle,
                                color: Colors.orange,
                                size: 35,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(2),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(60)),
                            color: Colors.white,
                          ),
                          height: 40,
                          width: 170,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              SizedBox(width: 10),
                              Text(
                                "Mobile Controller",
                              ),
                              Icon(
                                Icons.add_circle,
                                color: Colors.orange,
                                size: 35,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 350,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: 1000,
                  itemBuilder: (context, index) {
                    final item = products[index % products.length];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration:
                                const Duration(seconds: 1, milliseconds: 500),
                            pageBuilder: (_, __, ___) => DetailScreen(
                              model: item,
                              tag: index.toString() + item.description,
                            ),
                          ),
                        );
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        alignment: currentIndex == index
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 185, 215, 211),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        height: currentIndex == index ? 300 : 250,
                        width: currentIndex == index ? 250 : 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Hero(
                              tag: index.toString() + item.description,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                height: currentIndex == index ? 250 : 200,
                                width: currentIndex == index ? 250 : 200,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    item.imgAddress,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              height: 50,
                              width: currentIndex == index ? 250 : 200,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 185, 215, 211),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text("\$ ${item.price.toString()}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Text(
                                    item.description,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: 350,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  itemCount: 1000,
                  itemBuilder: (context, index) {
                    final item = products[index % products.length];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(seconds: 1, milliseconds: 500),
                              pageBuilder: (_, __, ___) => DetailScreen(
                                model: item,
                                tag: index.toString() + item.imgAddress,
                              ),
                            ));
                      },
                      child: AnimatedContainer(
                        duration: const Duration(seconds: 1),
                        alignment: currentIndex == index
                            ? Alignment.topCenter
                            : Alignment.bottomCenter,
                        margin: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 185, 215, 211),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        height: currentIndex == index ? 300 : 250,
                        width: currentIndex == index ? 250 : 200,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Hero(
                              tag: index.toString() + item.imgAddress,
                              child: AnimatedContainer(
                                duration: const Duration(seconds: 1),
                                height: currentIndex == index ? 250 : 200,
                                width: currentIndex == index ? 250 : 200,
                                decoration: const BoxDecoration(
                                  color: Color.fromRGBO(221, 221, 221, 1),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(20),
                                  ),
                                  child: Image.asset(
                                    item.imgAddress,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              height: 50,
                              width: currentIndex == index ? 250 : 200,
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 185, 215, 211),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                              ),
                              margin: const EdgeInsets.all(5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.name,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text("\$ ${item.price.toString()}",
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          )),
                                    ],
                                  ),
                                  Text(
                                    item.description,
                                    textAlign: TextAlign.start,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black54,
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ]),
          ),
        ));
  }
}
