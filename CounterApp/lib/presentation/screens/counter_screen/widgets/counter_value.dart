import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../../logic/cubit/counter_cubit.dart';

class CounterValue extends StatefulWidget {
  const CounterValue({
    Key? key,
  }) : super(key: key);

  @override
  CounterValueState createState() => CounterValueState();
}

class CounterValueState extends State<CounterValue> {
  late AnimationController _animationController;

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _animationController.forward(from: 0.0);
    return ZoomIn(
      duration: const Duration(milliseconds: 400),
      manualTrigger: true,
      controller: (controller) => _animationController = controller,
      child: Text(
        context
            .select(
                (CounterCubit counterCubit) => counterCubit.state.counterValue)
            .toString(),
        style: Theme.of(context).textTheme.headline1!.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 80.0.sp,
            ),
      ),
    );
  }
}
