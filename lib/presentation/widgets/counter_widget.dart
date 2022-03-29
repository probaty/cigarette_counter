import 'package:cigarette_counter/domain/cubit/storage_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterWidget extends StatelessWidget {
  final int count;
  final String date;
  const CounterWidget({Key? key, required this.count, required this.date})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          date,
          style: Theme.of(context).textTheme.headline3,
        ),
        RawMaterialButton(
          shape: CircleBorder(
            side: BorderSide(
                color: Theme.of(context).primaryColor.withAlpha(100), width: 4),
          ),
          padding: const EdgeInsets.all(50),
          onPressed: () {
            BlocProvider.of<StorageCubit>(context).increment();
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 25.0,
                  left: 40.0,
                  right: 40.0,
                  top: 50.0,
                ),
                child: Text(
                  count.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      ?.copyWith(fontSize: 80),
                ),
              ),
              const Icon(
                Icons.add,
                color: Colors.black54,
                size: 40,
              )
            ],
          ),
        ),
        RawMaterialButton(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20),
            onPressed: () {
              BlocProvider.of<StorageCubit>(context).decrement();
            },
            child: const Icon(
              Icons.remove,
              color: Colors.black54,
              size: 40,
            ))
      ],
    );
  }
}
