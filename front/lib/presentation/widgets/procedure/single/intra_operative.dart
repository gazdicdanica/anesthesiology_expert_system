import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/models/procedure.dart';
import 'package:front/theme.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

class IntraOperativeWidget extends StatefulWidget {
  const IntraOperativeWidget({super.key, required this.procedure});

  final Procedure procedure;

  @override
  State<IntraOperativeWidget> createState() => _IntraOperativeWidgetState();
}

class _IntraOperativeWidgetState extends State<IntraOperativeWidget> {
  late StompClient stompClient;

  @override
  void initState() {
    super.initState();
    connectStomp();
  }

  void connectStomp() {
    stompClient = StompClient(
      config: StompConfig(
          url: 'http://localhost:8080/socket', onConnect: onConnectCallback, useSockJS: true),
    );

    stompClient.activate();
  }

  void onConnectCallback(StompFrame frame) {
    stompClient.subscribe(
      destination: '/heartbeat/${widget.procedure.id}',
      callback: (frame) {
        List<dynamic>? result = json.decode(frame.body!);
        print(result);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Operacija',
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontSize: 20,
            ),
      ),
      childrenPadding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const SizedBox(height: 10),
        Wrap(
          runSpacing: 6.0,
          children: [
            const Icon(
              Icons.monitor_heart,
              color: seedColor,
            ),
            const SizedBox(width: 8),
            Text(
              "Monitoring  ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              getMonitoringString(widget.procedure.intraOperative!.monitoring),
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                    color: snackBarColor,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    stompClient.deactivate();
  }
}
