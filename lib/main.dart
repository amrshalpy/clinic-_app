import 'package:clinic/cubit/cubit.dart';
import 'package:clinic/cubit/state.dart';
import 'package:clinic/moduels/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider<Homecubit>(
      create: (context) => Homecubit()..createDatabase(),
      child: BlocConsumer<Homecubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            title: 'Clinic Booking',
            home: Home(),
          );
        },
      ),
    );
  }
}
