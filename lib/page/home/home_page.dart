import 'package:flutter/material.dart';
import 'package:hpgenerator/components/CustomHeader/custom_header.dart';
import 'package:hpgenerator/model/tipo_gerador.dart';
import 'package:hpgenerator/page/anagrama/anagrama_page.dart';
import 'package:hpgenerator/page/bingo/bingo_page.dart';
import 'package:hpgenerator/page/confundus/confundus_page.dart';
import 'package:hpgenerator/page/embaralhador/embaralhador_page.dart';
import 'package:hpgenerator/page/home/components/geradores_jogos.dart';
import 'package:hpgenerator/util/jl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final TextEditingController _searchController = TextEditingController();
  List<TipoGerador> _listaTipoGerador = [];
  List<TipoGerador> _listaTipoGeradorBkp = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    popularGeradores();
  }

  void popularGeradores() {
    _listaTipoGeradorBkp.add(
      TipoGerador(
        title: "Anagrama",
        subtitle: "Clique aqui para acessar",
        icon: Icons.interests,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnagramaPage()),
          );
        },
      ),
    );

   _listaTipoGeradorBkp.add(
      TipoGerador(
          icon: Icons.compare_arrows,
          title: "Confundus",
          subtitle: "Clique aqui para acessar",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ConfundusPage()),
            );
          }),
    );

    _listaTipoGeradorBkp.add(
      TipoGerador(
          icon: Icons.shuffle,
          title: "Embaralhador",
          subtitle: "Clique aqui para acessar",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const EmabaralhadorPage()),
            );
          }),
    );

     _listaTipoGeradorBkp.add(
      TipoGerador(
          icon: Icons.numbers,
          title: "Bingo",
          subtitle: "Clique aqui para acessar",
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const BingoPage()),
            );
          }),
    );

    _listaTipoGerador.addAll(_listaTipoGeradorBkp);

    setState(() {
      _isLoading = false;
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color.fromRGBO(217, 216, 217, 1),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomHeader(
              title: "RPG - Instituto Lumos de Magia",
              subtitle: "Crie de maneira rápida e eficaz os seus jogos",
              isImplementsAppbar: false,
              controller: _searchController,
              callbackSearch: () {
                filtrarSearch();
              },
            ),
            GeradoresJogos(
              listaTipoGerador: _listaTipoGerador,
            ),
            SizedBox(height: JL.kDefaultPadding ),
            const Text("Versão 1.0.0 desenvolvida por", style: TextStyle(fontSize: 10),),
            const SizedBox(height: 4),
            const Text("João Victor Larger", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            SizedBox(height: JL.kDefaultPadding ),
          ],
        ),
      ),
    );
  }
  
  void filtrarSearch() {

    _listaTipoGerador = [];

    if (_searchController.text.isNotEmpty) {

      for (TipoGerador tipoGerador in _listaTipoGeradorBkp) {

        if (tipoGerador.title!.toLowerCase().contains(_searchController.text.trim().toLowerCase())) {
          _listaTipoGerador.add(tipoGerador);
        }

      }

    } else {
      _listaTipoGerador.addAll(_listaTipoGeradorBkp);
    }

    setState(() {
      
    });

  }
  
}