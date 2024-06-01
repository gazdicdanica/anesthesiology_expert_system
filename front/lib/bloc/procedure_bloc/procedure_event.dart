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

  const AddProcedure(this.patientId, this.urgency, this.risk);

  @override
  List<Object> get props => [patientId, urgency, risk];
}
