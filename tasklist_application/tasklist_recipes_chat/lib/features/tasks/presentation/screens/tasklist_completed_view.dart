import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tasklist_recipes_chat/core/constants/colors.dart';
import 'package:tasklist_recipes_chat/features/tasks/data/models/tasklist.dart';
import 'package:tasklist_recipes_chat/features/tasks/presentation/controllers/tasklist_cubit.dart';

class TasklistCompletedView extends StatelessWidget {
  const TasklistCompletedView({super.key, required this.list});
  final List<TaskList> list;
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<TasklistCubit>(context).getTasklist(context: context);
      },
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return InkWell(
            splashColor: Colors.black,
            onLongPress: () {
              BlocProvider.of<TasklistCubit>(context).updateTasklist(
                context: context,
                tasklist: list[index],
              );
            },
            child: Container(
              width: double.infinity,
              height: 130.h,
              padding: EdgeInsets.all(6.sp),
              margin: EdgeInsets.all(12.sp),
              decoration: BoxDecoration(
                color: kTasklistColors[index % kTasklistColors.length],
                borderRadius: BorderRadius.circular(10.r),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, top: 5.sp),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: 230.w,
                              child: Text(
                                list[index].title,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 22.sp,
                                  fontWeight: FontWeight.bold,
                                  color: kTasklistTextColor,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                  width: 39.w,
                                  child: Text(
                                    list[index].tasksCount.toString(),
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      // Todo : add delete tasklist logic
                                      BlocProvider.of<TasklistCubit>(context)
                                          .deleteTasklist(
                                              title: list[index].title,
                                              context: context);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: 25.sp,
                                    )),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 10.sp, top: 10.sp),
                    child: SizedBox(
                      width: 310.w,
                      child: Text(
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        list[index].description,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: kTasklistTextColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}