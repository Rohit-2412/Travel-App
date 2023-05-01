import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/cubit/app_cubit_states.dart';
import 'package:my_first_app/cubit/app_cubits.dart';
import 'package:my_first_app/pages/welcome_page.dart';

import '../pages/detail_page.dart';
import '../pages/navpages/main_page.dart';

class AppCubitLogics extends StatefulWidget {
  const AppCubitLogics({super.key});

  @override
  State<AppCubitLogics> createState() => _AppCubitLogicsState();
}

class _AppCubitLogicsState extends State<AppCubitLogics> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<AppCubits, CubitStates>(builder: (context, state) {
        // welcome state
        if (state is WelcomeState) {
          return const WelcomePage();
        }
        // loading state
        else if (state is LoadingState) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        // loaded state
        else if (state is LoadedState) {
          return const MainPage();
        }
        // detail state
        else if (state is DetailState) {
          return const DetailPage();
        }
        // otherwise
        else {
          return Container();
        }
      }),
    );
  }
}
