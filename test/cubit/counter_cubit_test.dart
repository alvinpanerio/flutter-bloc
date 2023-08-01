import 'package:flutter_bloc_sample/logic/cubit/counter_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("CounterCubit", () {
    CounterCubit counterCubit;

    setUp(() {
      counterCubit = CounterCubit();
    });

    tearDown(() {
      CounterCubit().close();
    });

    test(
      "text",
      () {
        expect(
          CounterCubit().state,
          CounterState(0, false),
        );
      },
    );
  });
}
