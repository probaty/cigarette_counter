import 'package:cigarette_counter/data/firestore_repository.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  final firestore = FirestoreRepository();
  Stream<QuerySnapshot>? allItemsStream;

  @override
  void initState() {
    allItemsStream = firestore.getAllItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: allItemsStream,
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(
              child: Text(
            'Something went wrong',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.red),
          ));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final dataList = snapshot.data!.docs;
        int total = 0;
        for (var element in dataList) {
          Map<String, dynamic> data = element.data()! as Map<String, dynamic>;
          total += data['count'] as int;
        }
        return Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            children: [
              Expanded(
                child: SizedBox.expand(
                  child: Card(
                    child: Text('Total cigarettes: ${total.toString()}'),
                  ),
                ),
              ),
              Expanded(
                child: SizedBox.expand(
                  child: Card(
                    child: Text(
                        'Total cigarettes: ${(total / dataList.length).ceil().toString()}'),
                  ),
                ),
              ),
              Expanded(
                flex: 10,
                child: ListView(
                  children: dataList.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['date']),
                      subtitle: Text(data['count'].toString()),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
