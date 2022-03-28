import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cigarette_counter/data/firestore_api.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  final firestore = FirestoreApi();
  StreamSubscription? streamValues;
  String dateNow = DateFormat.yMMMEd().format(DateTime.now());

  StorageCubit() : super(StorageLoading()) {
    _init(dateNow);
    streamValues = firestore.stream(dateNow).listen((event) {
      final data = event.data() as Map<String, dynamic>;
      emit(StorageValue(counterValue: data['count'], date: data['date']));
    }, onError: (error) {
      return emit(StorageError());
    });
  }

  void increment() {
    if (state is StorageValue) {
      final st = state as StorageValue;
      firestore.set(dateNow, st.counterValue + 1);
    }
  }

  void decrement() {
    if (state is StorageValue) {
      final st = state as StorageValue;
      if (st.counterValue == 0) return;
      firestore.set(dateNow, st.counterValue - 1);
    }
  }

  Future<void> _init(String dateNow) async {
    final exist = await firestore.checkExisting(dateNow);
    if (!exist) {
      await firestore.set(dateNow, 0);
    }
  }
}
