import 'package:doit_today/view/Profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:doit_today/core/resources/my_styles.dart';
import 'package:focus_detector_v2/focus_detector_v2.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return FocusDetector(
      child: BlocProvider(
        create: (context) => ProfileCubit()..loadProfileStats(),
        child: Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'My Statistics',
                    style: MyStyles.textStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
      
                    ),
                  ),
                  20.verticalSpace,
                  BlocBuilder<ProfileCubit, ProfileState>(
                    builder: (context, state) {
                      if (state is ProfileLoaded) {
                        return Column(
                          children: [
                            Row(
                              children: [
                                _StatCard(
                                  title: 'Total Tasks',
                                  value: state.totalTasks.toString(),
                                  color: Colors.blue,
                                  icon: Icons.task_alt,
                                ),
                                16.horizontalSpace,
                                _StatCard(
                                  title: 'Total Notes',
                                  value: state.totalNotes.toString(),
                                  color: Colors.amber,
                                  icon: Icons.note,
                                ),
                              ],
                            ),
                            16.verticalSpace,
                            Row(
                              children: [
                                _StatCard(
                                  title: 'Completed',
                                  value: state.completedTasks.toString(),
                                  color: Colors.green,
                                  icon: Icons.check_circle,
                                ),
                                16.horizontalSpace,
                                _StatCard(
                                  title: 'Pending',
                                  value: state.pendingTasks.toString(),
                                  color: Colors.red,
                                  icon: Icons.pending_actions,
                                ),
                              ],
                            ),
                            24.verticalSpace,
                            _ProgressSection(
                              completed: state.completedTasks,
                              total: state.totalTasks,
                            ),
                          ],
                        );
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(16.r),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24.sp),
            8.verticalSpace,
            Text(
              value,
              style: MyStyles.textStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            4.verticalSpace,
            Text(
              title,
              style: MyStyles.textStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProgressSection extends StatelessWidget {
  final int completed;
  final int total;

  const _ProgressSection({
    required this.completed,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final progress = total == 0 ? 0.0 : completed / total;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Task Progress',
            style: MyStyles.textStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          16.verticalSpace,
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[300],
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
            minHeight: 10.h,
            borderRadius: BorderRadius.circular(5.r),
          ),
          8.verticalSpace,
          Text(
            '${(progress * 100).toInt()}% Complete',
            style: MyStyles.textStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}