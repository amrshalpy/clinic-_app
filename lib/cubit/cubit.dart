import 'package:bloc/bloc.dart';
import 'package:clinic/cubit/state.dart';
import 'package:clinic/moduels/archive/archive.dart';
import 'package:clinic/moduels/booking/booking.dart';
import 'package:clinic/moduels/done/done.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class Homecubit extends Cubit<HomeState> {
  Homecubit() : super(HomeInitialState());
  static Homecubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void changeCurrentIndex(index) {
    currentIndex = index;
    emit(ChangeCurrentIndex());
  }

  List<Widget> screen = [
    Booking(),
    Done(),
    Archive(),
  ];

  List<String> title = [
    'Booking',
    'Done',
    'Archive',
  ];
  int isTime = 0;

  IconData iconData = Icons.edit;
  bool isShow = false;
  void changeBottomSheet({bool? show, IconData? icon}) {
    iconData = icon!;
    isShow = show!;
    emit(ChangeBottomSheet());
  }

  void changeTime(int index) {
    isTime = index;
    emit(ChangeTime());
  }

  late Database database;
  List<Map> tasks = [];
  List<Map> done = [];
  List<Map> archive = [];
  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) async {
      await database
          .execute(
              'CREATE TABLE clinic(id INTEGER PRIMARY KEY, name TEXT, date TEXT, time TEXT, phone TEXT,status TEXT)')
          .then((value) {
        print('created table');
        emit(CreateTableSucsses());
      });
    }, onOpen: (database) {
      print('opened table');
    }).then((value) {
      database = value;
      getDatabse(database);
      emit(CreateTableSucsses());
    }).catchError((er) {
      print(er.toString());
      emit(CreateTableError());
    });
  }

  Future insertDatabse({
    required String name,
    required String time,
    required String date,
    required String phone,
  }) async {
    return await database.transaction((txn) async {
      return txn.rawInsert(
          'INSERT INTO clinic(name, time, date, phone,status)VALUES("$name","$time","$date","$phone","new")');
    }).then((value) {
      print('insert$value tasks');
      getDatabse(database);
      emit(InsertTableSucsses());
    }).catchError((er) {
      print(er.toString());
      emit(InsertTableError());
    });
  }

  void getDatabse(database) {
    tasks = [];
    done = [];
    archive = [];
    database.rawQuery('SELECT * FROM clinic').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new') {
          tasks.add(element);
        } else if (element['status'] == 'done') {
          done.add(element);
        } else {
          archive.add(element);
        }
        emit(GetTableSucsses());
      });
    }).catchError((er) {
      print(er.toString());
      emit(GetTableError());
    });
  }

  void updateDatabse({
    required String status,
    required int id,
  }) {
    database.rawUpdate('UPDATE clinic SET status = ? WHERE id = ?',
        ['$status', id]).then((value) {
      print(value);
      getDatabse(database);
      emit(UpdateTableSucsses());
    }).catchError((er) {
      print(er.toString());
      emit(UpdateTableError());
    });
  }

  void deleteDatabase({required int id}) {
    database.rawDelete('DELETE FROM clinic WHERE id = ?', [id]).then((value) {
      getDatabse(database);

      emit(DeleteTableSucsses());
    }).catchError((er) {
      emit(DeleteTableError());

      print(er.toString());
    });
  }
}
