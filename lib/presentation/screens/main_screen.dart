import 'package:cigarette_counter/domain/cubit/storage_cubit.dart';
import 'package:cigarette_counter/presentation/widgets/counter_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<StorageCubit, StorageState>(
          builder: (context, state) {
            if (state is StorageLoading) {
              return const CircularProgressIndicator.adaptive();
            }
            if (state is StorageValue) {
              return CounterWidget(count: state.counterValue, date: state.date);
            }
            return const Center(
              child: Text('error'),
            );
          },
        ),
      ),
    );
  }
}
