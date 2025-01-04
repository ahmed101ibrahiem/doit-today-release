
import 'package:doit_today/core/base/bloc/generic_cubit/generic_cubit.dart';
import 'package:doit_today/core/resources/my_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomPasswordEye extends StatelessWidget {
  const CustomPasswordEye({
    super.key,
    this.passwordBloc,
    this.color,
  });

  final GenericCubit<bool>? passwordBloc;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: passwordBloc == null,
      child: BlocBuilder<GenericCubit<bool>, GenericState<bool>>(
        bloc: passwordBloc ?? GenericCubit(false),
        builder: (context, state) {
          return IconButton(
            tooltip: 'show password',
            splashColor: MyColors.black,
            icon: Icon(
              state.data ? Icons.visibility_off : Icons.visibility,
              color: color ?? MyColors.black,
              size: 20.r,
            ),
            onPressed: () => passwordBloc!.onUpdateData(!state.data),
          );
        },
      ),
    );
  }
}
