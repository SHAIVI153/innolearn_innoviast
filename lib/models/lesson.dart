import 'quiz_question.dart';

class Lesson {
  final String id;
  final String title;
  final String durationLabel; // e.g. "6:12"
  final String content;
  final List<QuizQuestion> quiz;
  final String? videoUrl; // network video played inline on the lesson screen

  const Lesson({
    required this.id,
    required this.title,
    required this.durationLabel,
    required this.content,
    this.quiz = const [],
    this.videoUrl,
  });
}