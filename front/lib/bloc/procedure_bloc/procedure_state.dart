part of 'procedure_bloc.dart';

sealed class ProcedureState {
  const ProcedureState();
}

final class ProcedureInitial extends ProcedureState {}

final class ProcedureFormValuesState extends ProcedureState {
  final ProcedureUrgency? urgency;
  final OperationRisk? risk;
  final String? urgencyError;
  final String? riskError;

  const ProcedureFormValuesState({
    this.urgency,
    this.risk,
    this.urgencyError,
    this.riskError,
  });

  ProcedureState copyWith({
    ProcedureUrgency? urgency,
    OperationRisk? risk,
    bool clearUrgencyError = false,
    String? urgencyError,
    bool clearRiskError = false,
    String? riskError,
  }) {
    return ProcedureFormValuesState(
      urgency: urgency ?? this.urgency,
      risk: risk ?? this.risk,
      urgencyError:
          clearUrgencyError ? null : urgencyError ?? this.urgencyError,
      riskError: clearRiskError ? null : riskError ?? this.riskError,
    );
  }
}

final class ProcedureSuccess extends ProcedureState {
  final Procedure procedure;

  const ProcedureSuccess(this.procedure);
}

final class ProceduresSuccess extends ProcedureState {
  final List<Procedure> procedures;

  const ProceduresSuccess(this.procedures);
}

final class ProcedureError extends ProcedureState {
  final String message;

  const ProcedureError(this.message);
}

final class ProcedureLoading extends ProcedureState {}
