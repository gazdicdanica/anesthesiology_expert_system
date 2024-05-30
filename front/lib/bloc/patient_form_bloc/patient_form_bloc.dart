import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'patient_form_event.dart';
part 'patient_form_state.dart';

class PatientFormBloc extends Bloc<PatientFormEvent, PatientFormState> {
  PatientFormBloc() : super(const PatientFormValuesState()) {
    on<PatientResetForm>(_resetForm);
    on<ToggleCheckbox>(_toggleCheckbox);
    on<TextFieldChanged>(_textFieldChanged);
  }

  void _resetForm(PatientResetForm event, emit) {
    emit(const PatientFormValuesState());
  }

  void _toggleCheckbox(ToggleCheckbox event, emit) {
    final currentState = state as PatientFormValuesState;

    switch (event.field) {
      case 'hasDiabetes':
        emit(currentState.copyWith(hasDiabetes: event.value));
        break;
      case 'hadHeartAttack':
        emit(currentState.copyWith(hadHeartAttack: event.value));
        break;
      case 'hasHeartFailure':
        emit(currentState.copyWith(hasHeartFailure: event.value));
        break;
      case 'hasHypertension':
        emit(currentState.copyWith(hasHypertension: event.value));
        break;
      case 'controlledHypertension':
        emit(currentState.copyWith(controlledHypertension: event.value));
        break;
      case 'hadStroke':
        emit(currentState.copyWith(hadStroke: event.value));
        break;
      case 'hasRenalFailure':
        emit(currentState.copyWith(hasRenalFailure: event.value));
        break;
      // case 'hasCVSFamilyHistory':
      //   emit(currentState.copyWith(hasCVSFamilyHistory: event.value));
      //   break;
      case 'addictions':
        emit(currentState.copyWith(addictions: event.value));
        break;
      case 'smokerOrAlcoholic':
        emit(currentState.copyWith(smokerOrAlcoholic: event.value));
        break;
      case 'pregnant':
        emit(currentState.copyWith(pregnant: event.value));
        break;
    }
  }

  void _textFieldChanged(TextFieldChanged event, emit) {
    final currentState = state as PatientFormValuesState;

    switch (event.field) {
      case 'fullname':
        emit(currentState.copyWith(
            fullName: event.value,
            clearFullNameError: event.value.isNotEmpty,
            fullNameError:
                event.value.isEmpty ? 'Ime i prezime su obavezni' : null));
        break;
      case 'age':
        String? ageError;
        if (event.value.isEmpty) {
          ageError = 'Godine su obavezne';
        } else if (int.parse(event.value) < 18 ||
            int.parse(event.value) > 150) {
          ageError = 'Godine moraju biti između 18 i 150';
        }

        emit(currentState.copyWith(
            age: event.value,
            ageError: ageError,
            clearAgeError: ageError == null));
        break;
      case 'height':
        String? heightError;
        if (event.value.isEmpty) {
          heightError = 'Visina je obavezna';
        } else if (int.parse(event.value) < 100 ||
            int.parse(event.value) > 300) {
          heightError = 'Visina mora biti između 100 i 300cm';
        }
        emit(currentState.copyWith(
            height: event.value,
            heightError: heightError,
            clearHeightError: heightError == null));
        break;
      case 'weight':
        String? weightError;
        if (event.value.isEmpty) {
          weightError = 'Težina je obavezna';
        } else if (int.parse(event.value) < 30 ||
            int.parse(event.value) > 500) {
          weightError = 'Težina mora biti između 30 i 500kg';
        }
        emit(currentState.copyWith(
            weight: event.value,
            weightError: weightError,
            clearWeightError: weightError == null));
        break;
    }
  }
}
