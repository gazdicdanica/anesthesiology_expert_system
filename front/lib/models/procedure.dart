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
      postOperative: json['postOperative'],
      intraOperative: json['intraOperative'],
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
      'postOperative': postOperative,
      'intraOperative': intraOperative,
    };
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

  PreOperative({
    this.id,
    required this.shouldContinueProcedure,
    this.SIB,
    this.HBA1C,
    this.creatinine,
    this.bnpValue,
  });

  factory PreOperative.fromJson(Map<String, dynamic> json) {
    return PreOperative(
      id: json['id'],
      shouldContinueProcedure: json['shouldContinueProcedure'],
      SIB: json['sib'],
      HBA1C: json['hba1C'],
      creatinine: json['creatinine'],
      bnpValue: json['bnpValue'],
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
    };
  
  }
}

class PostOperative {
  final int id;
  final int hemoglobin;
  final bool isReleased;

  PostOperative({
    required this.id,
    required this.hemoglobin,
    required this.isReleased,
  });

  factory PostOperative.fromJson(Map<String, dynamic> json) {
    return PostOperative(
      id: json['id'],
      hemoglobin: json['hemoglobin'],
      isReleased: json['isReleased'],
    );
  }

  toJson() {
    return {
      'id': id,
      'hemoglobin': hemoglobin,
      'isReleased': isReleased,
    };
  }
}

class IntraOperative {

}
