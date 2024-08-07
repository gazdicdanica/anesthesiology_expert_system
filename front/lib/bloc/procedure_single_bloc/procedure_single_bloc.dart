import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/alarm.dart';
import 'package:front/models/patient.dart';
import 'package:front/models/procedure.dart';

part 'procedure_single_event.dart';
part 'procedure_single_state.dart';

class ProcedureSingleBloc
    extends Bloc<ProcedureSingleEvent, ProcedureSingleState> {
  final ProcedureRepository _procedureRepository;

  ProcedureSingleBloc(this._procedureRepository)
      : super(ProcedureSingleInitial()) {
    on<ProcedureSingleEvent>(_handle, transformer: restartable());
  }

  _fetchProcedurePatient(FetchProcedurePatient event, emit) async {
    emit(ProcedureSingleLoading());
    try {
      final patient =
          await _procedureRepository.fetchPatient(event.procedureId);
      emit(ProcedurePatientSuccess(patient, null));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom dobavljanja"));
    }
  }

  _updatePreoperative(UpdatePreoperative event, emit) async {
    final currentState = state as ProcedurePatientSuccess;
    emit(ProcedureUpdateLoading(currentState.patient, currentState.procedure));
    try {
      final dto = await _procedureRepository.updatePreoperative(event.sib,
          event.hba1C, event.creatinine, event.sap, event.procedureId);
      emit(ProcedurePatientSuccess(dto.patient, dto.procedure));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom ažuriranja"));
    }
  }

  _updateBnp(UpdateBnp event, emit) async {
    final currentState = state as ProcedurePatientSuccess;
    emit(ProcedureUpdateLoading(currentState.patient, currentState.procedure));
    try {
      final dto =
          await _procedureRepository.updateBnp(event.bnp, event.procedureId);
      emit(ProcedurePatientSuccess(dto.patient, dto.procedure));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom ažuriranja"));
    }
  }

  _startOperation(StartOperation event, emit) async {
    final currentState = state as ProcedurePatientSuccess;
    emit(ProcedureUpdateLoading(currentState.patient, currentState.procedure));
    try {
      final procedure = await _procedureRepository.startOperation(event.procedureId);
      print(procedure);
      emit(ProcedurePatientSuccess(currentState.patient, procedure));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom pokretanja operacije"));
    }
  }

  _endOperation(EndOperation event, emit) async {
    final currentState = state as ProcedurePatientSuccess;
    emit(ProcedureUpdateLoading(currentState.patient, currentState.procedure));
    try {
      final procedure = await _procedureRepository.endOperation(event.procedureId);

      emit(ProcedurePatientSuccess(currentState.patient, procedure));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom završetka operacije"));
    }
  }

  _dischargePatient(DischargePatient event, emit) async {
    final currentState = state as ProcedurePatientSuccess;
    emit(ProcedureUpdateLoading(currentState.patient, currentState.procedure));
    try {
      final procedure = await _procedureRepository.dischargePatient(event.procedureId);
      emit(ProcedurePatientSuccess(currentState.patient, procedure));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom otpusta pacijenta"));
    }
  }

  _updateSymptoms(UpdateSymptoms event, emit) async {
    final currentState = state as ProcedurePatientSuccess;
    emit(ProcedureDiagnosisLoading(currentState.patient, currentState.procedure));
    try {
      final dto = await _procedureRepository.addSymptoms(event.symptoms, event.procedureId);
      emit(ProcedurePatientSuccess(dto.patient, dto.procedure));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom dodavanja simptoma"));
    }
  }

  _handle(event, emit) async {
    if (event is FetchProcedurePatient) {
      await _fetchProcedurePatient(event, emit);
    } else if (event is UpdatePreoperative) {
      await _updatePreoperative(event, emit);
    } else if (event is UpdateBnp) {
      await _updateBnp(event, emit);
    }else if(event is StartOperation){
      await _startOperation(event, emit);
    }else if(event is EndOperation){
      await _endOperation(event, emit);
    }else if(event is DischargePatient){
      await _dischargePatient(event, emit);
    }else if(event is UpdateSymptoms){
      await _updateSymptoms(event, emit);
    }
  }
}
