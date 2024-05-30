part of 'patient_bloc.dart';

sealed class PatientState extends Equatable {
  const PatientState();

  @override
  List<Object> get props => [];
}

final class PatientInitial extends PatientState {}

final class PatientLoading extends PatientState {}

final class PatientJmbgValidationFailure extends PatientState {
  final String error;

  const PatientJmbgValidationFailure(this.error);

  @override
  List<Object> get props => [error];
}

final class PatientValidationSuccess extends PatientState {}

final class PatientSuccess extends PatientState {
  final Patient? patient;

  const PatientSuccess(this.patient);

  @override
  List<Object> get props => [];
}

final class AddPatientSuccess extends PatientState {
  final Patient patient;

  const AddPatientSuccess(this.patient);

  @override
  List<Object> get props => [];
}

final class PatientFailure extends PatientState {
  final String error;

  const PatientFailure(this.error);

  @override
  List<Object> get props => [error];
}


