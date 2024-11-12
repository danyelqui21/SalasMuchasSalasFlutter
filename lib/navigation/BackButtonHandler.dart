import 'package:flutter/material.dart';

class BackButtonHandler extends StatelessWidget {
  final Widget child;

  BackButtonHandler({required this.child});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        {
          if (didPop) {
            return;
          }
          final shouldPop = await _showBackDialog(context) ?? false;
          if (context.mounted && shouldPop == true) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        // Your scaffold code
        body: Text('Yes'),
      ),
    );
  }
}

Future<bool?> _showBackDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text(
          'Your progress will be lost if you leave now. Do you really want to stop exercising?',
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Keep Going'),
            onPressed: () {
              Navigator.pop(context, false);
            },
          ),
          TextButton(
            child: Text(
              'Leave',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            onPressed: () {
              Navigator.pop(context, true);
            },
          ),
        ],
      );
    },
  );
}