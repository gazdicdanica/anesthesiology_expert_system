import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/patient/repository/patient_repository.dart';
import 'package:front/models/patient.dart';

part 'patient_event.dart';
part 'patient_state.dart';

class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final PatientRepository _patientRepository;

  PatientBloc(this._patientRepository) : super(PatientInitial()) {
    on<ResetForm>((event, emit) {
      emit(PatientInitial());
    });
    on<ValidateJmbg>(_validateJmbg);
    on<FetchPatient>(_fetchPatient);

    on<AddPatient>(_addPatient);
    on<UpdatePatient>(_updatePatient);
  }

  void _addPatient(AddPatient event, emit) async {
    emit(PatientLoading());

    await _patientRepository.addPatient(event.patient).then((patient) {
      emit(AddPatientSuccess(patient));
    }).catchError((e) {
      emit(const PatientFailure('Došlo je do greške prilikom dodavanja pacijenta'));
    });
  }

  void _updatePatient(UpdatePatient event, emit) async {
    emit(PatientLoading());

    await _patientRepository.updatePatient(event.patient).then((patient) {
      emit(UpdatePatientSuccess(patient));
    }).catchError((e) {
      emit(const PatientFailure('Došlo je do greške prilikom ažuriranja pacijenta'));
    });
  }

  void _validateJmbg(ValidateJmbg event, emit) {
    if (event.jmbg.length != 13) {
      emit(const PatientJmbgValidationFailure('JMBG mora imati 13 cifara'));
    } else {
      emit(PatientValidationSuccess());
    }
  }

  void _fetchPatient(FetchPatient event, emit) async {
    emit(PatientLoading());

    await _patientRepository.findByJmbg(event.jmbg).then((patient) {
      emit(PatientSuccess(patient));
    }).catchError((e) {
      emit(const PatientFailure(
          'Došlo je do greške prilikom preuzimanja podataka o pacijentu'));
    });
  }
}
