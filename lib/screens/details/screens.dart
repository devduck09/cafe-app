import 'package:CUDI/widgets/etc/cudi_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../config/theme.dart';
import '../../widgets/cart_icons.dart';
import '../../widgets/etc/cudi_widgets.dart';

class AppbarScreen extends StatefulWidget {
  final String title;
  final Column column;
  final bool? padding;
  final CartIcon? cartIcon;
  final String? buttonTitle;
  final void Function()? buttonClick;
  const AppbarScreen({super.key, required this.title, required this.column, this.padding, this.cartIcon, this.buttonTitle, this.buttonClick});

  @override
  State<AppbarScreen> createState() => _AppbarScreenState();
}

class _AppbarScreenState extends State<AppbarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: <Widget>[
            sliverAppBar(context,
                title: widget.title, iconButton: widget.cartIcon),
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(
                  height: MediaQuery.of(context).size.height - 88.h - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
                  child: Column(
                    children: [
                      Padding(
                        padding: widget.padding == null ? pd24h : EdgeInsets.zero,
                        child: widget.column,
                      ),
                      if(widget.buttonClick != null) const Spacer(),
                      if(widget.buttonClick != null) Padding(
                        padding: pd2420247,
                        child: whiteButton('${widget.buttonTitle}', null, widget.buttonClick),
                      )
                    ],
                  ),
                )
              ]),
            ),
            // Add a SliverFillRemaining to fill the remaining space
            // SliverFillRemaining(
            //   hasScrollBody: false,
            //   child: Container(),
            // ),
          ],
        ),
      ),
    );
  }
}