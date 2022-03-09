import 'dart:ui';

import 'package:clinic/cubit/cubit.dart';
import 'package:clinic/cubit/state.dart';
import 'package:clinic/moduels/booking/widgets/get_items.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:readmore/readmore.dart';

class Booking extends StatelessWidget {
  const Booking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Homecubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        Homecubit cubit = Homecubit.get(context);
        return SingleChildScrollView(
          child: Column(
            children: [
              cubit.tasks.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) =>
                          getItems(cubit.tasks[index], context),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: cubit.tasks.length)
                  : Column(
                      children: [
                        Container(
                          height: 400,
                          width: double.infinity,
                          child: Image.asset(
                            'assets/images/undraw_real_time_analytics_re_yliv.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Booking havn\et any item',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        )
                      ],
                    ),
            ],
          ),
        );
      },
    );
  }
}
