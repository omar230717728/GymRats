import 'package:flutter/material.dart';
import 'package:flutter_application_1/core/themes/app_theme.dart';
import 'package:flutter_application_1/feature/cubit/theme_cubit.dart';
import 'package:flutter_application_1/feature/presentation/pages/main_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeCubit()),
       // 🔥 new cubit for tasks
      ],
      child: BlocBuilder<ThemeCubit, ThemeState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'GymRat',
            theme: ThemeManager.getTheme(state.currentTheme),
            home:  MyHomePage(),
          );
        },
      ),
    );
  }
}