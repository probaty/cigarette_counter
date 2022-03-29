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
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total cigarettes',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                total.toString(),
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ]),
                      )
                      // child: Text('Total cigarettes: ${total.toString()}'),
                      ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: SizedBox.expand(
                  child: Card(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Average cigarettes per day',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                              Text(
                                (total / dataList.length).ceil().toString(),
                                style: Theme.of(context).textTheme.headline6,
                              )
                            ]),
                      )
                      // child: Text('Total cigarettes: ${total.toString()}'),
                      ),
                  // child: Card(
                  //   child: Text(
                  //       'Total cigarettes: ${(total / dataList.length).ceil().toString()}'),
                  // ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                flex: 10,
                child: ListView.separated(
                  itemCount: dataList.length,
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemBuilder: (context, index) {
                    Map<String, dynamic> data =
                        dataList[index].data()! as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['date']),
                      trailing: Text(data['count'].toString()),
                      // subtitle: Text(data['count'].toString()),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
