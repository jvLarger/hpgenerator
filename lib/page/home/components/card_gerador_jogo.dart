import 'package:flutter/material.dart';
import 'package:hpgenerator/model/tipo_gerador.dart';
import 'package:hpgenerator/util/jl.dart';

class CardGeradorJogo extends StatelessWidget {
  const CardGeradorJogo({super.key, required this.tipoGerador});

  final TipoGerador tipoGerador;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return  GestureDetector(
      onTap: () {
        tipoGerador.onTap!();
      },
      child: Container(
        height: 150,
        margin: EdgeInsets.only(bottom: JL.kDefaultPadding),
        width: (size.width - 3 * JL.kDefaultPadding) / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(tipoGerador.icon, size: 40, color: const Color.fromRGBO(70, 49, 92, 1),),
            const SizedBox(height: 10,),
            Text(tipoGerador.title!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5,  color: Color.fromRGBO(70, 49, 92, 1)),),
            const SizedBox(height: 5,),
            Text(tipoGerador.subtitle!, style: const TextStyle(fontSize: 11,  color: Color.fromRGBO(70, 49, 92, 0.7)),),
          ],
        ),
      ),
    );
  }
}