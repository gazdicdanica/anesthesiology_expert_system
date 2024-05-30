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
    
    return Patient.fromJson(jsonDecode(response));
  }

  Future<Patient> addPatient(AddPatientDTO patient) async {
    String? response = await _patientDataProvider.addPatient(patient);
    return Patient.fromJson(jsonDecode(response!));
  }
}