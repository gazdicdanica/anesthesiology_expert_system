import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:front/data/procedure/repository/procedure_repository.dart';
import 'package:front/models/user.dart';

part 'staff_event.dart';
part 'staff_state.dart';

class StaffBloc extends Bloc<StaffEvent, StaffState> {

  final ProcedureRepository _procedureRepository;

  StaffBloc(this._procedureRepository) : super(StaffInitial()) {

    on<FetchStaff>(_fetchStaff);
    on<FetchProcedureStaff>(_fetchProcedureStaff);
  }


  _fetchStaff(FetchStaff event, emit) async {
    emit(StaffLoading());

    try {
      final staff = await _procedureRepository.getStaff();
      emit(StaffSuccess(staff));
    } catch (e) {
      emit(const StaffError("Greška prilikom dobavljanja dostupnog osoblja"));
    }
  }


  _fetchProcedureStaff(FetchProcedureStaff event, emit) async {
    emit(StaffLoading());

    try {
      final staff = await _procedureRepository.getProcedureStaff(event.procedureId);
      emit(StaffProcedureSuccess(staff));
    } catch (e) {
      emit(const StaffError("Greška prilikom dobavljanja osoblja"));
    }
  }
}
