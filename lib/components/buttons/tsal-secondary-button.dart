import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../common/typedefs.dart';

class TSALSecondaryButton extends StatefulWidget {
  final Widget label;
  final FutureOrVoidCallback onTap;
  final ExceptionCallback onException;
  final Icon icon;

  const TSALSecondaryButton({
    @required this.onTap,
    @required this.label,
    this.icon,
    this.onException,
  });

  @override
  _TSALSecondaryButtonState createState() => _TSALSecondaryButtonState();
}

class _TSALSecondaryButtonState extends State<TSALSecondaryButton> {
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return widget.icon != null
        ? OutlinedButton.icon(
            label: !isBusy ? widget.label : _buildSpinner(theme),
            icon: !isBusy ? widget.icon : null,
            onPressed: widget.onTap != null ? _onTapInternal : null,
          )
        : OutlinedButton(
            child: !isBusy ? widget.label : _buildSpinner(theme),
            onPressed: widget.onTap != null ? _onTapInternal : null,
          );
  }

  Widget _buildSpinner(ThemeData theme) {
    return SpinKitRing(
      color: theme.colorScheme.onSurface,
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
