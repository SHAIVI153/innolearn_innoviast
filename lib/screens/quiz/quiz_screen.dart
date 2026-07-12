import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/quiz_question.dart';
import '../../services/progress_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/responsive_layout.dart';
import '../main_navigation.dart';

class QuizScreen extends StatefulWidget {
  final String courseId;
  final String lessonId;
  final List<QuizQuestion> questions;

  const QuizScreen({
    super.key,
    required this.courseId,
    required this.lessonId,
    required this.questions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _current = 0;
  int? _selected;
  int _score = 0;
  bool _finished = false;

  QuizQuestion get _question => widget.questions[_current];

  void _select(int index) {
    if (_selected != null) return;
    setState(() {
      _selected = index;
      if (index == _question.correctIndex) _score++;
    });
    Future.delayed(const Duration(milliseconds: 700), () {
      if (!mounted) return;
      if (_current < widget.questions.length - 1) {
        setState(() {
          _current++;
          _selected = null;
        });
      } else {
        setState(() => _finished = true);
        context
            .read<ProgressService>()
            .saveQuizScore(widget.lessonId, _score);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('Quiz')),
      body: SafeArea(
        child: ResponsiveContentWidth(
          maxWidth: 640,
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _finished
                  ? _ResultView(
                      key: const ValueKey('result'),
                      score: _score,
                      total: widget.questions.length,
                    )
                  : _QuestionView(
                      key: ValueKey(_current),
                      question: _question,
                      index: _current,
                      total: widget.questions.length,
                      selected: _selected,
                      onSelect: _select,
                    ),
            ),
          ),
        ),
      ),
    );
  }
}

class _QuestionView extends StatelessWidget {
  final QuizQuestion question;
  final int index;
  final int total;
  final int? selected;
  final ValueChanged<int> onSelect;

  const _QuestionView({
    super.key,
    required this.question,
    required this.index,
    required this.total,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      key: key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.pill),
          child: LinearProgressIndicator(
            value: (index + 1) / total,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            valueColor: const AlwaysStoppedAnimation(AppColors.primary),
          ),
        ),
        const SizedBox(height: 8),
        Text('Question ${index + 1} of $total',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 20),
        Text(question.question, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 24),
        ...List.generate(question.options.length, (i) {
          final isCorrect = i == question.correctIndex;
          final isSelected = i == selected;
          Color bg = Colors.white;
          Color border = Colors.grey.shade200;
          if (selected != null) {
            if (isCorrect) {
              bg = AppColors.success.withOpacity(0.12);
              border = AppColors.success;
            } else if (isSelected) {
              bg = Colors.red.withOpacity(0.08);
              border = Colors.red;
            }
          }
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(AppRadii.md),
              border: Border.all(color: border, width: 1.4),
            ),
            child: ListTile(
              onTap: () => onSelect(i),
              title: Text(question.options[i]),
              trailing: selected != null && isCorrect
                  ? const Icon(Icons.check_circle_rounded, color: AppColors.success)
                  : (selected != null && isSelected
                      ? const Icon(Icons.cancel_rounded, color: Colors.red)
                      : null),
            ),
          );
        }),
      ],
    );
  }
}

class _ResultView extends StatelessWidget {
  final int score;
  final int total;

  const _ResultView({super.key, required this.score, required this.total});

  @override
  Widget build(BuildContext context) {
    final pct = total == 0 ? 0.0 : score / total;
    return Column(
      key: key,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 40),
        TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: pct),
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeOutCubic,
          builder: (context, value, _) => Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 140,
                height: 140,
                child: CircularProgressIndicator(
                  value: value,
                  strokeWidth: 10,
                  backgroundColor: Colors.grey.shade200,
                  valueColor: const AlwaysStoppedAnimation(AppColors.primary),
                ),
              ),
              Text('$score/$total',
                  style: Theme.of(context).textTheme.titleLarge),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Text(
          pct >= 0.7 ? 'Great job! 🎉' : 'Keep practicing 💪',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 8),
        Text('You scored ${(pct * 100).round()}% on this quiz.',
            style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 32),
        ElevatedButton(
          onPressed: () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const MainNavigation()),
            (route) => false,
          ),
          child: const Text('Back to courses'),
        ),
      ],
    );
  }
}
