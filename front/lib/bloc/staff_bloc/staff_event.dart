part of 'staff_bloc.dart';

sealed class StaffEvent extends Equatable {
  const StaffEvent();

  @override
  List<Object> get props => [];
}


class FetchStaff extends StaffEvent {
  const FetchStaff();

  @override
  List<Object> get props => [];
}

class FetchProcedureStaff extends StaffEvent {
  final int procedureId;

  const FetchProcedureStaff(this.procedureId);

  @override
  List<Object> get props => [procedureId];
}
