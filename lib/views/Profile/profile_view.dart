import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:todo_app/Logic/AuthCubit/auth_cubit.dart';
import 'package:todo_app/Logic/AuthCubit/auth_state.dart';
import 'package:todo_app/Logic/TaskCubit/task_cubit.dart';
import 'package:todo_app/Logic/TaskCubit/task_state.dart';
import 'package:todo_app/utils/app_color.dart';
import 'package:todo_app/views/login and signUp/components/profile_image.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is! AuthSuccessState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final user = state.user;
        final textTheme = Theme.of(context).textTheme;

        return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.surface,
          appBar: AppBar(
            title: const Text('Profile'),
            actions: [
              IconButton(
                tooltip: 'Edit profile',
                icon: const Icon(Icons.edit),
                onPressed: () {
                  context.go('/toDoHome/updateProfile');
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 24,
                    horizontal: 16,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: AppColor.gradientColor,
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: .08),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      user.userProfilePhotoPath == null
                          ? const ProfileImage()
                          : ProfileImage(
                              isImageSelected: true,
                              image: File(user.userProfilePhotoPath!),
                            ),
                      const SizedBox(height: 12),
                      Text(
                        user.userName,
                        style: textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 6),
                      Text(
                        user.userJob,
                        style: textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Stats + Pie chart
                BlocBuilder<TaskCubit, TaskState>(
                  builder: (context, taskState) {
                    int total = 0;
                    int completed = 0;
                    if (taskState is TaskLoaded) {
                      total = taskState.tasks.length;
                      completed = taskState.numOfComlatedTask;
                    }
                    final inProgress = total - completed;

                    return Column(
                      children: [
                        // Stat chips
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _StatChip(
                              label: 'Completed',
                              value: completed,
                              color: Colors.green,
                            ),
                            const SizedBox(width: 10),
                            _StatChip(
                              label: 'In Progress',
                              value: inProgress,
                              color: Colors.orange,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),

                        // Chart card
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Text(
                                  'Task Breakdown',
                                  style: textTheme.titleMedium,
                                ),
                                const SizedBox(height: 12),
                                SizedBox(
                                  height: 220,
                                  child: PieChart(
                                    PieChartData(
                                      sectionsSpace: 4,
                                      centerSpaceRadius: 42,
                                      centerSpaceColor: Colors.transparent,
                                      sections: total == 0
                                          ? [
                                              PieChartSectionData(
                                                value: 1,
                                                color: Colors.grey.shade300,
                                                title: '0',
                                                radius: 70,
                                                titleStyle:
                                                    textTheme.titleMedium,
                                              ),
                                            ]
                                          : [
                                              PieChartSectionData(
                                                value: completed.toDouble(),
                                                color: Colors.green,
                                                title: '$completed',
                                                radius: 70,
                                                titleStyle: textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                              PieChartSectionData(
                                                value: inProgress.toDouble(),
                                                color: Colors.orange,
                                                title: '$inProgress',
                                                radius: 70,
                                                titleStyle: textTheme
                                                    .titleMedium
                                                    ?.copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                            ],
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    _legendDot(color: Colors.green),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Completed',
                                      style: textTheme.bodyMedium,
                                    ),
                                    const SizedBox(width: 16),
                                    _legendDot(color: Colors.orange),
                                    const SizedBox(width: 6),
                                    Text(
                                      'In Progress',
                                      style: textTheme.bodyMedium,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _legendDot({required Color color}) {
    return Container(
      width: 10,
      height: 10,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const _StatChip({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: .1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: .2)),
      ),
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Text('$label: ', style: theme.bodyMedium),
          Text(
            '$value',
            style: theme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
