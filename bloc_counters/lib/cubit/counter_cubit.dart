import 'package:flutter_bloc/flutter_bloc.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterState(counterValue: 0, wasIncrented: true));

  void increment() => emit(
      CounterState(counterValue: state.counterValue + 1, wasIncrented: true));

  void decrement() => emit(
      CounterState(counterValue: state.counterValue - 1, wasIncrented: true));
}
