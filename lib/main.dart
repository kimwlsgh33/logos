import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:get/get.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart' as trans;

import 'package:intl/date_symbol_data_local.dart';

import 'package:logos/src/config/routes/getx_routes.dart';

import 'package:logos/src/config/theme.dart';
import 'package:logos/src/model/repositories/goal_repository.dart';
import 'package:logos/src/model/repositories/reason_repository.dart';
// import 'package:logos/src/presenter/blocs/observer.dart';
import 'package:logos/src/presenter/blocs/providers/goal_bloc.dart';
import 'package:logos/src/presenter/blocs/providers/reason_bloc.dart';
import 'package:logos/src/presenter/blocs/providers/theme_bloc.dart';

import 'package:logos/src/presenter/views/goals/goal_detail_screen.dart';
import 'package:logos/src/presenter/views/goals/goal_edit_screen.dart';
import 'package:logos/src/presenter/views/goals/goal_reason_screen.dart';
import 'package:logos/src/presenter/views/main/main_screen.dart';

//==============================================================================
Future<void> main(List<String> args) async {
  // Bloc.observer = MyBlocObserver();
  // WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('ko_KR', null).then((_) => runApp(const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GoalRepository>(
          create: (context) => GoalRepository(),
        ),
        RepositoryProvider<ReasonRepository>(
          create: (context) => ReasonRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
              create: (_) => ThemeBloc(Get.isPlatformDarkMode)),
          BlocProvider<GoalBloc>(
            create: (context) => GoalBloc(
              context.read<GoalRepository>(),
            ),
          ),
          BlocProvider<ReasonBloc>(
            create: (context) => ReasonBloc(
              context.read<ReasonRepository>(),
            ),
          ),
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'LEADU',
          theme: msLightTheme,
          darkTheme: msDarkTheme,
          getPages: [
            GetPage(
              name: GetRouter.home,
              page: () => const MainScreen(),
              transition: trans.Transition.fade,
            ),
            GetPage(
              name: "${GetRouter.goalDetail}/:id",
              page: () {
                return GoalDetailScreen(goal: Get.arguments);
              },
              transition: trans.Transition.fade,
              transitionDuration: const Duration(milliseconds: 500),
            ),
            GetPage(
              name: "${GetRouter.goalReason}/:id",
              page: () {
                return GoalReasonScreen(goal: Get.arguments);
              },
              transition: trans.Transition.fade,
              transitionDuration: const Duration(milliseconds: 500),
            ),
            GetPage(
              name: GetRouter.goalEdit,
              page: () {
                return GoalEditScreen(goal: Get.arguments);
              },
              transition: trans.Transition.zoom,
            ),
          ],
        ),
      ),
    );
  }
}
