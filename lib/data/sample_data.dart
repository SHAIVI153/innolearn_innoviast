import '../models/course.dart';
import '../models/lesson.dart';
import '../models/quiz_question.dart';

/// Static in-memory catalog used to drive the prototype UI.
/// Swap this out for a real API/Firebase source later.
class SampleData {
  static final List<Course> courses = [
    Course(
      id: 'ux-ui',
      title: 'UX/UI Design Fundamentals',
      category: 'Design',
      instructor: 'David Smith',
      rating: 4.8,
      studentsCount: 1280,
      emoji: '🎨',
      gradientColors: const [0xFF6C5CE7, 0xFFA29BFE],
      lessons: [
        Lesson(
          id: 'l1',
          title: 'Introduction to UX Thinking',
          durationLabel: '6:12',
          content:
              'Learn how great products start with empathy for the user. '
              'We cover the double-diamond process: discover, define, '
              'develop, and deliver — and how each stage shapes a '
              'better learning experience app.',
          quiz: [
            QuizQuestion(
              id: 'q1',
              question: 'What is the first stage of the double-diamond process?',
              options: const ['Deliver', 'Discover', 'Develop', 'Define'],
              correctIndex: 1,
            ),
            QuizQuestion(
              id: 'q2',
              question: 'UX design primarily focuses on:',
              options: const [
                'Server infrastructure',
                'User needs and experience',
                'Marketing budgets',
                'Database schemas'
              ],
              correctIndex: 1,
            ),
          ],
        ),
        Lesson(
          id: 'l2',
          title: 'Wireframes & Prototypes',
          durationLabel: '8:40',
          content:
              'Wireframes let you validate structure and flow before '
              'investing in visual design. We compare low-fidelity '
              'sketches to interactive Figma prototypes.',
          quiz: [
            QuizQuestion(
              id: 'q3',
              question: 'Wireframes are best used to validate:',
              options: const [
                'Final color palette',
                'Structure and flow',
                'App store pricing',
                'Marketing copy'
              ],
              correctIndex: 1,
            ),
          ],
        ),
      ],
    ),
    Course(
      id: 'web-design',
      title: 'Responsive Web Design',
      category: 'Design',
      instructor: 'Amelia Black',
      rating: 4.6,
      studentsCount: 940,
      emoji: '💻',
      gradientColors: const [0xFF74B9FF, 0xFF0984E3],
      lessons: [
        Lesson(
          id: 'l3',
          title: 'Breakpoints & Fluid Grids',
          durationLabel: '7:05',
          content:
              'A responsive layout adapts gracefully across mobile, '
              'tablet, and desktop by using flexible grids and '
              'breakpoints instead of fixed pixel widths.',
          quiz: [
            QuizQuestion(
              id: 'q4',
              question: 'A fluid grid uses:',
              options: const [
                'Fixed pixel widths only',
                'Relative units and flexible columns',
                'A single screen size',
                'No layout system'
              ],
              correctIndex: 1,
            ),
          ],
        ),
      ],
    ),
    Course(
      id: 'graphics',
      title: 'Graphics Design Basics',
      category: 'Design',
      instructor: 'Jerome Bell',
      rating: 4.3,
      studentsCount: 610,
      emoji: '🖌️',
      gradientColors: const [0xFFFD79A8, 0xFFE84393],
      lessons: [
        Lesson(
          id: 'l4',
          title: 'Color Theory Essentials',
          durationLabel: '5:30',
          content:
              'Color communicates emotion and hierarchy. This lesson '
              'covers complementary, analogous, and triadic color '
              'schemes for learning app interfaces.',
          quiz: [
            QuizQuestion(
              id: 'q5',
              question: 'Complementary colors sit:',
              options: const [
                'Next to each other on the wheel',
                'Opposite each other on the wheel',
                'Always shades of gray',
                'Only in print design'
              ],
              correctIndex: 1,
            ),
          ],
        ),
      ],
    ),
    Course(
      id: 'mobile-dev',
      title: 'Mobile App Development',
      category: 'Development',
      instructor: 'Khan Cluse',
      rating: 4.9,
      studentsCount: 2100,
      emoji: '📱',
      gradientColors: const [0xFF00B894, 0xFF00CEC9],
      lessons: [
        Lesson(
          id: 'l5',
          title: 'Widgets & Navigation in Flutter',
          durationLabel: '9:15',
          content:
              'Flutter apps are built from widgets composed into a '
              'tree. Navigator manages the screen stack, letting you '
              'push and pop routes with animated transitions.',
          quiz: [
            QuizQuestion(
              id: 'q6',
              question: 'In Flutter, screens are pushed/popped using:',
              options: const [
                'Navigator',
                'Provider',
                'ThemeData',
                'MediaQuery'
              ],
              correctIndex: 0,
            ),
          ],
        ),
      ],
    ),
  ];

  static Course courseById(String id) =>
      courses.firstWhere((c) => c.id == id, orElse: () => courses.first);
}
