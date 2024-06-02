import 'dart:convert';

import 'package:front/data/procedure/data_provider/procedure_data_provider.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';

class ProcedureRepository {
  final ProcedureDataProvider _procedureDataProvider;

  ProcedureRepository(this._procedureDataProvider);

  Future<Procedure> addProcedure(int patientId, OperationRisk risk,
      ProcedureUrgency urgency, String name) async {
    String response = await _procedureDataProvider.addProcedure(
        patientId, risk, urgency, name);
    return Procedure.fromJson(jsonDecode(response));
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
}
