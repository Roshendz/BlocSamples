import 'package:bloc_counters/logic/cubit/internet_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../constants/enums.dart';
import '../../logic/cubit/counter_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.title, required this.color})
      : super(key: key);

  final String title;
  final Color color;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext homeScreenContext) {
    return BlocListener<InternetCubit, InternetState>(
      listener: (internetCubitListenerContext, state) {
        if (state is InternetConnected &&
            state.connectionType == ConnectionType.Wifi) {
          BlocProvider.of<CounterCubit>(context).increment();
        } else if (state is InternetConnected &&
            state.connectionType == ConnectionType.Mobile) {
          BlocProvider.of<CounterCubit>(context).decrement();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: widget.color,
          title: Text(widget.title),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              const SizedBox(
                height: 10,
              ),
              BlocConsumer<CounterCubit, CounterState>(
                listener: (context, state) {
                  if (state.wasIncrented == true) {
                    var snackBar = const SnackBar(content: Text('Incremented'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  } else if (state.wasIncrented == false) {
                    var snackBar = const SnackBar(content: Text('Decremented'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                builder: (context, state) {
                  if (state.counterValue < 0) {
                    return Text(
                      'BRR, negativo ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else if (state.counterValue % 2 == 0) {
                    return Text(
                      'YAAAY ${state.counterValue}',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else if (state.counterValue == 5) {
                    return Text(
                      'HMM, numero 5',
                      style: Theme.of(context).textTheme.headline3,
                    );
                  } else {
                    return Text(
                      state.counterValue.toString(),
                      style: Theme.of(context).textTheme.headline3,
                    );
                  }
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).decrement();
                    },
                    tooltip: 'Increment',
                    backgroundColor: Colors.orange,
                    child: const Icon(Icons.remove),
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      BlocProvider.of<CounterCubit>(context).increment();
                    },
                    tooltip: 'Increment',
                    backgroundColor: Colors.green,
                    child: const Icon(Icons.add),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.redAccent,
                child: const Text(
                  'Go to Second Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(homeScreenContext).pushNamed('/second');
                },
              ),
              const SizedBox(
                height: 24,
              ),
              MaterialButton(
                color: Colors.greenAccent,
                child: const Text(
                  'Go to Third Screen',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {
                  Navigator.of(homeScreenContext).pushNamed('/third');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
