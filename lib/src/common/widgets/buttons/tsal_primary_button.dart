import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../dialogs/error_dialog.dart';
import '../../typedefs.dart';

class TSALPrimaryButton extends StatefulWidget {
  final Widget label;
  final FutureOrVoidCallback? onTap;
  final ExceptionCallback? onException;
  final Icon? icon;

  const TSALPrimaryButton({
    required this.onTap,
    required this.label,
    this.icon,
    this.onException,
  });

  @override
  _TSALPrimaryButtonState createState() => _TSALPrimaryButtonState();
}

class _TSALPrimaryButtonState extends State<TSALPrimaryButton> {
  bool busy = false;
  bool disposed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return !busy && widget.icon != null
        ? ElevatedButton.icon(
            label: !busy ? widget.label : _buildSpinner(theme),
            icon: widget.icon!,
            onPressed: widget.onTap != null ? _onTapInternal : null,
          )
        : ElevatedButton(
            child: !busy ? widget.label : _buildSpinner(theme),
            onPressed: widget.onTap != null ? _onTapInternal : null,
          );
  }

  Widget _buildSpinner(ThemeData theme) {
    return SpinKitRing(
      color: theme.colorScheme.onPrimary,
      lineWidth: 2,
      size: theme.textTheme.button!.fontSize ?? 14,
    );
  }

  Future<void> _onTapInternal() async {
    if (widget.onTap == null) {
      return;
    }
    setState(() {
      busy = true;
    });
    try {
      await widget.onTap!();
    } on Exception catch (e) {
      debugPrint(e.toString());
      if (widget.onException != null) {
        widget.onException!(e);
      } else {
        showErrorDialog(
          context,
          title: 'Onbekende foutmelding',
          message:
              'Er is een onverwachte foutmelding opgetreden. ${e.toString()}',
        );
      }
    }
    if (!disposed) {
      setState(() {
        busy = false;
      });
    }
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }
}
