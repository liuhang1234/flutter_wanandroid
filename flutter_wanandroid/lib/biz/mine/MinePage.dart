import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  State<MinePage> createState() {
    return _MineStatePage();
  }
}

class _MineStatePage extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('我的'),
    );
  }
}
