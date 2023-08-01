import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_sample/presentation/screens/second_screen.dart';
import 'package:flutter_bloc_sample/presentation/screens/third_screen.dart';
import '/logic/cubit/counter_cubit.dart';

class App extends StatelessWidget {
  App({super.key});

  final CounterCubit _counterCubit = CounterCubit();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "/": (context) => BlocProvider(
            create: (context) => _counterCubit, child: const Sample()),
        "/second": (context) => BlocProvider(
            create: (context) => _counterCubit, child: const SecondScreen()),
        "/third": (context) => BlocProvider(
            create: (context) => _counterCubit, child: const ThirdScreen()),
      },
    );
  }
}

class Sample extends StatelessWidget {
  const Sample({Key? key}) : super(key: key);

  void showNotif(String text) {
    SnackBar(content: Text(text));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          BlocConsumer<CounterCubit, CounterState>(
            listener: (context, state) {
              state.isIncremented
                  ? ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("increment"),
                      duration: Duration(milliseconds: 100),
                    ))
                  : ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("decrement"),
                      duration: Duration(milliseconds: 100),
                    ));
            },
            builder: (context, state) {
              return Text(state.counterValue.toString());
            },
          ),
          FloatingActionButton(
            heroTag: "btn6",
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            child: const Text("Add"),
          ),
          FloatingActionButton(
            heroTag: "btn5",
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            child: const Text("Minus"),
          ),
          FloatingActionButton(
              heroTag: "btn4",
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (ctx) => BlocProvider.value(
                          value: BlocProvider.of<CounterCubit>(context),
                          child: const SecondScreen(),
                        )));
              })
        ],
      ),
    );
  }
}
