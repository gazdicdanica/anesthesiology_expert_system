// import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/procedure.dart';

part 'procedure_event.dart';
part 'procedure_state.dart';

class ProcedureBloc extends Bloc<ProcedureEvent, ProcedureState> {
  final ProcedureRepository _procedureRepository;

  ProcedureBloc(this._procedureRepository) : super(ProcedureInitial()) {
    on<ProcedureEvent>(_handle);
  }

  _addProcedure(AddProcedure event, emit) async {
    emit(ProcedureLoading());
    final patientId = event.patientId;
    final urgency = event.urgency;
    final risk = event.risk;
    final staffId = event.staffId;

    try {
      final procedure = await _procedureRepository.addProcedure(
          patientId, risk, urgency, event.name, staffId);
      emit(ProcedureSuccess(procedure));
    } catch (e) {
      emit(const ProcedureError(
          "Greška prilikom dodavanja. Molimo pokušajte ponovo."));
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

  _handle(event, emit) async{
    if (event is AddProcedure) {
      await _addProcedure(event, emit);
    } else if (event is FetchProcedures) {
      await _fetchProcedures(event, emit);
    } else if (event is OpenProcedure) {
      _openProcedure(event, emit);
    } else if (event is CloseProcedure) {
      _closeProcedure(event, emit);
    }
  }
}
