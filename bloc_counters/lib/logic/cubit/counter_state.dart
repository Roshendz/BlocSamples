// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int counterValue;
  final bool wasIncrented;

  CounterState({
    required this.counterValue,
    required this.wasIncrented,
  });

  @override
  List<Object> get props => [counterValue, wasIncrented];
}