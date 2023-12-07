import 'package:flutter/material.dart';
import '../../../widgets/etc/cudi_widgets.dart';

class MyGradeScreen extends StatefulWidget {
  final String title;

  const MyGradeScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<MyGradeScreen> createState() => _MyGradeScreenState();
}

class _MyGradeScreenState extends State<MyGradeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context, title: widget.title),
            SliverList(
              delegate: SliverChildListDelegate([
                noContent(context, 'assets/images/img-emptystate-peparing.png', 186.0, 136.0, '쿠디 등급은 준비 중!', '2024년, 더 편리한 쿠디를 위해 준비중이에요', '준비되면 알림받기')
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
