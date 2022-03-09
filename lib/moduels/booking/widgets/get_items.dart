import 'package:clinic/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

Widget getItems(Map model, context) {
  return Dismissible(
    key: Key(model['id'].toString()),
    direction: DismissDirection.horizontal,
    onDismissed: (DismissDirection direction) {
      Homecubit.get(context).deleteDatabase(id: model['id']);
    },
    child: Card(
      child: Container(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                width: 30,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orangeAccent,
                ),
                child: Center(
                  child: Text(
                    '${model['time']}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    '${model['name']}',
                    maxLines: 2,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  ReadMoreText(
                    '${model['date']}',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    trimLines: 3,
                    trimMode: TrimMode.Length,
                    trimLength: 2,
                    moreStyle: TextStyle(
                      color: Colors.blue,
                      fontSize: 12,
                    ),
                    lessStyle: TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  IconButton(
                      onPressed: () {
                        Homecubit.get(context)
                            .updateDatabse(status: 'done', id: model['id']);
                      },
                      icon: Icon(
                        Icons.done,
                        color: Colors.green,
                      )),
                  IconButton(
                      onPressed: () {
                        Homecubit.get(context)
                            .updateDatabse(status: 'archive', id: model['id']);
                      },
                      icon: Icon(
                        Icons.archive_outlined,
                        color: Colors.black45,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
