import 'package:flutter/material.dart';
import 'package:hpgenerator/util/jl.dart';

class CustomHeader extends StatelessWidget {
  const CustomHeader({super.key, required this.title, required this.subtitle, this.callbackSearch, required this.isImplementsAppbar, this.controller});

  final String title;
  final String subtitle;
  final Function? callbackSearch;
  final bool isImplementsAppbar;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
         SizedBox(height: callbackSearch != null ? 220 : 180,),
        Container(
          height: callbackSearch != null ? 180 : 160,
          width: double.maxFinite,
          padding: EdgeInsets.all(JL.kDefaultPadding),
          decoration: const BoxDecoration(
            color: Color.fromRGBO(70, 49, 92, 1),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30)
            ),
            
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

               ( callbackSearch == null ? 
              const SizedBox(height: 40,) : 
               const SizedBox(height: 0,)
             ),

             ( isImplementsAppbar ? 
              const SizedBox(height: 10,) : 
               const SizedBox(height: 0,)
             ),
              Text(title, style: JL.titleStyle),
              const SizedBox(height: 5,),
              Text(subtitle, style: JL.subtitleStyle,),
            ],
          ),
        ),
        callbackSearch != null ?
       Container(
          height: 55,
          width: double.maxFinite,
          padding: const EdgeInsets.only(left: 20, right: 10),
          margin: EdgeInsets.only(left: JL.kDefaultPadding, right: JL.kDefaultPadding, top: 145),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(70, 49, 92, 0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                cursorColor: Colors.black,
                style: const TextStyle(fontSize: 12),
                onChanged: (value){
                 callbackSearch!(); 
                },
                controller: controller,
                decoration: const InputDecoration(
                  hintStyle: TextStyle(fontSize: 12),
                  hintText: "Pesquise por algo",
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top: 15),
                  suffixIcon: Icon(Icons.search, color: Color.fromRGBO(70, 49, 92, 0.2), size: 20,),            
                ),
              ),
            ],
          )
        ) : const SizedBox(height: 0,),
        
        isImplementsAppbar ?
        Positioned(          
          child: AppBar(
            backgroundColor: Color.fromRGBO(70, 49, 92, 1),
            elevation: 0,
          )
        ) : const SizedBox(height: 0,), 
      ],
    );
  }

}