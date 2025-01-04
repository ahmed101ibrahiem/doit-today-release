import 'package:doit_today/core/base/bloc/notes_cubit/notes_cubit.dart';
import 'package:doit_today/core/base/bloc/todo_cubit/todo_cubit.dart';
import 'package:doit_today/view/Profile/viewmodel/profile_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BaseBlocProviders {
  static List<BlocProvider> providers(BuildContext context) => [
        BlocProvider<NotesCubit>(
          create: (context) => NotesCubit(),
        ),
        BlocProvider<TodosCubit>(create: (context) => TodosCubit()),
        BlocProvider<ProfileCubit>(
          create: (context) => ProfileCubit(),
        )
      ];
}
