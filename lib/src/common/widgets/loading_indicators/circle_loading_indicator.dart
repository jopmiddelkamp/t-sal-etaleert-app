import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../extensions/build_context_extensions.dart';

class TSALCircleLoadingIndicator extends StatelessWidget {
  final double size;

  const TSALCircleLoadingIndicator({
    Key? key,
    this.size = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitRing(
      color: context.theme.colorScheme.onBackground.withOpacity(0.25),
      lineWidth: size / 15,
      size: size,
    );
  }
}
