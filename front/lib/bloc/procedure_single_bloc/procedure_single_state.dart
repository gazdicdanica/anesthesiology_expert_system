part of 'procedure_single_bloc.dart';

sealed class ProcedureSingleState extends Equatable {
  const ProcedureSingleState();
  
  @override
  List<Object> get props => [];
}

final class ProcedureSingleInitial extends ProcedureSingleState {}

final class ProcedureSingleLoading extends ProcedureSingleState {}

final class UpdateAndSuccess extends ProcedureSingleState {
  final Patient patient;
  final Procedure? procedure;

  const UpdateAndSuccess(this.patient, this.procedure);

  @override
  List<Object> get props => [patient, procedure ?? ""];
}

final class ProcedurePatientSuccess extends UpdateAndSuccess {
  

  const ProcedurePatientSuccess(super.patient, super.procedure);

  @override
  List<Object> get props => [super.patient, super.procedure ?? ""];

}

final class ProcedureUpdateLoading extends UpdateAndSuccess {

  const ProcedureUpdateLoading(super.patient, super.procedure);

  @override
  List<Object> get props => [super.patient, super.procedure ?? ""];
}

final class ProcedureDiagnosisLoading extends UpdateAndSuccess {

  const ProcedureDiagnosisLoading(super.patient, super.procedure);

  @override
  List<Object> get props => [super.patient, super.procedure ?? ""];
}

final class ProcedureSingleError extends ProcedureSingleState {
  final String message;

  const ProcedureSingleError(this.message);

  @override
  List<Object> get props => [message];
}

