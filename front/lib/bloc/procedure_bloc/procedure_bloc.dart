
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/procedure.dart';

part 'procedure_event.dart';
part 'procedure_state.dart';

class ProcedureBloc extends Bloc<ProcedureEvent, ProcedureState> {

  final ProcedureRepository _procedureRepository;

  ProcedureBloc(this._procedureRepository) : super(const ProcedureFormValuesState()) {
    // on<ValidateProcedureForm>(_validateForm);
    on<AddProcedure>(_addProcedure);
  }

  // _validateForm(ValidateProcedureForm event, emit) {
  //   final urgency = event.urgency;
  //   final risk = event.risk;

  //   final state = this.state as ProcedureFormValuesState;

    
  // }

  _addProcedure(AddProcedure event, emit) async {
    emit(ProcedureLoading());
    final patientId = event.patientId;
    final urgency = event.urgency;
    final risk = event.risk;

    try {
      final procedure = await _procedureRepository.addProcedure(patientId, risk, urgency);
      emit(ProcedureSuccess(procedure));
    } catch (e) {
      emit(const ProcedureError("Greška prilikom dodavanja operacije. Molimo pokušajte ponovo."));
    }
  }
}
