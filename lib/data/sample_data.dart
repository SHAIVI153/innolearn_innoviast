import '../models/course.dart';
import '../models/lesson.dart';
import '../models/quiz_question.dart';

/// Static in-memory catalog used to drive the prototype UI.
/// Swap this out for a real API/Firebase source later.
///
/// Each course now ships with enough video lessons to feel like a real
/// mini-course, and every course totals exactly 10 quiz questions spread
/// across its lessons (with a final "Course Assessment" lesson wrapping
/// things up). All copy is in English.
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
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
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
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
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
        Lesson(
          id: 'l1b',
          title: 'Design Systems in Practice',
          durationLabel: '8:20',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          content:
          'A design system is a shared library of colors, type styles, '
              'and reusable components that keeps an app visually '
              'consistent as it grows. We look at how tokens, components, '
              'and documentation work together across a real product team.',
          quiz: [
            QuizQuestion(
              id: 'q1_ds1',
              question: 'A design system mainly helps teams achieve:',
              options: const [
                'Faster server response times',
                'Visual and behavioral consistency',
                'Lower app store fees',
                'Automatic code compilation'
              ],
              correctIndex: 1,
            ),
            QuizQuestion(
              id: 'q1_ds2',
              question: 'Design tokens typically store things like:',
              options: const [
                'Colors, spacing, and typography values',
                'User passwords',
                'Server IP addresses',
                'App store reviews'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q1_ds3',
              question: 'Reusable UI components help teams by:',
              options: const [
                'Forcing every screen to look different',
                'Reducing duplicate design and code work',
                'Increasing app size only',
                'Removing the need for a style guide'
              ],
              correctIndex: 1,
            ),
            QuizQuestion(
              id: 'q1_ds4',
              question: 'Good design documentation mainly helps:',
              options: const [
                'Marketing teams write ads',
                'New team members use components correctly',
                'Users skip onboarding',
                'Servers scale automatically'
              ],
              correctIndex: 1,
            ),
          ],
        ),
        Lesson(
          id: 'l1c',
          title: 'Course Wrap-up & Assessment',
          durationLabel: '3:45',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          content:
          'A quick recap of the UX/UI journey so far: empathizing with '
              'users, sketching wireframes, and building a consistent '
              'design system. This final check-in reviews the key ideas '
              'before you move on to the next course.',
          quiz: [
            QuizQuestion(
              id: 'q1_fa1',
              question: 'The double-diamond process ends with which stage?',
              options: const ['Discover', 'Define', 'Develop', 'Deliver'],
              correctIndex: 3,
            ),
            QuizQuestion(
              id: 'q1_fa2',
              question: 'Before building high-fidelity screens, designers usually create:',
              options: const [
                'Marketing copy',
                'Low-fidelity wireframes',
                'App store listings',
                'Push notification templates'
              ],
              correctIndex: 1,
            ),
            QuizQuestion(
              id: 'q1_fa3',
              question: 'Consistency across screens is easiest to maintain with:',
              options: const [
                'A shared design system',
                'Random color choices per screen',
                'Copy-pasting screenshots',
                'Skipping documentation'
              ],
              correctIndex: 0,
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
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
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
        Lesson(
          id: 'l3b',
          title: 'Flexbox & Grid Layouts',
          durationLabel: '8:00',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
          content:
          'CSS Flexbox and Grid give you precise control over how '
              'content lines up and wraps on different screen sizes. This '
              'lesson compares when to reach for each layout system.',
          quiz: [
            QuizQuestion(
              id: 'q4_fx1',
              question: 'Flexbox is best suited for laying out content:',
              options: const [
                'In a single row or column',
                'Only in 3D space',
                'Only inside images',
                'Only in print stylesheets'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q4_fx2',
              question: 'CSS Grid is especially useful for:',
              options: const [
                'Two-dimensional row-and-column layouts',
                'Playing videos',
                'Storing user data',
                'Sending push notifications'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q4_fx3',
              question: 'Media queries let a layout:',
              options: const [
                'Change styles based on screen size',
                'Connect to a database',
                'Compile faster',
                'Send emails'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q4_fx4',
              question: 'A "mobile-first" approach means designing first for:',
              options: const [
                'The smallest screens, then scaling up',
                'The largest desktop monitor',
                'Print layouts',
                'Smart TVs only'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'l3c',
          title: 'Course Wrap-up & Assessment',
          durationLabel: '4:10',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerMeltdowns.mp4',
          content:
          'Let\u2019s review what makes a layout truly responsive: fluid '
              'grids, smart breakpoints, and the right mix of Flexbox and '
              'Grid. This final lesson checks your understanding before '
              'moving to the next course.',
          quiz: [
            QuizQuestion(
              id: 'q4_fa1',
              question: 'Breakpoints in responsive design are used to:',
              options: const [
                'Change styles at certain screen widths',
                'Break the build process',
                'Disable animations',
                'Increase server load'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q4_fa2',
              question: 'Which unit helps create fluid, scalable sizing?',
              options: const ['px only', '%, rem, or vw/vh', 'pt', 'in'],
              correctIndex: 1,
            ),
            QuizQuestion(
              id: 'q4_fa3',
              question: 'A layout that only works on one screen size is:',
              options: const [
                'Responsive',
                'Fixed and not responsive',
                'Mobile-first',
                'Accessible'
              ],
              correctIndex: 1,
            ),
            QuizQuestion(
              id: 'q4_fa4',
              question: 'CSS Grid organizes content using:',
              options: const [
                'Rows and columns',
                'Only colors',
                'Only fonts',
                'Only animations'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q4_fa5',
              question: 'Testing a responsive design across devices helps you:',
              options: const [
                'Catch layout issues before launch',
                'Skip QA entirely',
                'Avoid writing CSS',
                'Increase app store fees'
              ],
              correctIndex: 0,
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
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/Sintel.mp4',
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
        Lesson(
          id: 'l4b',
          title: 'Typography Fundamentals',
          durationLabel: '6:45',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/SubaruOutbackOnStreetAndDirt.mp4',
          content:
          'Good typography guides the eye and sets the tone of a '
              'design. We cover font pairing, hierarchy, line height, and '
              'legibility on small mobile screens.',
          quiz: [
            QuizQuestion(
              id: 'q5_tp1',
              question: 'Typographic hierarchy helps users:',
              options: const [
                'Scan and understand content faster',
                'Load images slower',
                'Ignore headings',
                'Increase file size'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q5_tp2',
              question: 'Line height (leading) affects:',
              options: const [
                'How readable a paragraph feels',
                'The app icon color',
                'Server response time',
                'Battery usage only'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q5_tp3',
              question: 'On small mobile screens, body text should generally be:',
              options: const [
                'Large enough to read comfortably without zooming',
                'As small as possible',
                'Always italic',
                'Always uppercase'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q5_tp4',
              question: 'Pairing fonts well usually means combining:',
              options: const [
                'Two typefaces with clear contrast and purpose',
                'As many fonts as possible',
                'Only decorative script fonts',
                'Only system default fonts'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'l4c',
          title: 'Course Wrap-up & Assessment',
          durationLabel: '4:00',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4',
          content:
          'From color wheels to font pairing, this recap ties '
              'together the visual design basics covered in the course '
              'and checks your understanding with a short assessment.',
          quiz: [
            QuizQuestion(
              id: 'q5_fa1',
              question: 'Analogous colors are:',
              options: const [
                'Colors next to each other on the wheel',
                'Colors directly opposite each other',
                'Only black and white',
                'Only warm colors'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q5_fa2',
              question: 'A triadic color scheme uses:',
              options: const [
                'Three colors evenly spaced on the wheel',
                'Only one color',
                'Only grayscale tones',
                'Random unrelated colors'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q5_fa3',
              question: 'Strong visual hierarchy is created mainly through:',
              options: const [
                'Size, weight, and color contrast',
                'Using one font size everywhere',
                'Removing all whitespace',
                'Random alignment'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q5_fa4',
              question: 'Legibility on mobile screens is improved by:',
              options: const [
                'Sufficient contrast and readable font sizes',
                'Tiny low-contrast text',
                'Overlapping text on images',
                'Removing spacing between lines'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q5_fa5',
              question: 'Consistent color usage across a course app helps:',
              options: const [
                'Reinforce brand identity and recognition',
                'Slow down the app',
                'Confuse the user intentionally',
                'Increase server costs'
              ],
              correctIndex: 0,
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
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/VolkswagenGTIReview.mp4',
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
        Lesson(
          id: 'l5b',
          title: 'State Management Basics',
          durationLabel: '9:30',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WeAreGoingOnBullrun.mp4',
          content:
          'As apps grow, managing state cleanly becomes essential. '
              'We compare setState, Provider, and simple service classes '
              'for sharing data like course progress across screens.',
          quiz: [
            QuizQuestion(
              id: 'q6_sm1',
              question: 'setState() in Flutter is used to:',
              options: const [
                'Rebuild a widget after its data changes',
                'Compile the app',
                'Send network requests',
                'Change the app icon'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q6_sm2',
              question: 'Provider is commonly used in Flutter to:',
              options: const [
                'Share and manage state across widgets',
                'Style buttons',
                'Compress images',
                'Handle only navigation'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q6_sm3',
              question: 'Local persistence (like saving lesson progress) is often done with:',
              options: const [
                'SharedPreferences or a local database',
                'Only in-memory variables',
                'The app icon file',
                'The pubspec.yaml file'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q6_sm4',
              question: 'A StatefulWidget is used when a widget needs to:',
              options: const [
                'Change its internal data over time',
                'Never change',
                'Only display static text',
                'Only run on desktop'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'l5c',
          title: 'Course Wrap-up & Assessment',
          durationLabel: '5:00',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/WhatCarCanYouGetForAGrand.mp4',
          content:
          'This final lesson reviews Flutter navigation, widget '
              'composition, and state management, then checks your '
              'understanding with a short course assessment.',
          quiz: [
            QuizQuestion(
              id: 'q6_fa1',
              question: 'Flutter builds its UI from a tree of:',
              options: const ['Widgets', 'HTML tags', 'XML layouts only', 'CSS classes'],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q6_fa2',
              question: 'MaterialPageRoute is typically used with:',
              options: const [
                'Navigator.push to show a new screen',
                'Provider to manage state',
                'ThemeData to set colors',
                'SharedPreferences to save data'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q6_fa3',
              question: 'Keeping quiz progress after the app restarts requires:',
              options: const [
                'Local persistence',
                'Only in-memory state',
                'A bigger screen',
                'Disabling Navigator'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q6_fa4',
              question: 'Reusable widgets (like a course card) help by:',
              options: const [
                'Avoiding duplicate UI code across screens',
                'Making the app slower',
                'Removing the need for a theme',
                'Blocking navigation'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q6_fa5',
              question: 'context.watch() in Provider is used to:',
              options: const [
                'Rebuild a widget when a service\u2019s data changes',
                'Delete app data',
                'Change the device language',
                'Compile release builds'
              ],
              correctIndex: 0,
            ),
          ],
        ),
      ],
    ),
    Course(
      id: 'productivity',
      title: 'Personal Productivity & Time Management',
      category: 'Productivity',
      instructor: 'Sara Malik',
      rating: 4.7,
      studentsCount: 1523,
      emoji: '⏱️',
      gradientColors: const [0xFFFFA502, 0xFFFF6348],
      lessons: [
        Lesson(
          id: 'l6',
          title: 'Why Task Management Matters',
          durationLabel: '5:20',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          content:
          'A clear task system reduces stress and helps you focus on '
              'what matters most. This lesson introduces categories, due '
              'dates, and priority levels as the building blocks of any '
              'good productivity app.',
          quiz: [
            QuizQuestion(
              id: 'q7_1',
              question: 'A well-organized task list mainly helps you:',
              options: const [
                'Focus on the right priorities',
                'Forget your deadlines',
                'Avoid using a calendar',
                'Increase distractions'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q7_2',
              question: 'Assigning a category to a task helps you:',
              options: const [
                'Group related tasks together',
                'Delete the task automatically',
                'Hide the due date',
                'Change the app theme'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q7_3',
              question: 'A due date on a task is mainly used to:',
              options: const [
                'Show when the task should be completed',
                'Change the task\u2019s color randomly',
                'Delete old tasks',
                'Set the app language'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'l6b',
          title: 'Prioritization: The Eisenhower Matrix',
          durationLabel: '7:15',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
          content:
          'The Eisenhower Matrix sorts tasks into four quadrants by '
              'urgency and importance, helping you decide what to do now, '
              'schedule later, delegate, or drop entirely.',
          quiz: [
            QuizQuestion(
              id: 'q7_4',
              question: 'The Eisenhower Matrix sorts tasks by:',
              options: const [
                'Urgency and importance',
                'Alphabetical order only',
                'File size',
                'Creation date only'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q7_5',
              question: 'Tasks that are important but not urgent should usually be:',
              options: const [
                'Scheduled for later',
                'Deleted immediately',
                'Done first, before anything else',
                'Ignored completely'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q7_6',
              question: 'Tasks that are neither urgent nor important are good candidates to:',
              options: const [
                'Eliminate or postpone',
                'Do first every day',
                'Pin to the top of the list',
                'Assign the highest priority'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q7_7',
              question: 'A visual priority tag (like High/Medium/Low) helps users:',
              options: const [
                'Quickly see what needs attention first',
                'Slow down decision making',
                'Hide tasks permanently',
                'Replace the due date'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'l6c',
          title: 'Building Habits & Course Assessment',
          durationLabel: '4:50',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
          content:
          'Small daily habits, like reviewing your list each morning '
              'and clearing completed tasks, keep a productivity system '
              'sustainable. This final lesson recaps the course with a '
              'short assessment.',
          quiz: [
            QuizQuestion(
              id: 'q7_8',
              question: 'Marking a task as complete mainly gives users:',
              options: const [
                'A clear visual sense of progress',
                'A new due date automatically',
                'A lower priority level',
                'A new category'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q7_9',
              question: 'A daily review habit helps you:',
              options: const [
                'Stay on top of priorities consistently',
                'Forget your task list',
                'Avoid checking due dates',
                'Skip planning entirely'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q7_10',
              question: 'Local persistence in a task app ensures that:',
              options: const [
                'Tasks remain saved after closing the app',
                'Tasks are deleted every time the app restarts',
                'Tasks sync only over Bluetooth',
                'Tasks cannot have due dates'
              ],
              correctIndex: 0,
            ),
          ],
        ),
      ],
    ),
    Course(
      id: 'react-native',
      title: 'React Native Fundamentals',
      category: 'Development',
      instructor: 'Ali Raza',
      rating: 4.6,
      studentsCount: 875,
      emoji: '⚛️',
      gradientColors: const [0xFF00A8FF, 0xFF0097E6],
      lessons: [
        Lesson(
          id: 'l8',
          title: 'Components & Props',
          durationLabel: '8:10',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
          content:
          'React Native apps are built from reusable components. '
              'This lesson covers how props pass data into a component '
              'and how that keeps your UI predictable and reusable.',
          quiz: [
            QuizQuestion(
              id: 'q8_1',
              question: 'In React Native, props are used to:',
              options: const [
                'Pass data into a component',
                'Store the app icon',
                'Compile the app',
                'Change the operating system'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q8_2',
              question: 'A component in React Native is best described as:',
              options: const [
                'A reusable, self-contained piece of UI',
                'A database table',
                'A network request',
                'An app store listing'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q8_3',
              question: 'Props passed to a component are typically:',
              options: const [
                'Read-only from the component\u2019s perspective',
                'Automatically saved to a server',
                'Only usable in web apps',
                'Required to be numbers'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'l8b',
          title: 'Navigation & State',
          durationLabel: '9:00',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
          content:
          'React Navigation lets you move between screens, while '
              'local state (via useState) keeps track of things like '
              'form input or completed tasks between renders.',
          quiz: [
            QuizQuestion(
              id: 'q8_4',
              question: 'React Navigation is primarily used to:',
              options: const [
                'Move between screens in an app',
                'Style text',
                'Store images',
                'Compile native code'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q8_5',
              question: 'The useState hook lets a component:',
              options: const [
                'Hold and update local data',
                'Send push notifications',
                'Change the app name',
                'Access the file system directly'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q8_6',
              question: 'A stack navigator typically shows screens as:',
              options: const [
                'A stack you can push and pop from',
                'Tabs only',
                'A single fixed screen',
                'A grid of icons'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q8_7',
              question: 'Updating state in React Native should trigger:',
              options: const [
                'A re-render of the affected component',
                'A full app reinstall',
                'A server restart',
                'Nothing visible'
              ],
              correctIndex: 0,
            ),
          ],
        ),
        Lesson(
          id: 'l8c',
          title: 'Course Wrap-up & Assessment',
          durationLabel: '5:30',
          videoUrl: 'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4',
          content:
          'A recap of components, props, navigation, and state '
              'management in React Native, followed by a short '
              'assessment to check what you\u2019ve learned.',
          quiz: [
            QuizQuestion(
              id: 'q8_8',
              question: 'Reusable components help teams by:',
              options: const [
                'Reducing duplicate UI code',
                'Increasing app size only',
                'Removing the need for testing',
                'Blocking navigation'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q8_9',
              question: 'Passing a function as a prop is commonly used to:',
              options: const [
                'Let a child component notify its parent of an event',
                'Store data permanently',
                'Change the device language',
                'Compile the app for release'
              ],
              correctIndex: 0,
            ),
            QuizQuestion(
              id: 'q8_10',
              question: 'A well-structured navigation flow mainly improves:',
              options: const [
                'How easily users move through the app',
                'The color palette',
                'The app\u2019s file size',
                'The device battery health'
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