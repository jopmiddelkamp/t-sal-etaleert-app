import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/typedefs.dart';

class TSALPrimaryButton extends StatefulWidget {
  final Widget label;
  final FutureOrVoidCallback onTap;
  final ExceptionCallback onException;
  final Icon icon;

  const TSALPrimaryButton({
    @required this.onTap,
    @required this.label,
    this.icon,
    this.onException,
  });

  @override
  _TSALPrimaryButtonState createState() => _TSALPrimaryButtonState();
}

class _TSALPrimaryButtonState extends State<TSALPrimaryButton> {
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return widget.icon != null
        ? ElevatedButton.icon(
            label: !isBusy ? widget.label : _buildSpinner(theme),
            icon: !isBusy ? widget.icon : null,
            onPressed: widget.onTap != null ? _onTapInternal : null,
          )
        : ElevatedButton(
            child: !isBusy ? widget.label : _buildSpinner(theme),
            onPressed: widget.onTap != null ? _onTapInternal : null,
          );
  }

  Widget _buildSpinner(ThemeData theme) {
    return SpinKitRing(
      color: theme.colorScheme.onPrimary,
      lineWidth: 2,
      size: theme.textTheme.button.fontSize ?? 14,
    );
  }

  Future<void> _onTapInternal() async {
    setState(() {
      isBusy = true;
    });
    try {
      await widget.onTap();
    } on Exception catch (e) {
      widget.onException(e);
    }
    setState(() {
      isBusy = false;
    });
  }
}
