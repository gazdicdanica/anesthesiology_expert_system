import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';

class DiagnosisDTO {
  final Patient patient;
  final Procedure procedure;

  DiagnosisDTO({required this.patient, required this.procedure});

  factory DiagnosisDTO.fromJson(Map<String, dynamic> json) {
    return DiagnosisDTO(
      patient: Patient.fromJson(json['patient']),
      procedure: Procedure.fromJson(json['procedure']),
    );
  }
}