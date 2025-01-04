import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'generic_state.dart';

class GenericCubit<T> extends Cubit<GenericState<T>> {
  GenericCubit(T data) : super(GenericInitialState<T>(data));

  void onUpdateData(T data) {
    emit(GenericUpdateState<T>(data, changed: !state.changed));
  }
}
