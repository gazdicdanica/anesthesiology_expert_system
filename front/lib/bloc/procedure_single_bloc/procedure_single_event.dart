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
