import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/add_data.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/My%20Widget/take_data.dart';

class PokemonDetail extends StatefulWidget {
  final PokeModel pokedetail;
  const PokemonDetail({Key?key, required this.pokedetail}): super(key: key);

  @override
  State<PokemonDetail> createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  late Future<List<elementModel>> elementimage;
  List<elementModel> _elementimage=[];
  late Future<String?> userName;
  String username = '';
  late Future<String?> userEmail;
  String useremail = '';



  @override
  void initState() {
    super.initState();
    elementimage=getElement();
    elementimage.then((value) {
      setState(() {
        _elementimage=value;
      });
    });

    userName = takeData('name');
    userName.then((value){
      setState(() {
        username = value!;
      });
    });

    userEmail = takeData('email');
    userEmail.then((value){
      setState(() {
        useremail = value!;
      });
    });


  }

  int getcolor(String data){
    for(var i in _elementimage){
      if(i.name==data){
        return int.parse(i.color.toString());
      }
    }
    return 0;
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return overallBG(
      child: Scaffold(
        // nama pokemon di appbar
        backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text( widget.pokedetail.name, style: const TextStyle(color: Colors.black),),
            centerTitle: true,
            iconTheme: const IconThemeData(
              color: Colors.black, //change your color here
            ),
          ),
          body: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(

                    // element1

                    width: 90,
                    height: 30,
                    decoration: BoxDecoration(
                        color: Color(getcolor(widget.pokedetail.element1)),
                        borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.pokedetail.element1,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  // element2
                  if (widget.pokedetail.element2?.toLowerCase() != 'null') ...[
                    const SizedBox(width: 20),
                    Container(
                      width: 90,
                      height: 30,
                      decoration: BoxDecoration(
                          color: Color(getcolor(widget.pokedetail.element2)),
                          borderRadius: BorderRadius.circular(20)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.pokedetail.element2,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ]
                ],
              ),
              SizedBox(
                height: height * 0.02,
              ),
              // gambar pokemon
              Container(
                width: width * 0.6,
                height: width * 0.6,
                child: Image.network(
                  widget.pokedetail.image_link,
                  height: 100,
                  width: 100,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Container(
                  width: 300,
                  height: 170,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                        children: [
                      // description
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 20),
                              child: Text( widget.pokedetail.desc,style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
                            )
                          ),
                        ]
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.04,
              ),

                // pokemon Price
                Text(
                  'Price : \$${widget.pokedetail.price}',
                  style: const TextStyle(fontSize: 20),
                ),

              SizedBox(
                height: height * 0.04,
              ),
                GestureDetector(
                  child: Container(
                    width: 250,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.yellow[700],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag_outlined, size: 30),
                        SizedBox(width: width*0.03,),
                        Text("BUY", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500,)),
                        SizedBox(width: width*0.03,)
                      ],
                    )
                  ),
                  onTap: () {
                      postTransactionToFirestore(username, useremail, widget.pokedetail.name, widget.pokedetail.id, widget.pokedetail.image_link, widget.pokedetail.price);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${widget.pokedetail.name} transaction Success!.', style: TextStyle(color: Colors.black),),
                          backgroundColor: Colors.white,
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                  },
                ),
            ],
          ))
    );
  }
}
