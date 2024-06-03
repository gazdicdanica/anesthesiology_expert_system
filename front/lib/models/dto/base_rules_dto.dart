import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';

class BaseRulesDTO{
  final Patient patient;
  final Procedure procedure;

  BaseRulesDTO(this.patient, this.procedure);

  Map<String, dynamic> toJson() {
    return {
      'patient': patient.toJson(),
      'procedure': procedure.toJson(),
    };
  }

  factory BaseRulesDTO.fromJson(Map<String, dynamic> json) {
    return BaseRulesDTO(
      Patient.fromJson(json['patient']),
      Procedure.fromJson(json['procedure']),
    );
  }
}