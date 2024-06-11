part of 'patient_form_bloc.dart';

sealed class PatientFormEvent extends Equatable {
  const PatientFormEvent();

  @override
  List<Object> get props => [];
}

final class PatientResetForm extends PatientFormEvent {}

final class ToggleCheckbox extends PatientFormEvent {
  final String field;
  final bool value;

  const ToggleCheckbox({required this.field, required this.value});

  @override
  List<Object> get props => [field, value];
}

final class TextFieldChanged extends PatientFormEvent {
  final String field;
  final String value;

  const TextFieldChanged({required this.field, required this.value});

  @override
  List<Object> get props => [field, value];
}