
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';

part 'procedure_event.dart';
part 'procedure_state.dart';

class ProcedureBloc extends Bloc<ProcedureEvent, ProcedureState> {

  final ProcedureRepository _procedureRepository;

  ProcedureBloc(this._procedureRepository) : super(ProcedureInitial()) {
    on<AddProcedure>(_addProcedure);
    on<FetchProcedures>(_fetchProcedures);
    on<OpenProcedure>(_openProcedure);
    on<CloseProcedure>(_closeProcedure);
  }

  _addProcedure(AddProcedure event, emit) async {
    emit(ProcedureLoading());
    final patientId = event.patientId;
    final urgency = event.urgency;
    final risk = event.risk;

    try {
      final procedure = await _procedureRepository.addProcedure(patientId, risk, urgency, event.name);
      emit(ProcedureSuccess(procedure));
    } catch (e) {
      emit(const ProcedureError("Greška prilikom dodavanja. Molimo pokušajte ponovo."));
    }
  }

    _fetchProcedures(FetchProcedures event, emit) async {
    emit(ProcedureLoading());
    try {
      final procedures = await _procedureRepository.fetchProcedures();
      emit(ProceduresSuccess(procedures));
    } catch (e) {
      emit(const ProcedureError("Greška prilikom dobavljanja"));
    }
  }

  _openProcedure(OpenProcedure event, emit) {
    emit(ProcedureSuccess(event.procedure));
  }

  _closeProcedure(CloseProcedure event, emit) {
    emit(ProcedureInitial());
  }
}
