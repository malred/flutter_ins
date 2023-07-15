import 'package:flutter/material.dart';
import 'package:instagram_flutter/providers/user_provider.dart'; 
import 'package:instagram_flutter/utils/global_variables.dart';
import 'package:provider/provider.dart';

class ResposiveLayout extends StatefulWidget {
  final Widget webScreenLayout;
  final Widget mobileScreenLayout;

  const ResposiveLayout(
      {Key? key,
      required this.webScreenLayout,
      required this.mobileScreenLayout})
      : super(key: key);

  @override
  State<ResposiveLayout> createState() => _ResposiveLayoutState();
}

class _ResposiveLayoutState extends State<ResposiveLayout> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (constraints.maxWidth > webScreenSize) {
          // web screen
          return widget.webScreenLayout;
        }
        // mobile screen
        return widget.mobileScreenLayout;
      },
    );
  }
}
