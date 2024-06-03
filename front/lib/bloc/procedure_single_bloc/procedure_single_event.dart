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
  List<Object> get props => [sib, hba1C, creatinine, sap];
}
