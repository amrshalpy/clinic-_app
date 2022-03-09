import 'package:clinic/cubit/cubit.dart';
import 'package:clinic/cubit/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var dateController = DateRangePickerController();
  var timeController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  List time = [
    '8:8.30',
    '8.30:9',
    '9:9.30',
    '9.30:10',
    '10:10.30',
    '10:30:11',
    '11:11.30',
    '11.30:12',
    '12:12.30',
    '12.30:1',
    '1:1.30',
    '1:30:2'
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider<Homecubit>(
      create: (context) => Homecubit()..createDatabase(),
      child: BlocConsumer<Homecubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          Homecubit cubit = Homecubit.get(context);
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              titleTextStyle: TextStyle(
                fontSize: 25,
                color: Colors.deepOrange,
                fontWeight: FontWeight.w700,
              ),
              title: Text(cubit.title[cubit.currentIndex]),
            ),
            body: cubit.screen[cubit.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              unselectedIconTheme: IconThemeData(
                size: 25,
                color: Colors.grey,
              ),
              selectedIconTheme: IconThemeData(
                size: 39,
                color: Colors.orangeAccent,
              ),
              unselectedItemColor: Colors.black45,
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeCurrentIndex(index);
              },
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.verified_user_outlined),
                    label: 'booking '),
                BottomNavigationBarItem(icon: Icon(Icons.done), label: 'done '),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'archive '),
              ],
            ),
            floatingActionButton: Builder(builder: (context) {
              return FloatingActionButton(
                onPressed: () {
                  Scaffold.of(context).showBottomSheet((context) =>
                      SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Form(
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'this field must be not empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'name',
                                        label: Text('name'),
                                        prefixIcon:
                                            Icon(Icons.verified_user_sharp),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TextFormField(
                                      controller: phoneController,
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'this field must be not empty';
                                        } else {
                                          return null;
                                        }
                                      },
                                      keyboardType: TextInputType.phone,
                                      decoration: InputDecoration(
                                        border: OutlineInputBorder(),
                                        hintText: 'phone',
                                        label: Text('phone'),
                                        prefixIcon: Icon(Icons.phone),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SfDateRangePicker(
                                      view: DateRangePickerView.month,
                                      monthViewSettings:
                                          DateRangePickerMonthViewSettings(
                                              firstDayOfWeek: 1),
                                      onSelectionChanged: _onSelectionChanged,
                                      initialSelectedRange: PickerDateRange(
                                          DateTime.now().subtract(
                                              const Duration(days: 4)),
                                          DateTime.now()
                                              .add(const Duration(days: 3))),
                                      controller: dateController,
                                      enablePastDates: true,
                                      selectionColor: Colors.orangeAccent,
                                      showActionButtons: true,
                                      selectionMode:
                                          DateRangePickerSelectionMode
                                              .multiRange,
                                      onCancel: () =>
                                          dateController.selectedRange = null,
                                      selectionTextStyle: TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    GridView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        gridDelegate:
                                            SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          childAspectRatio: 1,
                                          crossAxisSpacing: 3,
                                          mainAxisSpacing: 3,
                                        ),
                                        itemCount: time.length,
                                        itemBuilder: (context, index) =>
                                            InkWell(
                                              onTap: () {
                                                cubit.changeTime(index);
                                                print(time[index]);
                                              },
                                              child: Container(
                                                height: 20,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: .2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: cubit.isTime == index
                                                      ? Colors.orangeAccent
                                                      : Colors.white,
                                                ),
                                                child: Center(
                                                    child: Text(
                                                  time[index],
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                )),
                                              ),
                                            )),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            primary: Colors.orangeAccent,
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                            )),
                                        onPressed: () {
                                          cubit.insertDatabse(
                                              phone: phoneController.text,
                                              name: nameController.text,
                                              time: time[cubit.isTime],
                                              date: dateController.displayDate
                                                  .toString());
                                          Navigator.pop(context);
                                          phoneController.clear();
                                          nameController.clear();
                                        },
                                        child: Text('Add Booking'))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ));
                },
                child: Icon(cubit.iconData),
              );
            }),
          );
        },
      ),
    );
  }

  void _onSelectionChanged(
      DateRangePickerSelectionChangedArgs
          dateRangePickerSelectionChangedArgs) {}
}
