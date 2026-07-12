import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../data/sample_data.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/course_card.dart';
import '../../widgets/responsive_layout.dart';
import '../course/lesson_detail_screen.dart';

class CourseListScreen extends StatefulWidget {
  final bool showAllOnly;
  const CourseListScreen({super.key, required this.showAllOnly});

  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  String _query = '';
  String _category = 'All';

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<ProgressService>();
    final categories = ['All', ...{for (final c in SampleData.courses) c.category}];

    final filtered = SampleData.courses.where((c) {
      final matchesQuery =
          _query.isEmpty || c.title.toLowerCase().contains(_query.toLowerCase());
      final matchesCategory = _category == 'All' || c.category == _category;
      return matchesQuery && matchesCategory;
    }).toList();

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: ResponsiveContentWidth(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.showAllOnly ? 'All Courses' : 'Hello 👋',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    if (!widget.showAllOnly) ...[
                      const SizedBox(height: 4),
                      Text('What do you want to learn today?',
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                    const SizedBox(height: 18),
                    TextField(
                      onChanged: (v) => setState(() => _query = v),
                      decoration: const InputDecoration(
                        hintText: 'Search your perfect course',
                        prefixIcon: Icon(Icons.search_rounded),
                      ),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 38,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: categories.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, i) {
                          final cat = categories[i];
                          final selected = cat == _category;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            child: ChoiceChip(
                              label: Text(cat),
                              selected: selected,
                              selectedColor: AppColors.primary,
                              labelStyle: TextStyle(
                                color: selected ? Colors.white : AppColors.textDark,
                                fontWeight: FontWeight.w600,
                              ),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(AppRadii.pill),
                                side: BorderSide(color: Colors.grey.shade200),
                              ),
                              onSelected: (_) => setState(() => _category = cat),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: ResponsiveContentWidth(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final columns = responsiveColumns(context,
                        mobile: 1, tablet: 2, desktop: 3);
                    if (columns == 1) {
                      return Column(
                        children: [
                          for (final course in filtered)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 14),
                              child: CourseCard(
                                course: course,
                                progress: progress.progressForLessonIds(
                                    course.lessons.map((l) => l.id).toList()),
                                onTap: () => _openCourse(context, course.id),
                              ),
                            ),
                        ],
                      );
                    }
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filtered.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: columns,
                        mainAxisExtent: 96,
                        crossAxisSpacing: 14,
                        mainAxisSpacing: 14,
                      ),
                      itemBuilder: (context, i) {
                        final course = filtered[i];
                        return CourseCard(
                          course: course,
                          progress: progress.progressForLessonIds(
                              course.lessons.map((l) => l.id).toList()),
                          onTap: () => _openCourse(context, course.id),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 32)),
        ],
      ),
    );
  }

  void _openCourse(BuildContext context, String courseId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LessonDetailScreen(courseId: courseId, lessonIndex: 0),
      ),
    );
  }
}
