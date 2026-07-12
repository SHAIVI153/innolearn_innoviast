import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/sample_data.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/responsive_layout.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final allLessons =
        SampleData.courses.expand((c) => c.lessons).toList(growable: false);
    final completed = allLessons
        .where((l) => progress.isLessonComplete(l.id))
        .length;
    final overallPct =
        allLessons.isEmpty ? 0.0 : completed / allLessons.length;
    final quizzesTaken = progress.quizScores.length;
    final avgScorePct = quizzesTaken == 0
        ? 0.0
        : progress.quizScores.values.reduce((a, b) => a + b) /
            (quizzesTaken * 2); // rough normalizer, most lessons have ~2 Qs

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          ResponsiveContentWidth(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Your Progress', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 4),
                  Text('Tracking your learning journey',
                      style: Theme.of(context).textTheme.bodyMedium),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      borderRadius: BorderRadius.circular(AppRadii.lg),
                    ),
                    child: Row(
                      children: [
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0, end: overallPct),
                          duration: const Duration(milliseconds: 900),
                          curve: Curves.easeOutCubic,
                          builder: (context, value, _) => Stack(
                            alignment: Alignment.center,
                            children: [
                              SizedBox(
                                width: 84,
                                height: 84,
                                child: CircularProgressIndicator(
                                  value: value,
                                  strokeWidth: 8,
                                  backgroundColor: Colors.white24,
                                  valueColor:
                                      const AlwaysStoppedAnimation(Colors.white),
                                ),
                              ),
                              Text('${(value * 100).round()}%',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700)),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Overall completion',
                                  style: TextStyle(
                                      color: Colors.white, fontWeight: FontWeight.w600)),
                              const SizedBox(height: 4),
                              Text('$completed of ${allLessons.length} lessons done',
                                  style: const TextStyle(color: Colors.white70)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  LayoutBuilder(builder: (context, constraints) {
                    final columns =
                        responsiveColumns(context, mobile: 2, tablet: 3, desktop: 4);
                    final stats = [
                      _Stat('Courses', '${SampleData.courses.length}', Icons.menu_book_rounded),
                      _Stat('Lessons done', '$completed', Icons.check_circle_rounded),
                      _Stat('Quizzes taken', '$quizzesTaken', Icons.quiz_rounded),
                      _Stat('Avg. quiz score', '${(avgScorePct.clamp(0, 1) * 100).round()}%',
                          Icons.emoji_events_rounded),
                    ];
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: stats.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisExtent: 96,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemBuilder: (context, i) => _StatCard(stat: stats[i]),
                    );
                  }),
                  const SizedBox(height: 24),
                  Text('Course breakdown', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 12),
                  ...SampleData.courses.map((course) {
                    final pct = progress.progressForLessonIds(
                        course.lessons.map((l) => l.id).toList());
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(course.emoji, style: const TextStyle(fontSize: 22)),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(course.title,
                                      style: Theme.of(context).textTheme.titleMedium),
                                ),
                                Text('${(pct * 100).round()}%',
                                    style: const TextStyle(
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(AppRadii.pill),
                              child: TweenAnimationBuilder<double>(
                                tween: Tween(begin: 0, end: pct),
                                duration: const Duration(milliseconds: 700),
                                builder: (context, value, _) => LinearProgressIndicator(
                                  value: value,
                                  minHeight: 8,
                                  backgroundColor: Colors.grey.shade200,
                                  valueColor:
                                      const AlwaysStoppedAnimation(AppColors.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Stat {
  final String label;
  final String value;
  final IconData icon;
  const _Stat(this.label, this.value, this.icon);
}

class _StatCard extends StatelessWidget {
  final _Stat stat;
  const _StatCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(AppRadii.md),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(stat.icon, color: AppColors.primary),
          const SizedBox(height: 8),
          Text(stat.value,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(fontWeight: FontWeight.w700)),
          Text(stat.label, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }
}
