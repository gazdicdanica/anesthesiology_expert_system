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
      emit(const PatientFailure('Došlo je do greške prilikom preuzimanja podataka o pacijentu'));
    });
    
  }
}
