import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';

part 'procedure_single_event.dart';
part 'procedure_single_state.dart';

class ProcedureSingleBloc extends Bloc<ProcedureSingleEvent, ProcedureSingleState> {

  final ProcedureRepository _procedureRepository;

  ProcedureSingleBloc(this._procedureRepository) : super(ProcedureSingleInitial()) {
    on<FetchProcedurePatient>(_fetchProcedurePatient);
    on<UpdatePreoperative>(_updatePreoperative);
  }

  _fetchProcedurePatient(FetchProcedurePatient event, emit) async {
    emit(ProcedureSingleLoading());
    try {
      final patient = await _procedureRepository.fetchPatient(event.procedureId);
      emit(ProcedurePatientSuccess(patient, null));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom dobavljanja"));
    }
  }

  _updatePreoperative(UpdatePreoperative event, emit) async {
    final currentState = state as ProcedurePatientSuccess;
    emit(ProcedureUpdateLoading(currentState.patient, currentState.procedure));
    try {
      final dto = await _procedureRepository.updatePreoperative(event.sib, event.hba1C, event.creatinine, event.sap, event.procedureId);
      emit(ProcedurePatientSuccess(dto.patient, dto.procedure));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom ažuriranja"));
    }
  }
}
