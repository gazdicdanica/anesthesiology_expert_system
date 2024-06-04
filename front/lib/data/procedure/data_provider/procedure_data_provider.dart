import 'dart:convert';

import 'package:front/constant.dart';
import 'package:front/custom_exception.dart';
import 'package:front/data/shared_pref/repository/shared_pref_repository.dart';
import 'package:front/models/procedure.dart';
import 'package:http/http.dart' as http;

class ProcedureDataProvider {
  final SharedPrefRepository _sharedPrefRepository;

  ProcedureDataProvider(this._sharedPrefRepository);

  Future<String> addProcedure(
      int patientId, OperationRisk risk, ProcedureUrgency urgency, String name) async {
    final token = await _sharedPrefRepository.getToken();

    final res = await http.post(Uri.parse("${path}procedure"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          'patientId': patientId,
          'risk': risk.toString().split('.').last,
          'urgency': urgency.toString().split('.').last,
          'name': name
        }));

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.body);
      throw CustomException('Greška prilikom dodavanja');
    }
  }

  Future<String> fetchProcedures() async {
    final token = await _sharedPrefRepository.getToken();

    final res = await http.get(Uri.parse("${path}procedure/current"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.body);
      throw CustomException('Greška prilikom dobavljanja');
    }
  }


  Future<String> fetchPatient(int id) async {
    final token = await _sharedPrefRepository.getToken();

    final res = await http.get(Uri.parse("${path}procedure/$id/patient"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        });

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.body);
      throw CustomException('Greška prilikom dobavljanja pacijenta');
    }
  }


  Future<String> updatePreoperative(double sib, double hba1c, double creatinine, int sap, int id) async{
    final token = await _sharedPrefRepository.getToken();

    final res = await http.put(Uri.parse("${path}procedure/$id/preoperative"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          'sib': sib,
          'hba1C': hba1c,
          'creatinine': creatinine,
          'sap': sap
        }));

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.body);
      throw CustomException('Greška prilikom ažuriranja preoperativnih podataka');
    }
  }

  Future<String> updateBnp(double bnp, int id) async{
    final token = await _sharedPrefRepository.getToken();

    final res = await http.put(Uri.parse("${path}procedure/$id/bnp?bnp=$bnp"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token'
        },);

    if (res.statusCode == 200) {
      return res.body;
    } else {
      print(res.body);
      throw CustomException('Greška prilikom ažuriranja vrednosti srčanih markera');
    }
  }
}
