import 'dart:convert';

import 'package:front/data/procedure/data_provider/procedure_data_provider.dart';
import 'package:front/models/alarm.dart';
import 'package:front/models/dto/base_rules_dto.dart';
import 'package:front/models/dto/diagnosis_dto.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';
import 'package:front/models/user.dart';

class ProcedureRepository {
  final ProcedureDataProvider _procedureDataProvider;

  ProcedureRepository(this._procedureDataProvider);

  Future<Procedure> addProcedure(int patientId, OperationRisk risk,
      ProcedureUrgency urgency, String name, int staffId) async {
    String response = await _procedureDataProvider.addProcedure(
        patientId, risk, urgency, name, staffId);
    String decodedResponse = utf8.decode(response.runes.toList());
    return Procedure.fromJson(jsonDecode(decodedResponse));
  }

  Future<List<Procedure>> fetchProcedures() async {
    String response = await _procedureDataProvider.fetchProcedures();
    List<dynamic> procedures = jsonDecode(response);
    return procedures
        .map((procedure) => Procedure.fromJson(procedure))
        .toList()
        .reversed
        .toList();
  }

  Future<Patient> fetchPatient(int id) async {
    String response = await _procedureDataProvider.fetchPatient(id);
    String decodedResponse = utf8.decode(response.runes.toList());
    return Patient.fromJson(jsonDecode(decodedResponse));
  }

  Future<BaseRulesDTO> updatePreoperative(double sib, double hba1C,
      double creatinine, int sap, int procedureId) async {
    String response = await _procedureDataProvider.updatePreoperative(
        sib, hba1C, creatinine, sap, procedureId);
    String decodedResponse = utf8.decode(response.runes.toList());
    return BaseRulesDTO.fromJson(jsonDecode(decodedResponse));
  }

  Future<BaseRulesDTO> updateBnp(double bnp, int procedureId) async {
    String response = await _procedureDataProvider.updateBnp(bnp, procedureId);
    String decodedResponse = utf8.decode(response.runes.toList());
    return BaseRulesDTO.fromJson(jsonDecode(decodedResponse));
  }

  Future<Procedure> startOperation(int procedureId) async {
    String response =
        await _procedureDataProvider.startOperation(procedureId);
    String decodedResponse = utf8.decode(response.runes.toList());
    return Procedure.fromJson(jsonDecode(decodedResponse));
  }

  Future<Procedure> endOperation(int procedureId) async {
    String response = await _procedureDataProvider.endOperation(procedureId);
    String decodedResponse = utf8.decode(response.runes.toList());
    return Procedure.fromJson(jsonDecode(decodedResponse));
  }

  Future<Procedure> dischargePatient(int procedureId) async {
    String response =
        await _procedureDataProvider.dischargePatient(procedureId);
    String decodedResponse = utf8.decode(response.runes.toList());
    return Procedure.fromJson(jsonDecode(decodedResponse));
  }

  Future<DiagnosisDTO> addSymptoms(Set<Symptom> symptoms, int id) async {
    String response = await _procedureDataProvider.addSymptoms(symptoms, id);
    String decodedResponse = utf8.decode(response.runes.toList());
    DiagnosisDTO dto = DiagnosisDTO.fromJson(jsonDecode(decodedResponse));

    String resp = await _procedureDataProvider.getAlarms(id);
    String decodedResp = utf8.decode(resp.runes.toList());
    List<dynamic> alarms = jsonDecode(decodedResp);
    dto.procedure.postOperative!.alarms.addAll(alarms.map((alarm) => Alarm.fromJson(alarm)));
    
    return dto;
  }


  Future<List<User>> getStaff() async {
    String response = await _procedureDataProvider.getStaff();
    String decodedResp = utf8.decode(response.runes.toList());
    List<dynamic> staff = jsonDecode(decodedResp);
    return staff.map((user) => User.fromJson(user)).toList();
  }

  Future<Map<String, String>> getProcedureStaff(int procedureId) async {
    String response = await _procedureDataProvider.getProcedureStaff(procedureId);
    String decodedResp = utf8.decode(response.runes.toList());
    Map<String, dynamic> staff = jsonDecode(decodedResp);
    return staff.map((key, value) => MapEntry(key, value.toString()));
  } 
}
