import 'package:bloc_counters/logic/cubit/counter_cubit.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('CounterCubit', () {
    CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    /*  tearDown(() {
      counterCubit.close();
    });

    test('initial state of CounterCubit is CounterState(counterValue:0)', () {
      expect(counterCubit.state, CounterState(counterValue: 0, wasIncrented: true));
    });

    blocTest(
        'the CounterCubit should emit a CounterState(counterValue:1, wasIncremented:true) when the increment function is called',
        build: () => counterCubit,
        act: (logic.cubit) => logic.cubit.increment(),
        expect: [CounterState(counterValue: 1, wasIncrented: true)]);

    blocTest(
        'the CounterCubit should emit a CounterState(counterValue:-1, wasIncremented:false) when the decrement function is called',
        build: () => counterCubit,
        act: (logic.cubit) => logic.cubit.decrement(),
        expect: [CounterState(counterValue: -1, wasIncrented: false)]); */
  });
}
