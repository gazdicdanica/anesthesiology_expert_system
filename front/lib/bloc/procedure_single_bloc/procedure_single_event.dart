part of 'procedure_single_bloc.dart';

sealed class ProcedureSingleEvent extends Equatable {
  const ProcedureSingleEvent();

  @override
  List<Object> get props => [];
}

final class FetchProcedurePatient extends ProcedureSingleEvent {
  final int procedureId;

  const FetchProcedurePatient(this.procedureId);

  @override
  List<Object> get props => [procedureId];
}

final class UpdatePreoperative extends ProcedureSingleEvent {
  final double sib;
  final double hba1C;
  final double creatinine;
  final int sap;

  final int procedureId;

  const UpdatePreoperative(this.sib, this.hba1C, this.creatinine, this.sap, this.procedureId);

  @override
  List<Object> get props => [sib, hba1C, creatinine, sap, procedureId];
}

final class UpdateBnp extends ProcedureSingleEvent {
  final double bnp;
  final int procedureId;

  const UpdateBnp(this.bnp, this.procedureId);

  @override
  List<Object> get props => [bnp, procedureId];
}

final class StartOperation extends ProcedureSingleEvent {
  final int procedureId;

  const StartOperation(this.procedureId);

  @override
  List<Object> get props => [procedureId];
}

final class EndOperation extends ProcedureSingleEvent {
  final int procedureId;

  const EndOperation(this.procedureId);

  @override
  List<Object> get props => [procedureId];
}

