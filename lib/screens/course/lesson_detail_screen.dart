import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../data/sample_data.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/responsive_layout.dart';
import '../quiz/quiz_screen.dart';

class LessonDetailScreen extends StatefulWidget {
  final String courseId;
  final int lessonIndex;

  const LessonDetailScreen({
    super.key,
    required this.courseId,
    required this.lessonIndex,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late int _currentIndex = widget.lessonIndex;

  YoutubePlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _loadVideoForCurrentLesson();
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  void _loadVideoForCurrentLesson() {
    _controller?.close();
    _controller = null;

    final course = SampleData.courseById(widget.courseId);
    final lesson = course.lessons[_currentIndex];
    final url = lesson.videoUrl;

    if (url == null || url.isEmpty) {
      setState(() {});
      return;
    }

    final videoId = YoutubePlayerController.convertUrlToId(url);
    if (videoId == null) {
      setState(() {});
      return;
    }

    _controller = YoutubePlayerController(
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    )..loadVideoById(videoId: videoId);

    setState(() {});
  }

  void _selectLesson(int index) {
    setState(() => _currentIndex = index);
    _loadVideoForCurrentLesson();
  }

  @override
  Widget build(BuildContext context) {
    final course = SampleData.courseById(widget.courseId);
    final lesson = course.lessons[_currentIndex];
    final progress = context.watch<ProgressService>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ResponsiveContentWidth(
          maxWidth: 900,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  ),
                  Expanded(
                    child: Text(course.title,
                        style: Theme.of(context).textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildVideoPlayer(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(lesson.title,
                        style: Theme.of(context).textTheme.titleLarge),
                  ),
                  Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.08),
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                    child: Text(lesson.durationLabel,
                        style: const TextStyle(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600,
                            fontSize: 12)),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(lesson.content, style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 24),
              Text('Course lessons', style: Theme.of(context).textTheme.titleMedium),
              const SizedBox(height: 10),
              ...List.generate(course.lessons.length, (i) {
                final l = course.lessons[i];
                final done = progress.isLessonComplete(l.id);
                final selected = i == _currentIndex;
                return Card(
                  color: selected ? AppColors.primary.withOpacity(0.06) : Colors.white,
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    onTap: () => _selectLesson(i),
                    leading: Icon(
                      done
                          ? Icons.check_circle_rounded
                          : Icons.play_circle_outline_rounded,
                      color: done ? AppColors.success : AppColors.primary,
                    ),
                    title: Text(l.title),
                    subtitle: Text(l.durationLabel),
                    trailing: selected
                        ? const Icon(Icons.equalizer_rounded,
                        color: AppColors.primary)
                        : null,
                  ),
                );
              }),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                onPressed: () async {
                  await progress.markLessonComplete(lesson.id);
                  if (!context.mounted) return;
                  if (lesson.quiz.isNotEmpty) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => QuizScreen(
                          courseId: course.id,
                          lessonId: lesson.id,
                          questions: lesson.quiz,
                        ),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Lesson marked complete!')),
                    );
                  }
                },
                icon: const Icon(Icons.check_rounded),
                label: Text(
                    lesson.quiz.isNotEmpty ? 'Mark done & take quiz' : 'Mark as done'),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    final controller = _controller;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: controller == null
            ? Container(
          color: AppColors.primary.withOpacity(0.15),
          child: const Center(
            child: Icon(
              Icons.play_circle_fill_rounded,
              color: AppColors.primary,
              size: 48,
            ),
          ),
        )
            : YoutubePlayer(controller: controller),
      ),
    );
  }
}