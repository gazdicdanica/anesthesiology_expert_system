part of 'procedure_bloc.dart';

sealed class ProcedureEvent extends Equatable {
  const ProcedureEvent();

  @override
  List<Object> get props => [];
}

// final class ValidateProcedureForm extends ProcedureEvent {
//   final ProcedureUrgency? urgency;
//   final OperationRisk? risk;

//   const ValidateProcedureForm(this.urgency, this.risk);

//   @override
//   List<Object> get props => [];
// }

final class AddProcedure extends ProcedureEvent {
  final int patientId;
  final ProcedureUrgency urgency;
  final OperationRisk risk;
  final String name;
  final int staffId;

  const AddProcedure(this.patientId, this.urgency, this.risk, this.name, this.staffId);

  @override
  List<Object> get props => [patientId, urgency, risk, staffId];
}

final class FetchProcedures extends ProcedureEvent {
  const FetchProcedures();

  @override
  List<Object> get props => [];
}

final class OpenProcedure extends ProcedureEvent {
  final Procedure procedure;

  const OpenProcedure(this.procedure);

  @override
  List<Object> get props => [procedure];
}

final class CloseProcedure extends ProcedureEvent {
  const CloseProcedure();

  @override
  List<Object> get props => [];
}
