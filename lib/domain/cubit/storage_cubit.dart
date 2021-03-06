import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cigarette_counter/data/firestore_repository.dart';
import 'package:meta/meta.dart';
import 'package:intl/intl.dart';

part 'storage_state.dart';

class StorageCubit extends Cubit<StorageState> {
  final firestore = FirestoreRepository();
  StreamSubscription? currentDayItemStreamSubscription;
  String formattedDateNow = DateFormat.yMMMMd().format(DateTime.now());
  String dateNow = DateFormat('y-MM-dd').format(DateTime.now());

  StorageCubit() : super(StorageLoading()) {
    _init();
    updateStream();
    Stream.periodic(
      const Duration(minutes: 3),
    ).listen((event) {
      final now = DateFormat.yMMMMd().format(DateTime.now());
      if (now != formattedDateNow) {
        formattedDateNow = now;
        dateNow = DateFormat('y-MM-dd').format(DateTime.now());
        updateStream();
      }
      _init();
    });
  }

  void increment() {
    if (state is StorageValue) {
      final st = state as StorageValue;
      firestore.setItemCountById(formattedDateNow, st.counterValue + 1);
    }
  }

  StreamSubscription createStream() {
    return firestore.getItemById(formattedDateNow).listen((event) {
      final data = event.data() as Map<String, dynamic>;
      emit(StorageValue(counterValue: data['count'], date: data['date']));
    }, onError: (error) {
      return emit(StorageError());
    });
  }

  void updateStream() {
    currentDayItemStreamSubscription?.cancel();
    currentDayItemStreamSubscription = createStream();
  }

  void decrement() {
    if (state is StorageValue) {
      final st = state as StorageValue;
      if (st.counterValue == 0) return;
      firestore.setItemCountById(formattedDateNow, st.counterValue - 1);
    }
  }

  Future<void> _init() async {
    final exist = await firestore.checkExisting(formattedDateNow);
    if (!exist) {
      await firestore.setInitItem(formattedDateNow, 0, DateTime.parse(dateNow));
    }
  }

  @override
  Future<void> close() {
    currentDayItemStreamSubscription?.cancel();
    return super.close();
  }
}
