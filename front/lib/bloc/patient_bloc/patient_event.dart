part of 'patient_bloc.dart';

sealed class PatientEvent extends Equatable {
  const PatientEvent();

  @override
  List<Object> get props => [];
}

final class ResetForm extends PatientEvent {}

final class ValidateJmbg extends PatientEvent {
  final String jmbg;

  const ValidateJmbg(this.jmbg);

  @override
  List<Object> get props => [jmbg];
}

final class FetchPatient extends PatientEvent {
  final String jmbg;

  const FetchPatient(this.jmbg);

  @override
  List<Object> get props => [jmbg];
}
