import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpgenerator/components/CustomHeader/custom_header.dart';
import 'package:hpgenerator/components/CustomBody/custom_body.dart';
import 'package:hpgenerator/util/jl.dart';

class ConfundusPage extends StatefulWidget {
  const ConfundusPage({super.key});

  @override
  State<ConfundusPage> createState() => _ConfundusPageState();
}

class _ConfundusPageState extends State<ConfundusPage> {
  final TextEditingController _frasesOriginaisController =
      TextEditingController();
  List<String> _listaFrasesProntas = [];
  bool _isResultadoVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 216, 217, 1),
      body: SingleChildScrollView(
          child: Column(
        children: [
          const CustomHeader(
            title: "Confundus",
            subtitle: "Informe abaixo as frases desejadas",
            isImplementsAppbar: true,
          ),
          CustomBody(
            child: Column(
              children: [
                Visibility(
                  visible: !_isResultadoVisivel,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _frasesOriginaisController,
                        minLines: 5,
                        maxLines: 500,
                        style: const TextStyle(fontSize: 12),
                        decoration: InputDecoration(
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          hintStyle: const TextStyle(fontSize: 12),
                          label: const Text(
                            "Frases do Confundus",
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(70, 49, 92, 1)),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: JL.kDefaultPadding,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(70, 49, 92, 1)),
                        ),
                        onPressed: () {
                          gerarConfundus();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.save,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Gerar Confundus",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  letterSpacing: 0.5),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Visibility(
                  visible: _isResultadoVisivel,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Confundus Gerados",
                            style: TextStyle(
                                fontSize: 15,
                                letterSpacing: 0.5,
                                fontWeight: FontWeight.bold,
                                color: Color.fromRGBO(70, 49, 92, 1)),
                          ),
                          IconButton(
                            iconSize: 20,
                            onPressed: () async {
                              Clipboard.setData(ClipboardData(
                                  text: _listaFrasesProntas.join("\n\n")));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Frases copiadas com sucesso!'),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.copy_all,
                              size: 20,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        itemCount: _listaFrasesProntas.length,
                        itemBuilder: (context, index) {
                          return Text("${_listaFrasesProntas[index]}\n");
                        },
                      ),
                      SizedBox(
                        height: JL.kDefaultPadding * 2,
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(70, 49, 92, 1)),
                        ),
                        onPressed: () {
                          gerarConfundus();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.repeat,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Tentar Novamente",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  letterSpacing: 0.5),
                            )
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color.fromRGBO(141, 118, 154, 1)),
                        ),
                        onPressed: () {
                          setState(() {
                            _isResultadoVisivel = false;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Voltar",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  letterSpacing: 0.5),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }

  void gerarConfundus() {
    JL.showLoading(context);

    if (_frasesOriginaisController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma frase informada'),
        ),
      );
      JL.hideLoading(context);
    } else {
      List<String> listaFrasesOriginais =
          _frasesOriginaisController.text.split("\n");

      List<String> listaFrasesConfundus = [];

      for (String fraseOriginal in listaFrasesOriginais) {
        List<String> listaPalavras = fraseOriginal.split(" ");
        listaPalavras.shuffle();

        listaFrasesConfundus.add(listaPalavras.join(" - "));
      }

      setState(() {
        _isResultadoVisivel = true;
        _listaFrasesProntas = listaFrasesConfundus;
      });
      JL.hideLoading(context);
    }
  }
}
