import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/patient.dart';

part 'procedure_single_event.dart';
part 'procedure_single_state.dart';

class ProcedureSingleBloc extends Bloc<ProcedureSingleEvent, ProcedureSingleState> {

  final ProcedureRepository _procedureRepository;

  ProcedureSingleBloc(this._procedureRepository) : super(ProcedureSingleInitial()) {
    on<FetchProcedurePatient>(_fetchProcedurePatient);
  }

  _fetchProcedurePatient(FetchProcedurePatient event, emit) async {
    emit(ProcedureSingleLoading());
    try {
      final patient = await _procedureRepository.fetchPatient(event.procedureId);
      emit(ProcedurePatientSuccess(patient));
    } catch (e) {
      emit(const ProcedureSingleError("Greška prilikom dobavljanja"));
    }
  }
}
