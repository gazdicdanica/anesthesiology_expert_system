class Patient {
  final int id;

  final String fullname;
  final String jmbg;
  final int age;
  final double weight;
  final double height;
  final double BMI;

  int basalSAP;

  int RCRIScore;
  PatientRisk? risk;
  bool hasDiabetes;
  bool isDMControlled;
  bool hadHearthAttack;
  bool hasHearthFailure;
  bool hasHypertension;
  bool controlledHypertension;
  bool hadStroke;
  bool hasRenalFailure;
  bool hasCVSFamilyHistory;

  bool addictions;
  bool smokerOrAlcoholic;

  bool pregnant;

  ASA? asa;

  Patient({
    required this.id,
    required this.fullname,
    required this.jmbg,
    required this.age,
    required this.weight,
    required this.height,
    required this.BMI,
    required this.basalSAP,
    required this.RCRIScore,
    required this.risk,
    required this.hasDiabetes,
    required this.isDMControlled,
    required this.hadHearthAttack,
    required this.hasHearthFailure,
    required this.hasHypertension,
    required this.controlledHypertension,
    required this.hadStroke,
    required this.hasRenalFailure,
    required this.hasCVSFamilyHistory,
    required this.addictions,
    required this.smokerOrAlcoholic,
    required this.pregnant,
    required this.asa,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullname: json['fullname'],
      jmbg: json['jmbg'],
      age: json['age'],
      weight: json['weight'],
      height: json['height'],
      BMI: json['bmi'],
      basalSAP: json['basalSAP'],
      RCRIScore: json['rcriscore'],
      risk: _parseRisk(json['risk']),
      hasDiabetes: json['hasDiabetes'],
      isDMControlled: json['dmcontrolled'],
      hadHearthAttack: json['hadHearthAttack'],
      hasHearthFailure: json['hasHearthFailure'],
      hasHypertension: json['hasHypertension'],
      controlledHypertension: json['controlledHypertension'],
      hadStroke: json['hadStroke'],
      hasRenalFailure: json['hasRenalFailure'],
      hasCVSFamilyHistory: json['hasCVSFamilyHistory'],
      addictions: json['addictions'],
      smokerOrAlcoholic: json['smokerOrAlcoholic'],
      pregnant: json['pregnant'],
      asa: _parseASA(json['asa']),
    );
  }

  static PatientRisk? _parseRisk(String? risk) {
    switch (risk) {
      case 'LOW':
        return PatientRisk.LOW;
      case 'MEDIUM':
        return PatientRisk.MEDIUM;
      case 'HIGH':
        return PatientRisk.HIGH;
      default:
        return null;
        // throw ArgumentError('Invalid risk value: $risk');
    }
  }

  static ASA? _parseASA(String? asa) {
    switch (asa) {
      case 'I':
        return ASA.I;
      case 'II':
        return ASA.II;
      case 'III':
        return ASA.III;
      case 'IV':
        return ASA.IV;
      case 'V':
        return ASA.V;
      default:
        return null;
        // throw ArgumentError('Invalid ASA value: $asa');
    }
  }
}

enum ASA { I, II, III, IV, V }

enum PatientRisk { LOW, MEDIUM, HIGH }

String getRiskString(PatientRisk risk) {
  switch (risk) {
    case PatientRisk.LOW:
      return 'Nizak';
    case PatientRisk.MEDIUM:
      return 'Srednji';
    case PatientRisk.HIGH:
      return 'Visok';
  }
}

class PatientDTO {
  final String fullname;
  final String jmbg;
  final int age;
  final double weight;
  final double height;

  bool hasDiabetes;
  bool hadHearthAttack;
  bool hasHearthFailure;
  bool hasHypertension;
  bool controlledHypertension;
  bool hadStroke;
  bool hasRenalFailure;
  bool addictions;
  bool smokerOrAlcoholic;

  bool pregnant;

  PatientDTO({
    required this.fullname,
    required this.jmbg,
    required this.age,
    required this.weight,
    required this.height,
    required this.hasDiabetes,
    required this.hadHearthAttack,
    required this.hasHearthFailure,
    required this.hasHypertension,
    required this.controlledHypertension,
    required this.hadStroke,
    required this.hasRenalFailure,
    required this.addictions,
    required this.smokerOrAlcoholic,
    required this.pregnant,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullname': fullname,
      'jmbg': jmbg,
      'age': age,
      'weight': weight,
      'height': height,
      'hasDiabetes': hasDiabetes,
      'hadHearthAttack': hadHearthAttack,
      'hasHearthFailure': hasHearthFailure,
      'hasHypertension': hasHypertension,
      'controlledHypertension': controlledHypertension,
      'hadStroke': hadStroke,
      'hasRenalFailure': hasRenalFailure,
      'addictions': addictions,
      'smokerOrAlcoholic': smokerOrAlcoholic,
      'pregnant': pregnant,
    };
  }
}
