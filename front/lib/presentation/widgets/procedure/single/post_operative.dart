import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';
import 'package:front/server_path.dart';
import 'package:front/theme.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class PostOperativeWidget extends StatefulWidget {
  const PostOperativeWidget({super.key, required this.procedure});

  final Procedure procedure;

  @override
  State<PostOperativeWidget> createState() => _PostOperativeWidgetState();
}

class _PostOperativeWidgetState extends State<PostOperativeWidget> {
  StompClient? stompClient;
  final StreamController<Map<String, dynamic>?> _bpmController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _sapController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _bpmAlarmController =
      StreamController<Map<String, dynamic>?>.broadcast();

  late Procedure procedure;

  @override
  void initState() {
    super.initState();
    procedure = widget.procedure;

    stompClient = StompClient(
      config: StompConfig(
        url: socketPath,
        onConnect: onConnect,
        useSockJS: true,
        onWebSocketError: (dynamic error) {
          print(error);
        },
      ),
    );

    stompClient?.activate();
  }

  void onConnect(StompFrame frame) {
    stompClient?.subscribe(
      destination: '/heartbeat/post/${widget.procedure.id}',
      callback: (StompFrame frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        _bpmController.add(result);
      },
    );

    stompClient?.subscribe(
      destination: '/sap/post/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        _sapController.add(result);
      },
    );

    stompClient?.subscribe(
      destination: '/alarm/cardio/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _bpmAlarmController.add(result);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Postoperativni oporavak',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
            ),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
          const SizedBox(height: 20),

        Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.favorite, color: seedColor),
                    const SizedBox(width: 8),
                    Text(
                      "BPM  ",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    if (stompClient != null)
                      StreamBuilder<Map<String, dynamic>?>(
                        stream: _bpmController.stream,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const SizedBox(
                              height: 18,
                              width: 18,
                              child: CircularProgressIndicator(),
                            );
                          }
                          if (snapshot.hasData) {
                            return Text(
                              snapshot.data!['bpm'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: snackBarColor,
                                  ),
                            );
                          }

                          return Container();
                        },
                      )
                    else
                      Text(
                        "...",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: snackBarColor,
                            ),
                      ),
                  ],
                ),
                if (stompClient != null)
                  StreamBuilder<Map<String, dynamic>?>(
                    stream: _bpmAlarmController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String? alarm = snapshot.data!['symptom'];
                        if (alarm != null) {
                          return Text(
                            alarm,
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                          );
                        }
                      }

                      return Container();
                    },
                  )
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.monitor_heart_outlined, color: seedColor),
                const SizedBox(width: 8),
                Text(
                  "SAP  ",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (stompClient != null)
                  StreamBuilder<Map<String, dynamic>?>(
                    stream: _sapController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.hasData) {
                        return Text(
                          snapshot.data!['sap'].toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: snackBarColor,
                                  ),
                        );
                      }
                      return Container();
                    },
                  )
                else
                  Text(
                    "...",
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: snackBarColor,
                        ),
                  ),
              ],
            ),
          const SizedBox(height: 20),

          ],
        )
      ],
    );
  }
}
