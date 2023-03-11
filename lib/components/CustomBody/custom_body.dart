import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hpgenerator/util/jl.dart';

class CustomBody extends StatefulWidget {
  const CustomBody({super.key, required this.child, });

  final Widget child;

  @override
  State<CustomBody> createState() => _CustomBodyState();
}

class _CustomBodyState extends State<CustomBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(JL.kDefaultPadding),
      margin: EdgeInsets.only(left : JL.kDefaultPadding, right : JL.kDefaultPadding, bottom : JL.kDefaultPadding),
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: widget.child,
    );
  }
}