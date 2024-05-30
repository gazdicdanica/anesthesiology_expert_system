part of 'patient_form_bloc.dart';

sealed class PatientFormState extends Equatable {
  const PatientFormState();

  @override
  List<Object> get props => [];
}

final class PatientFormValuesState extends PatientFormState {
  final String fullName;
  final String age;
  final String height;
  final String weight;
  final bool hasDiabetes;
  final bool hadHeartAttack;
  final bool hasHeartFailure;
  final bool hasHypertension;
  final bool controlledHypertension;
  final bool hadStroke;
  final bool hasRenalFailure;
  final bool hasCVSFamilyHistory;
  final bool addictions;
  final bool smokerOrAlcoholic;
  final bool pregnant;
  final String? fullNameError;
  final String? ageError;
  final String? heightError;
  final String? weightError;

  const PatientFormValuesState({
    this.fullName = '',
    this.age = '',
    this.height = '',
    this.weight = '',
    this.hasDiabetes = false,
    this.hadHeartAttack = false,
    this.hasHeartFailure = false,
    this.hasHypertension = false,
    this.controlledHypertension = true,
    this.hadStroke = false,
    this.hasRenalFailure = false,
    this.hasCVSFamilyHistory = true,
    this.addictions = false,
    this.smokerOrAlcoholic = false,
    this.pregnant = false,
    this.fullNameError,
    this.ageError,
    this.heightError,
    this.weightError,
  });

  PatientFormState copyWith({
    String? fullName,
    String? age,
    String? height,
    String? weight,
    bool? hasDiabetes,
    bool? hadHeartAttack,
    bool? hasHeartFailure,
    bool? hasHypertension,
    bool? controlledHypertension,
    bool? hadStroke,
    bool? hasRenalFailure,
    bool? hasCVSFamilyHistory,
    bool? addictions,
    bool? smokerOrAlcoholic,
    bool? pregnant,
    String? fullNameError,
    bool clearFullNameError = false,
    String? ageError,
    bool clearAgeError = false,
    String? heightError,
    bool clearHeightError = false,
    String? weightError,
    bool clearWeightError = false,
  }) {
    return PatientFormValuesState(
      fullName: fullName ?? this.fullName,
      age: age ?? this.age,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      hasDiabetes: hasDiabetes ?? this.hasDiabetes,
      hadHeartAttack: hadHeartAttack ?? this.hadHeartAttack,
      hasHeartFailure: hasHeartFailure ?? this.hasHeartFailure,
      hasHypertension: hasHypertension ?? this.hasHypertension,
      controlledHypertension:
          controlledHypertension ?? this.controlledHypertension,
      hadStroke: hadStroke ?? this.hadStroke,
      hasRenalFailure: hasRenalFailure ?? this.hasRenalFailure,
      hasCVSFamilyHistory: hasCVSFamilyHistory ?? this.hasCVSFamilyHistory,
      addictions: addictions ?? this.addictions,
      smokerOrAlcoholic: smokerOrAlcoholic ?? this.smokerOrAlcoholic,
      pregnant: pregnant ?? this.pregnant,
      fullNameError:
          clearFullNameError ? null : fullNameError ?? this.fullNameError,
      ageError: clearAgeError ? null : ageError ?? this.ageError,
      heightError: clearHeightError ? null : heightError ?? this.heightError,
      weightError: clearWeightError ? null : weightError ?? this.weightError,
    );
  }

  @override
  List<Object> get props => [
        fullName,
        age,
        height,
        weight,
        hasDiabetes,
        hadHeartAttack,
        hasHeartFailure,
        hasHypertension,
        controlledHypertension,
        hadStroke,
        hasRenalFailure,
        hasCVSFamilyHistory,
        addictions,
        smokerOrAlcoholic,
        pregnant
      ];
}
