part of 'procedure_single_bloc.dart';

sealed class ProcedureSingleState extends Equatable {
  const ProcedureSingleState();
  
  @override
  List<Object> get props => [];
}

final class ProcedureSingleInitial extends ProcedureSingleState {}

final class ProcedureSingleLoading extends ProcedureSingleState {}

final class ProcedurePatientSuccess extends ProcedureSingleState {
  final Patient patient;

  const ProcedurePatientSuccess(this.patient);

  @override
  List<Object> get props => [patient];
}

final class ProcedureSingleError extends ProcedureSingleState {
  final String message;

  const ProcedureSingleError(this.message);

  @override
  List<Object> get props => [message];
}
