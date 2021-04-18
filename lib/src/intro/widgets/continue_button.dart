import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/widgets/buttons/tsal_primary_button.dart';
import '../bloc/intro_bloc.dart';

class ContinueButton extends StatelessWidget {
  const ContinueButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final introBloc = context.blocProvider<IntroBloc>();
    return TSALPrimaryButton(
      label: const Text('Ga verder'),
      onTap: introBloc.accept,
    );
  }
}
