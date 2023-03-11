import 'package:flutter/material.dart';

class TipoGerador {

  String? title;
  String? subtitle;
  IconData? icon;
  Function? onTap;

  TipoGerador({
    this.icon,
    this.onTap,
    this.subtitle,
    this.title,
 } ); 
}