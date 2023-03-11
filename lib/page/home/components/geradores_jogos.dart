import 'package:flutter/material.dart';
import 'package:hpgenerator/model/tipo_gerador.dart';
import 'package:hpgenerator/page/anagrama/anagrama_page.dart';
import 'package:hpgenerator/page/confundus/confundus_page.dart';
import 'package:hpgenerator/page/home/components/card_gerador_jogo.dart';
import 'package:hpgenerator/util/jl.dart';

class GeradoresJogos extends StatefulWidget {
  const GeradoresJogos({super.key, required this.listaTipoGerador,});
  final List<TipoGerador> listaTipoGerador ;

  @override
  State<GeradoresJogos> createState() => _GeradoresJogosState();
}

class _GeradoresJogosState extends State<GeradoresJogos> {

  @override
  Widget build(BuildContext context) {
    return Column(
            children: [
              ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                itemCount: widget.listaTipoGerador.length,
                itemBuilder: (context, index) {
                  return index % 2 == 0
                      ? Row(
                          children: [
                            SizedBox(
                              width: JL.kDefaultPadding,
                            ),
                            CardGeradorJogo(
                              tipoGerador: widget.listaTipoGerador[index],
                            ),
                            SizedBox(
                              width: JL.kDefaultPadding,
                            ),
                            (index + 1 <= widget.listaTipoGerador.length - 1
                                ? CardGeradorJogo(
                                    tipoGerador: widget.listaTipoGerador[index + 1],
                                  )
                                : const SizedBox())
                          ],
                        )
                      : const SizedBox();
                },
              )
            ],
          );
  }
}
