import 'dart:convert';

import 'package:front/data/procedure/data_provider/procedure_data_provider.dart';
import 'package:front/models/procedure.dart';

class ProcedureRepository {
  final ProcedureDataProvider _procedureDataProvider;

  ProcedureRepository(this._procedureDataProvider);

  Future<Procedure> addProcedure(int patientId, OperationRisk risk, ProcedureUrgency urgency) async {
    String response = await _procedureDataProvider.addProcedure(patientId, risk, urgency);
    return Procedure.fromJson(jsonDecode(response));
  }
}