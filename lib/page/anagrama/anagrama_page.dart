import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpgenerator/components/CustomBody/custom_body.dart';
import 'package:hpgenerator/components/CustomHeader/custom_header.dart';
import 'package:hpgenerator/util/jl.dart';

class AnagramaPage extends StatefulWidget {
  const AnagramaPage({super.key});

  @override
  State<AnagramaPage> createState() => _AnagramaPageState();
}

class _AnagramaPageState extends State<AnagramaPage> {
  final TextEditingController _palavrasOriginaisController =
      TextEditingController();
  List<String> _listaPalavrasProntas = [];
  bool _isResultadoVisivel = false;
  bool _isIgnorarEspacos = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 216, 217, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(
              title: "Anagrama",
              subtitle: "Informe abaixo as palavras desejadas",
              isImplementsAppbar: true,
            ),
            CustomBody(
              child: Column(
                children: [
                  Visibility(
                    visible: !_isResultadoVisivel,
                    child: Column(
                      children: [
                        SwitchListTile(
                          title: const Text(
                            'Ignorar Espaços?',
                            style: TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(70, 49, 92, 1)),
                          ),
                          value: _isIgnorarEspacos,
                          onChanged: (bool? value) {
                            _isIgnorarEspacos = !_isIgnorarEspacos;
                            setState(() {});
                          },
                        ),
                        SizedBox(
                          height: JL.kDefaultPadding,
                        ),
                        TextFormField(
                          controller: _palavrasOriginaisController,
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
                              "Palavras do Anagrama",
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
                            gerarAnagrama();
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
                                "Gerar Anagrama",
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
                              "Anagramas Gerados",
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
                                    text: _listaPalavrasProntas.join("\n")));
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('Palavras copiadas com sucesso!'),
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
                          itemCount: _listaPalavrasProntas.length,
                          itemBuilder: (context, index) {
                            return Text(_listaPalavrasProntas[index]);
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
                            gerarAnagrama();
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
        ),
      ),
    );
  }

  gerarAnagrama() {
    JL.showLoading(context);

    if (_palavrasOriginaisController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nenhuma palavra informada'),
        ),
      );
      JL.hideLoading(context);
    } else {
      List<String> listaPalavrasOriginais =
          _palavrasOriginaisController.text.split("\n");
      List<String> listaPalavrasAnagramas = [];

      for (String palavraOriginal in listaPalavrasOriginais) {
        if (_isIgnorarEspacos) {
          listaPalavrasAnagramas
              .add(gerarAnagramaIgnorarEspaco(palavraOriginal));
        } else {
          listaPalavrasAnagramas
              .add(gerarAnagramaRespeitandoEspaco(palavraOriginal));
        }
      }

      setState(() {
        _isResultadoVisivel = true;
        _listaPalavrasProntas = listaPalavrasAnagramas;
      });
      JL.hideLoading(context);
    }
  }

  String gerarAnagramaIgnorarEspaco(String palavraOriginal) {
    List<String> listaLetras = palavraOriginal.trim().split("");
    listaLetras.shuffle();

    return listaLetras.join("");
  }

  String gerarAnagramaRespeitandoEspaco(String palavraOriginal) {
    List<String> listaPalavras = palavraOriginal.trim().split(" ");

    String anagrama = "";

    for (String palavra in listaPalavras) {
      List<String> letras = palavra.trim().split("");
      letras.shuffle();

      anagrama += "${letras.join("")} ";
    }

    return anagrama.trim();
  }
}
