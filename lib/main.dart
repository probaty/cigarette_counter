import 'package:cigarette_counter/data/firestore_api.dart';
import 'package:cigarette_counter/domain/cubit/storage_cubit.dart';
import 'package:cigarette_counter/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final api = FirestoreApi();
  Stream<DocumentSnapshot>? stream;

  @override
  void initState() {
    stream = api.stream('2020-05-02');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<StorageCubit>(
        create: (context) => StorageCubit(),
        child: const MainScreen(),
      ),
    );
  }
}
// Scaffold(
//           body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           StreamBuilder<DocumentSnapshot>(
//             builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//               if (snapshot.hasError) {
//                 return const Text('error');
//               }

//               if (snapshot.connectionState == ConnectionState.waiting) {
//                 return const Text('loading');
//               }

//               final data = snapshot.data!.data() as Map<String, dynamic>;
//               return Column(
//                 children: [
//                   ElevatedButton(
//                     onPressed: () {
//                       api.set(data['date'], data['count'] + 1);
//                     },
//                     child: const Text('add'),
//                   ),
//                   Text("${data['date']}   ${data['count'].toString()}"),
//                   ElevatedButton(
//                     onPressed: () {
//                       api.set(data['date'], data['count'] - 1);
//                     },
//                     child: const Text('dis'),
//                   ),
//                 ],
//               );
//             },
//             stream: stream,
//           ),
//         ],
//       )),
