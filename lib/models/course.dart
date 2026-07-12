import 'lesson.dart';

class Course {
  final String id;
  final String title;
  final String category;
  final String instructor;
  final double rating;
  final int studentsCount;
  final String emoji; // stand-in for an illustration/icon
  final List<int> gradientColors; // ARGB ints, resolved to Color in UI
  final List<Lesson> lessons;

  const Course({
    required this.id,
    required this.title,
    required this.category,
    required this.instructor,
    required this.rating,
    required this.studentsCount,
    required this.emoji,
    required this.gradientColors,
    required this.lessons,
  });

  int get lessonCount => lessons.length;
}
