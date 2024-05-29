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
  PatientRisk risk;
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

  ASA asa;

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
}

enum ASA { I, II, III, IV, V }

enum PatientRisk { LOW, MEDIUM, HIGH }
