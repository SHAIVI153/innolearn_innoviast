import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
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

  VideoPlayerController? _controller;
  bool _isLoadingVideo = false;
  bool _hasVideoError = false;

  @override
  void initState() {
    super.initState();
    _loadVideoForCurrentLesson();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _loadVideoForCurrentLesson() {
    // Tear down any previous controller before loading the new lesson's video.
    _controller?.dispose();
    _controller = null;
    _hasVideoError = false;

    final course = SampleData.courseById(widget.courseId);
    final lesson = course.lessons[_currentIndex];
    final url = lesson.videoUrl;

    if (url == null || url.isEmpty) {
      setState(() => _isLoadingVideo = false);
      return;
    }

    setState(() => _isLoadingVideo = true);

    final controller = VideoPlayerController.networkUrl(Uri.parse(url));
    _controller = controller;

    controller.initialize().then((_) {
      if (!mounted || _controller != controller) return;
      setState(() => _isLoadingVideo = false);
    }).catchError((_) {
      if (!mounted || _controller != controller) return;
      setState(() {
        _isLoadingVideo = false;
        _hasVideoError = true;
      });
    });
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
    final gradient = LinearGradient(
      colors: course.gradientColors.map((c) => Color(c)).toList(),
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );

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
              _buildVideoPlayer(gradient),
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

  Widget _buildVideoPlayer(LinearGradient gradient) {
    final controller = _controller;
    final ready = controller != null && controller.value.isInitialized;

    return AspectRatio(
      aspectRatio: 16 / 9,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.lg),
        child: Container(
          decoration: BoxDecoration(gradient: gradient),
          child: ready
              ? Stack(
            fit: StackFit.expand,
            children: [
              FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: controller.value.size.width,
                  height: controller.value.size.height,
                  child: VideoPlayer(controller),
                ),
              ),
              AnimatedBuilder(
                animation: controller,
                builder: (context, _) {
                  final playing = controller.value.isPlaying;
                  return GestureDetector(
                    onTap: () => setState(() {
                      playing ? controller.pause() : controller.play();
                    }),
                    child: AnimatedOpacity(
                      opacity: playing ? 0 : 1,
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                        color: Colors.black26,
                        child: Center(
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.9),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow_rounded,
                              color: AppColors.primary,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: VideoProgressIndicator(
                  controller,
                  allowScrubbing: true,
                  padding: const EdgeInsets.all(8),
                  colors: const VideoProgressColors(
                    playedColor: Colors.white,
                    bufferedColor: Colors.white38,
                    backgroundColor: Colors.white12,
                  ),
                ),
              ),
            ],
          )
              : Center(
            child: _isLoadingVideo
                ? const CircularProgressIndicator(color: Colors.white)
                : Icon(
              _hasVideoError
                  ? Icons.error_outline_rounded
                  : Icons.play_circle_fill_rounded,
              color: Colors.white,
              size: 48,
            ),
          ),
        ),
      ),
    );
  }
}