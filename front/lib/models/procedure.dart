import 'package:front/models/alarm.dart';

class Procedure {
  final int id;
  final int patientId;
  final int medicalStaffId;
  final String name;
  final OperationRisk risk;
  final ProcedureUrgency urgency;
  final PreOperative preOperative;
  final PostOperative? postOperative;
  final IntraOperative? intraOperative;

  Procedure({
    required this.id,
    required this.patientId,
    required this.medicalStaffId,
    required this.name,
    required this.risk,
    required this.urgency,
    required this.preOperative,
    this.postOperative,
    this.intraOperative,
  });

  factory Procedure.fromJson(Map<String, dynamic> json) {
    return Procedure(
      id: json['id'],
      patientId: json['patientId'],
      medicalStaffId: json['medicalStaffId'],
      name: json['name'],
      risk: getRisk(json['risk']),
      urgency: getUrgency(json['urgency']),
      preOperative: PreOperative.fromJson(json['preOperative']),
      postOperative: json["postOperative"] != null ? PostOperative.fromJson(json['postOperative']) : null,
      intraOperative: json["intraOperative"] != null ? IntraOperative.fromJson(json['intraOperative']) : null,
    );
  }

  toJson() {
    return {
      'id': id,
      'patientId': patientId,
      'medicalStaffId': medicalStaffId,
      'name': name,
      'risk': risk.toString().split('.').last,
      'urgency': urgency.toString().split('.').last,
      'preOperative': preOperative.toJson(),
      'postOperative': postOperative == null ? postOperative : postOperative!.toJson(),
      'intraOperative': intraOperative == null ? intraOperative : intraOperative!.toJson(),
    };
  }

  @override
  String toString() {
    return 'Procedure{id: $id, patientId: $patientId, medicalStaffId: $medicalStaffId, name: $name, risk: $risk, urgency: $urgency, preOperative: $preOperative, postOperative: $postOperative, intraOperative: $intraOperative}';
  }
}

ProcedureUrgency getUrgency(String urgency) {
  switch (urgency) {
    case 'IMMEDIATE':
      return ProcedureUrgency.IMMEDIATE;
    case 'URGENT':
      return ProcedureUrgency.URGENT;
    case 'TIME_SENSITIVE':
      return ProcedureUrgency.TIME_SENSITIVE;
    case 'ELECTIVE':
      return ProcedureUrgency.ELECTIVE;
    default:
      return ProcedureUrgency.IMMEDIATE;
  }
}

String getUrgencyString(ProcedureUrgency urgency) {
  switch (urgency) {
    case ProcedureUrgency.IMMEDIATE:
      return 'Neposredna';
    case ProcedureUrgency.URGENT:
      return 'Urgentna';
    case ProcedureUrgency.TIME_SENSITIVE:
      return 'Vremenski zavisna';
    case ProcedureUrgency.ELECTIVE:
      return 'Elektivna';
  }
}

OperationRisk getRisk(String risk) {
  switch (risk) {
    case 'LOW':
      return OperationRisk.LOW;
    case 'MEDIUM':
      return OperationRisk.MEDIUM;
    case 'HIGH':
      return OperationRisk.HIGH;
    default:
      return OperationRisk.LOW;
  }
}

String getRiskString(OperationRisk risk) {
  switch (risk) {
    case OperationRisk.LOW:
      return 'Nizak';
    case OperationRisk.MEDIUM:
      return 'Srednji';
    case OperationRisk.HIGH:
      return 'Visok';
  }
}

enum OperationRisk { LOW, MEDIUM, HIGH }

enum ProcedureUrgency {
  IMMEDIATE,
  URGENT,
  TIME_SENSITIVE,
  ELECTIVE,
}

class PreOperative {
  final int? id;
  final bool shouldContinueProcedure;
  final double? SIB;
  final double? HBA1C;
  final double? creatinine;
  final double? bnpValue;
  final String? postponeReason;
  final bool doBnp;

  PreOperative({
    this.id,
    required this.shouldContinueProcedure,
    this.SIB,
    this.HBA1C,
    this.creatinine,
    this.bnpValue,
    this.postponeReason,
    this.doBnp = false,
  });

  factory PreOperative.fromJson(Map<String, dynamic> json) {
    return PreOperative(
      id: json['id'],
      shouldContinueProcedure: json['shouldContinueProcedure'],
      SIB: json['sib'],
      HBA1C: json['hba1C'],
      creatinine: json['creatinine'],
      bnpValue: json['bnpValue'],
      postponeReason: json['postponeReason'],
      doBnp: json['doBnp'],
    );
  }

  toJson() {
    return {
      'id': id,
      'shouldContinueProcedure': shouldContinueProcedure,
      'sib': SIB,
      'hba1C': HBA1C,
      'creatinine': creatinine,
      'bnpValue': bnpValue,
      'postponeReason': postponeReason,
      'doBnp': doBnp,
    };
  }
}

class PostOperative {
  final int? id;
  final bool isReleased;
  Set<Alarm> alarms;

  PostOperative({
    this.id,
    required this.isReleased,
    this.alarms = const {},
  });

  factory PostOperative.fromJson(Map<String, dynamic> json) {
    return PostOperative(
      id: json['id'],
      isReleased: json['released'],
      alarms: (json['alarms'] as List).map((e) => Alarm.fromJson(e)).toSet(),
    );
  }

  toJson() {
    return {
      'id': id,
      'released': isReleased,
    };
  }
}

class IntraOperative {
  final int id;
  final Monitoring monitoring;
  final Set<Alarm> alarms;

  IntraOperative({
    required this.id,
    required this.monitoring,
    this.alarms = const {},
  });

  factory IntraOperative.fromJson(Map<String, dynamic> json) {
    return IntraOperative(
      id: json['id'],
      monitoring: getMonitoring(json['monitoring']),
      alarms: (json['alarms'] as List).map((e) => Alarm.fromJson(e)).toSet(),
    );
  }

  toJson() {
    return {
      'id': id,
      'monitoring': monitoring.toString().split('.').last,
    };
  }
}

getMonitoring(String monitoring) {
  switch (monitoring) {
    case 'INVASIVE':
      return Monitoring.INVASIVE;
    case 'NON_INVASIVE':
      return Monitoring.NON_INVASIVE;
    default:
      return Monitoring.NON_INVASIVE;
  }
}

getMonitoringString(Monitoring monitoring) {
  switch (monitoring) {
    case Monitoring.INVASIVE:
      return 'Invazivni monitoring, petokanalni EKG';
    case Monitoring.NON_INVASIVE:
      return 'Neinvazivni monitoring, trokanalni EKG';
  }
}

enum Monitoring { INVASIVE, NON_INVASIVE }