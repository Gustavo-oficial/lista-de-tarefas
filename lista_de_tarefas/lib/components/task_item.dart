import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/task.dart';

class TaskItemList extends StatelessWidget {
  const TaskItemList({Key? key, required this.task, required this.onDelete}) : super(key: key);
  final Task task;
  final Function(Task) onDelete;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            DateFormat('dd/MM/yyy HH:mm').format(task.datetime).toString(),
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w700,
                overflow: TextOverflow.ellipsis
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            width: MediaQuery.of(context).size.width * .9,
            height: MediaQuery.of(context).size.height * .1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.green.shade50,
            ),
            child: Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Icon(
                          Icons.task,
                          color: Colors.black54,
                          size: 40,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          task.title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            overflow: TextOverflow.ellipsis,
                            fontSize: 20
                          ),
                        ),
                      ),
                    ],
                  ) 
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .15,
                  height: MediaQuery.of(context).size.height * .1,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: Colors.red,
                  ),
                  child: IconButton(
                    onPressed: () {
                      onDelete(task);
                    }, 
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 35,
                    )
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
