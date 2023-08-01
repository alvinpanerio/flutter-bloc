import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/logic/cubit/counter_cubit.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

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
          const Text("second"),
          FloatingActionButton(
            heroTag: "btn1",
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).increment();
            },
            child: const Text("Add"),
          ),
          FloatingActionButton(
            heroTag: "btn2",
            onPressed: () {
              BlocProvider.of<CounterCubit>(context).decrement();
            },
            child: const Text("Minus"),
          ),
          FloatingActionButton(
              heroTag: "btn3",
              onPressed: () {
                //PASSING BLOC TO NEXT SCREEN
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
