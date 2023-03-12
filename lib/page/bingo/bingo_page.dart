import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hpgenerator/components/CustomBody/custom_body.dart';
import 'package:hpgenerator/components/CustomHeader/custom_header.dart';
import 'package:hpgenerator/model/bingo.dart';
import 'package:hpgenerator/util/jl.dart';

class BingoPage extends StatefulWidget {
  const BingoPage({super.key});

  @override
  State<BingoPage> createState() => _BingoPageState();
}

class _BingoPageState extends State<BingoPage> {

  List<Bingo> _listaBingo = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    popularEGerarBingo();
  }

  void popularEGerarBingo() {

    for (int i = 1; i <= 75; i++) {
      String letra = getLetraPorNumero(i);

      Bingo bingo = Bingo(
        letra: letra,
        numero: i,
      );

      _listaBingo.add(bingo);
    }

    gerarBingo();
  }

  void gerarBingo() {
    setState(() {
      _isLoading = true;
    });
    _listaBingo.shuffle();
    setState(() {
      _isLoading = false;
    });
  }

  String getLetraPorNumero(int i) {

    if (i <= 15) {
      return "B";
    } else if (i <= 30) {
      return "I";
    } else if (i <= 45) {
      return "N";
    } else if (i <= 60) {
      return "G";
    } else {
      return "O";
    }


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(217, 216, 217, 1),
      body: _isLoading ? const Center(
        child: CircularProgressIndicator(),
      ) : SingleChildScrollView(
        child: Column(
          children: [
            const CustomHeader(
              title: "Bingo",
                subtitle: "Confira abaixo os números sorteados",
                isImplementsAppbar: true,
              ),
              CustomBody(child: Column(
                children: [
                  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Bingo",
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
                                    text: montarTextoParaCopiar()));
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
                          itemCount: _listaBingo.length,
                          itemBuilder: (context, index) {
                            Bingo bingo = _listaBingo[index];
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Letra: ${bingo.letra!}"),
                                Text("Número: ${bingo.numero!}"),
                                SizedBox(height: JL.kDefaultPadding)
                              ],
                            );
                          },
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
                            gerarBingo();
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
                                "Gerar Bingo",
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
              ),),
          ]
        )
      )
    );
  }
  
  montarTextoParaCopiar() {

    String texto = "";

    for (Bingo bingo in _listaBingo) {
      texto += "Letra: ${bingo.letra!}\n";
      texto += "Número: ${bingo.numero!}\n\n";
    }

    return texto;
  }
}