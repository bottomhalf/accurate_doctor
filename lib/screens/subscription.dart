import '../widget/common/bottom_navigation.dart';
import '../widget/common/page_appbar.dart';
import 'package:flutter/material.dart';

class Subscription extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PageAppBar(
        pageTitle: 'Subscription',
      ),
      body: Center(
        child: Container(
          child: Text('Subscription'),
        ),
      ),
      bottomNavigationBar: BottomNavigation(2),
    );
  }
}
