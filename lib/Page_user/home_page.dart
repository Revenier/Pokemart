import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/elementButton.dart';
import 'package:frontend/My%20Widget/take_data.dart';
import 'package:frontend/Page_user/ElementPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<elementModel>> elementimage;
  List<elementModel> _elementimage=[];
  late Future<List<PokeModel>> pokeList;
  List<PokeModel> _pokeList = [];
  List<PokeModel> dataList = [];

  @override
  void initState() {
    super.initState();
    elementimage=getElement();
    elementimage.then((value) {
      setState(() {
        _elementimage = value;
      });
    });

    pokeList=getAllPokemon();
    pokeList.then((value){
      setState(() {
        _pokeList=value;
      });
    });

  }

  void FilterPokeByElement(String values){
    List<PokeModel> searchList = _pokeList.where((poke){
      return poke.element1.toLowerCase().contains(values.toLowerCase()) ||
      poke.element2.toLowerCase().contains(values.toLowerCase());
    }).toList();
    setState(() {
      dataList=searchList;
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("HOME", style: TextStyle(color: Colors.black),),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          SizedBox(height: height*0.01,),

          // --> "ELEMENT" TEXT <--
          Container(
            margin: EdgeInsets.only(
                top: height * 0.015, left: width * 0.15, right: width * 0.15
            ),
            width: width * 0.9,
            height: height * 0.05,
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
                color: Colors.blue[400],
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(20)
            ),
              child: Padding(
              padding: EdgeInsets.only(top: height * 0.01),
                child: Column(
                  children: const [
                  Text(
                    "ELEMENT",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            )
          ),

          SafeArea(
            // --> Element button box <--
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: width * 1.5,
                height: height * 0.68,
                alignment: Alignment.bottomCenter,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(20),
                ),

                // --> Element button <--
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: width/(width*0.3),
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 15
                        ),
                      itemCount: _elementimage.length,
                      itemBuilder: (context, index) {
                          var data = _elementimage[index];
                        return Column(
                          children: [
                            ElementButton(
                                onTap: () {
                                  FilterPokeByElement(data.name);
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          ElementPage(
                                            filterpoke: dataList,
                                            element: data.name,
                                          )
                                      )
                                  );
                                },
                                textColor: data.color,
                                Text_on_button: data.name
                            )
                          ],
                        );
                      }
                    ),
                  )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
