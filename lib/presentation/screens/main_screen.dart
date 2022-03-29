import 'package:cigarette_counter/domain/cubit/storage_cubit.dart';
import 'package:cigarette_counter/presentation/widgets/counter_widget.dart';
import 'package:cigarette_counter/presentation/widgets/history_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cigarette counter'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Overview',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text(
                  'History',
                  style: TextStyle(fontSize: 16),
                ),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: BlocBuilder<StorageCubit, StorageState>(
                builder: (context, state) {
                  if (state is StorageLoading) {
                    return const CircularProgressIndicator();
                  }
                  if (state is StorageValue) {
                    return CounterWidget(
                        count: state.counterValue, date: state.date);
                  }
                  return const Center(
                    child: Text('error'),
                  );
                },
              ),
            ),
            const Center(
              child: HistoryWidget(),
            )
          ],
        ),
      ),
    );
  }
}
