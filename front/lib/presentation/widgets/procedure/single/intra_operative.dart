import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/procedure_single_bloc/procedure_single_bloc.dart';
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
  StompClient? stompClient;
  final StreamController<Map<String, dynamic>?> _bpmController =
      StreamController<Map<String, dynamic>?>();
  final StreamController<Map<String, dynamic>?> _sapController =
      StreamController<Map<String, dynamic>?>();

  @override
  void initState() {
    super.initState();

    if (widget.procedure.intraOperative != null &&
        widget.procedure.postOperative == null) {
      connectStomp();
    }
  }

  void connectStomp() {
    stompClient = StompClient(
      config: StompConfig(
        url: 'http://192.168.0.19:8080/socket',
        onConnect: onConnectCallback,
        useSockJS: true,
        onWebSocketError: (dynamic error) {
          print(error);
        },
      ),
    );

    stompClient?.activate();
  }

  void onConnectCallback(StompFrame frame) {
    stompClient?.subscribe(
      destination: '/heartbeat/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        _bpmController.add(result);
      },
    );

    stompClient?.subscribe(
      destination: '/sap/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        _sapController.add(result);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProcedureSingleBloc, ProcedureSingleState>(
      listener: (context, state) {
        if (state is DisconnectState) {
          stompClient?.deactivate();
          _bpmController.close();
          _sapController.close();
        }
      },
      child: ExpansionTile(
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
                getMonitoringString(
                    widget.procedure.intraOperative!.monitoring),
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: snackBarColor,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 20),
          Column(
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
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    stompClient?.deactivate();
    _bpmController.close();
    _sapController.close();
  }
}
