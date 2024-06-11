import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/bloc/procedure_single_bloc/procedure_single_bloc.dart';
import 'package:front/models/procedure.dart';
import 'package:front/presentation/widgets/procedure/single/complications.dart';
import 'package:front/presentation/widgets/procedure/single/symptoms.dart';
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
  final StreamController<Map<String, dynamic>?> _sapAlarmController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _bpmAlarmController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _breathController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _breathAlarmController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _pulseController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _pulseAlarmController =
      StreamController<Map<String, dynamic>?>.broadcast();
  final StreamController<Map<String, dynamic>?> _pulseAlarmDialogController =
      StreamController<Map<String, dynamic>?>.broadcast();

  late Procedure procedure;

  bool ivVasopresor = false;

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
      destination: '/heartbeat/${widget.procedure.id}',
      callback: (StompFrame frame) {
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

    stompClient?.subscribe(
      destination: '/alarm/cardio/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _bpmAlarmController.add(result);
      },
    );

    stompClient?.subscribe(
      destination: '/breath/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _breathController.add(result);
      },
    );

    stompClient?.subscribe(
      destination: '/alarm/breath/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _breathAlarmController.add(result);
      },
    );
    stompClient?.subscribe(
      destination: '/alarm/sap/dialog/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _sapAlarmController.add(result);
      },
    );
    stompClient?.subscribe(
      destination: '/pulseoximetry/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _pulseController.add(result);
      },
    );
    stompClient?.subscribe(
      destination: '/alarm/pulseoximetry/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _pulseAlarmController.add(result);
      },
    );
    stompClient?.subscribe(
      destination: '/alarm/pulseoximetry/dialog/${widget.procedure.id}',
      callback: (frame) {
        Map<String, dynamic>? result = json.decode(frame.body!);
        print(result);
        _pulseAlarmDialogController.add(result);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProcedureSingleBloc, ProcedureSingleState>(
      listener: (context, state) {
        if (state is ProcedureSingleError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: snackBarColor,
            ),
          );
        }

        if (state is ProcedurePatientSuccess &&
            state.procedure!.postOperative!.isReleased) {
          procedure = state.procedure!;

          _cleanup();
          stompClient = null;
        }
      },
      child: ExpansionTile(
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
                                "${snapshot.data!['bpm']} bpm",
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
                            "${snapshot.data!['sap']} mmHg",
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
              if (stompClient != null)
                StreamBuilder<Map<String, dynamic>?>(
                  stream: _sapAlarmController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String? alarm = snapshot.data!['message'];

                      if (alarm != null && alarm != "") {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              softWrap: true,
                              maxLines: 5,
                              alarm,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                            ),
                          ],
                        );
                      }
                    }

                    return Container();
                  },
                ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.air, color: seedColor),
                      const SizedBox(width: 8),
                      Text(
                        "Frekvenca disanja  ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if (stompClient != null)
                        StreamBuilder<Map<String, dynamic>?>(
                          stream: _breathController.stream,
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
                                "${snapshot.data!['bpm']} ",
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: snackBarColor,
                                  ),
                        ),
                    ],
                  ),
                  if (stompClient != null)
                    StreamBuilder<Map<String, dynamic>?>(
                      stream: _breathAlarmController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String? alarm = snapshot.data!['symptom'];
                          if (alarm != null) {
                            return Text(
                              alarm,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.percent, color: seedColor),
                      const SizedBox(width: 8),
                      Text(
                        "Puls. oksimetrija  ",
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      if (stompClient != null)
                        StreamBuilder<Map<String, dynamic>?>(
                          stream: _pulseController.stream,
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
                                "${snapshot.data!['sap']} ",
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
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: snackBarColor,
                                  ),
                        ),
                    ],
                  ),
                  if (stompClient != null)
                    StreamBuilder<Map<String, dynamic>?>(
                      stream: _pulseAlarmController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          String? alarm = snapshot.data!['symptom'];
                          if (alarm != null) {
                            return Text(
                              alarm,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
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
              if (stompClient != null)
                StreamBuilder<Map<String, dynamic>?>(
                  stream: _pulseAlarmDialogController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      String? alarm = snapshot.data!['message'];
                      if (alarm != null && alarm != "") {
                        return Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              softWrap: true,
                              maxLines: 3,
                              alarm,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red,
                                  ),
                            ),
                          ],
                        );
                      }
                    }

                    return Container();
                  },
                ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              BlocBuilder<ProcedureSingleBloc, ProcedureSingleState>(
                builder: (context, state) {
                  if(state is ProcedurePatientSuccess){
                    if(state.procedure!= null){
                      return Complications(alarms: state.procedure!.postOperative!.alarms);

                    }
                    return Complications(alarms: procedure.postOperative!.alarms);

                  }
                  return Container();
                },
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
              Symptoms(procedure: procedure)
            ],
          )
        ],
      ),
    );
  }

  void _cleanup() {
    stompClient?.deactivate();
    _bpmController.close();
    _sapController.close();
    _bpmAlarmController.close();
    _sapAlarmController.close();
    _breathController.close();
    _breathAlarmController.close();
    _pulseController.close();
    _pulseAlarmController.close();
    _pulseAlarmDialogController.close();
  }

  @override
  void dispose() {
    super.dispose();
    _cleanup();
  }
}
