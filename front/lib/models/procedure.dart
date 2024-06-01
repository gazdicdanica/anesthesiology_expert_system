class Procedure {
  final int id;
  final int patientId;
  final int medicalStaffId;
  final OperationRisk risk;
  final ProcedureUrgency urgency;
  final PreOperative preOperative;
  final PostOperative? postOperative;

  Procedure({
    required this.id,
    required this.patientId,
    required this.medicalStaffId,
    required this.risk,
    required this.urgency,
    required this.preOperative,
    this.postOperative,
  });

  factory Procedure.fromJson(Map<String, dynamic> json) {
    return Procedure(
      id: json['id'],
      patientId: json['patientId'],
      medicalStaffId: json['medicalStaffId'],
      risk: getRisk(json['risk']),
      urgency: getUrgency(json['urgency']),
      preOperative: PreOperative.fromJson(json['preOperative']),
      postOperative: json['postOperative'],
    );
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
}

class PostOperative {
  final int id;
  final int hemoglobin;

  PostOperative({
    required this.id,
    required this.hemoglobin,
  });
}
