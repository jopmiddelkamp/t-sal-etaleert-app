import 'package:flutter/material.dart';
import 'package:bordered_text/bordered_text.dart';

import '../common/bloc/permissions/barrel.dart';
import '../common/bloc/permissions/permissions_event.dart';
import '../common/extensions/build_context.extensions.dart';
import '../common/ui/font-weight.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/home';

  static MaterialPageRoute route() {
    return MaterialPageRoute(
      builder: (context) => HomePage(),
    );
  }

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    context.blocProvider<PermissionsBloc>().add(PermissionsAskUser());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            Stack(
              children: [
                LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    return Image.asset(
                      'assets/images/intro-header.jpg',
                      fit: BoxFit.cover,
                      width: constraints.maxWidth,
                      height: constraints.maxWidth / 2,
                    );
                  },
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: BorderedText(
                    strokeWidth: 6.0,
                    strokeColor: Colors.black38,
                    child: Text(
                      'Home',
                      style: textTheme.headline6.copyWith(
                        color: Colors.white,
                        fontWeight: TSALFontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(16),
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Home page displayed!'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
