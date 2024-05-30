import 'dart:convert';

import 'package:front/data/patient/data_provider/patient_data_provider.dart';
import 'package:front/models/patient.dart';

class PatientRepository {
  final PatientDataProvider _patientDataProvider;

  PatientRepository(this._patientDataProvider);

  Future<Patient?> findByJmbg(String jmbg) async {

    String? response = await _patientDataProvider.findByJmbg(jmbg);
    if(response == null) {
      return Future(() => null);
    }
    
    String decodedResponse = utf8.decode(response.runes.toList());
    return Patient.fromJson(jsonDecode(decodedResponse));
  }

  Future<Patient> addPatient(PatientDTO patient) async {
    String? response = await _patientDataProvider.addPatient(patient);
    return Patient.fromJson(jsonDecode(response!));
  }

  Future<Patient> updatePatient(PatientDTO patient) async {
    String? response = await _patientDataProvider.updatePatient(patient);
    return Patient.fromJson(jsonDecode(response!));
  }
}