import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:tsal_etaleert/common/extensions/build-context.extensions.dart';

class TSALCircleLoadingIndicator extends StatelessWidget {
  const TSALCircleLoadingIndicator({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SpinKitRing(
      color: context.theme.colorScheme.onBackground.withOpacity(0.25),
      lineWidth: 2,
      size: context.textTheme.button.fontSize ?? 14,
    );
  }
}
