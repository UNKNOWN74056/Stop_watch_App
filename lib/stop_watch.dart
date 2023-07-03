import 'dart:async';

import 'package:flutter/material.dart';

class stop_watch extends StatefulWidget {
  const stop_watch({super.key});

  @override
  State<stop_watch> createState() => _stop_watchState();
}

class _stop_watchState extends State<stop_watch> {
  int seconds = 0, minutes = 0, hours = 0;
  String digitseconds = "00", digitminutes = "00", digithours = "00";
  Timer? time;
  bool started = false;
  List laps = [];

  void stop() {
    time!.cancel();
    setState(() {
      started = false;
    });
  }

  void clearlaps() {
    setState(() {
      laps.clear();
    });
  }

  void reset() {
    time!.cancel();
    setState(() {
      seconds = 0;
      minutes = 0;
      hours = 0;
      digitseconds = "00";
      digitminutes = "00";
      digithours = "00";

      started = false;
    });
  }

  void addlap() {
    String lap = "$digithours , $digitminutes , $digitseconds";
    setState(() {
      laps.add(lap);
    });
  }

  void start() {
    started = true;
    time = Timer.periodic(const Duration(seconds: 1), (timer) {
      int localseconds = seconds + 1;
      int localminutes = minutes;
      int localhours = hours;
      if (localseconds > 59) {
        if (localminutes > 99) {
          localhours++;
          localminutes = 0;
        }
      }
      setState(() {
        seconds = localseconds;
        minutes = localminutes;
        hours = localhours;
        digitseconds = (seconds >= 10) ? "$seconds" : "0$seconds";
        digithours = (seconds >= 10) ? "$hours" : "0$hours";
        digitminutes = (seconds >= 10) ? "$minutes" : "0$minutes";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 21, 14, 85),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Center(
                      child: Text(
                        "Stop Watch App",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "$digithours:$digitminutes:$digitseconds",
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 40),
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Center(
                      child: RawMaterialButton(
                        shape: const StadiumBorder(
                            side: BorderSide(color: Colors.blue)),
                        onPressed: () {
                          clearlaps();
                        },
                        child: const Text(
                          "Clear Laps",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: 350,
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 47, 59, 173),
                          borderRadius: BorderRadius.circular(8)),
                      child: ListView.builder(
                          itemCount: laps.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Lap ${index + 1}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                  Text(
                                    "${laps[index]}",
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: RawMaterialButton(
                            shape: const StadiumBorder(
                                side: BorderSide(color: Colors.blue)),
                            onPressed: () {
                              (!started) ? start() : stop();
                            },
                            child: Text(
                              (!started) ? "start" : "pause",
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        IconButton(
                            color: Colors.white,
                            onPressed: () {
                              addlap();
                            },
                            icon: const Icon(Icons.flag)),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: RawMaterialButton(
                            fillColor: Colors.blue,
                            shape: const StadiumBorder(
                                side: BorderSide(color: Colors.blue)),
                            onPressed: () {
                              reset();
                            },
                            child: const Text(
                              "Reset",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    )
                  ]),
            ),
          ),
        ));
  }
}
