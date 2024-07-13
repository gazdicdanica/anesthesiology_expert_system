part of 'staff_bloc.dart';

sealed class StaffState extends Equatable {
  const StaffState();
  
  @override
  List<Object> get props => [];
}

final class StaffInitial extends StaffState {}

final class StaffLoading extends StaffState {}

final class StaffSuccess extends StaffState {
  final List<User> staff;

  const StaffSuccess(this.staff);

  @override
  List<Object> get props => [staff];
}

final class StaffProcedureSuccess extends StaffState {
  final Map<String, String> staff;

  const StaffProcedureSuccess(this.staff);

  @override
  List<Object> get props => [staff];
}


final class StaffError extends StaffState {
  final String message;

  const StaffError(this.message);

  @override
  List<Object> get props => [message];
}