import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';

/// TODO: Replace this with your real course/lesson data source
/// (e.g. a CourseRepository or the same list CourseListScreen uses).
/// Kept here only so this screen can compute totals without needing
/// another file. Swap `_totalLessons` / `_totalCourses` for your real counts.
const int _totalCourses = 4;
const int _totalLessons = 5;

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  void initState() {
    super.initState();
    // Make sure saved progress is loaded from SharedPreferences.
    final progress = context.read<ProgressService>();
    if (!progress.isLoaded) {
      progress.load();
    }
  }

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();

    final lessonsDone = progress.completedLessonIds.length;
    final quizzesTaken = progress.quizScores.length;
    final avgScore = quizzesTaken == 0
        ? 0.0
        : progress.quizScores.values.reduce((a, b) => a + b) / quizzesTaken;
    final overallPercent =
    _totalLessons == 0 ? 0.0 : lessonsDone / _totalLessons;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Your Progress',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              'Tracking your learning journey',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 20),

            // ---- Overall completion gradient card ----
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.circular(AppRadii.lg),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: 72,
                    height: 72,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        CircularProgressIndicator(
                          value: overallPercent,
                          strokeWidth: 6,
                          backgroundColor: Colors.white.withOpacity(0.25),
                          valueColor:
                          const AlwaysStoppedAnimation(Colors.white),
                        ),
                        Text(
                          '${(overallPercent * 100).round()}%',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Overall completion',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$lessonsDone of $_totalLessons lessons done',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // ---- Stat cards grid (overflow-safe) ----
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              // Taller aspect ratio gives cards more vertical room,
              // which is what fixes the "overflowed by 10.0 pixels" error.
              childAspectRatio: 1.5,
              children: [
                _StatCard(
                  icon: Icons.menu_book_rounded,
                  value: '$_totalCourses',
                  label: 'Courses',
                ),
                _StatCard(
                  icon: Icons.check_circle_rounded,
                  value: '$lessonsDone',
                  label: 'Lessons done',
                ),
                _StatCard(
                  icon: Icons.quiz_rounded,
                  value: '$quizzesTaken',
                  label: 'Quizzes taken',
                ),
                _StatCard(
                  icon: Icons.emoji_events_rounded,
                  value: '${avgScore.round()}%',
                  label: 'Avg. quiz score',
                ),
              ],
            ),
            const SizedBox(height: 24),

            Text(
              'Course breakdown',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),

            // TODO: Wire this to your real course list + per-course
            // progress via progress.progressForLessonIds(lessonIdsForCourse).
            if (lessonsDone == 0 && quizzesTaken == 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 24),
                child: Center(
                  child: Text(
                    'Start a lesson to see your course breakdown here.',
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// A single stat card. Uses `mainAxisSize.min` + no fixed height so the
/// content never overflows regardless of font scaling or screen size.
class _StatCard extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatCard({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppRadii.sm),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textDark,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textMuted,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}