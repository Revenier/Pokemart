import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/My%20Widget/take_data.dart';
import 'package:frontend/Page_admin/edit_item.dart';
import 'package:frontend/Page_user/Detail_page.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController searchController = TextEditingController();
  late Future<String?> AccountRole;
  String AR = '';
  late Future<List<PokeModel>> allPokemon;
  List<PokeModel> AllPokemon = [];
  late Future<List<elementModel>> elementimage;
  List<elementModel> _elementimage=[];

  @override
  void initState() {
    super.initState();
    allPokemon= getAllPokemon();
    allPokemon.then((value){
      setState(() {
        AllPokemon =value;
      });
    });

    elementimage=getElement();
    elementimage.then((value) {
      setState(() {
        _elementimage=value;
      });
    });

    AccountRole=takeData('role');
    AccountRole.then((value) {
      setState(() {
        AR = value!;
      });
    });
  }

  String getlogo(String data1){
    for(var i in _elementimage){
      if(i.name == data1){
        return i.image_link;
      }
    }
    return 'null';
  }

  String appBarName(){
    if (AR == 'Admin'){
      return 'ALL ITEM';
    } else if (AR == 'User') {
      return 'SEARCH';
    }
    else return '';
  }

  bool backButton(){
    if(AR == 'Admin') return true;
    else return false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return UserBG(
      child: Scaffold(
        backgroundColor: Colors.blue.shade200,
        // backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(appBarName(), style: TextStyle(color: Colors.black),),
          centerTitle: true,
          automaticallyImplyLeading: backButton(),
          iconTheme: IconThemeData(
              color: Colors.black
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: searchController,
                onChanged: (value) async {
                  List<PokeModel> fetchedPokemon = await allPokemon;
                  setState(() {
                    AllPokemon = fetchedPokemon.where((element) {
                      return element.name.toLowerCase().contains(value.toLowerCase())||
                          element.id.toString().contains(value);
                    }).toList();
                  });
                },
                decoration: InputDecoration(
                  fillColor: Colors.white,
                  filled: true,
                  contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  suffixIcon: const Icon(Icons.search),
                  hintText: "Search",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0),
                    borderSide: const BorderSide(),
                  ),
                ),
              ),
              SizedBox(height: height*0.03,),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: width / (width * 1.25),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: AllPokemon.length,
                  itemBuilder: (context, index) {
                    var data = AllPokemon[index];
                    return GestureDetector(
                      child: Container(
                        height: width * 0.35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: const Offset(5, 5),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: height * 0.01),
                            Row(
                              children: [
                                SizedBox(
                                  height: height * 0.02,
                                  width: width * 0.03,
                                ),
                                Text(
                                  data.id.padLeft(4, '0'),
                                  style: const TextStyle(fontSize: 14),
                                ),

                                if (data.element2 == 'null') ...[
                                  SizedBox(width: width * 0.095,),
                                  Image.network(getlogo(data.element1), width:width* 0.06,height: width*0.06,)

                                ],
                                if (data.element2 != 'null') ...[
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  Image.network(getlogo(data.element1), width:width* 0.06,height: width*0.06,),
                                  Image.network(getlogo(data.element2), width:width* 0.06,height: width*0.06)
                                ]
                              ],
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            Image.network(
                              data.image_link,
                              height: width * 0.2,
                              width: width * 0.2,
                            ),
                            SizedBox(
                              height: height * 0.005,
                            ),
                            AutoSizeText(
                              data.name,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        if(AR == 'Admin'){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Edit_Item(detailPoke: data)));
                        }
                        if (AR == 'User'){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(pokedetail: data)));
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
