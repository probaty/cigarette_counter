import 'package:cigarette_counter/domain/cubit/storage_cubit.dart';
import 'package:cigarette_counter/presentation/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
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
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blue,
        androidOverscrollIndicator: AndroidOverscrollIndicator.stretch,
      ),
      home: BlocProvider<StorageCubit>(
        create: (context) => StorageCubit(),
        child: const MainScreen(),
      ),
    );
  }
}
