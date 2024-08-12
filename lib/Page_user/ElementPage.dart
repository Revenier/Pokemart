import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/take_data.dart';
import 'package:frontend/Page_user/Detail_page.dart';


class ElementPage extends StatefulWidget {
  final String element;
  final List<PokeModel> filterpoke;
  const ElementPage({Key?key, required this.element, required this.filterpoke}): super(key: key);

  @override
  State<ElementPage> createState() => _ElementPageState();
}

class _ElementPageState extends State<ElementPage> {
  late Future<List<elementModel>> elementimage;
  List<elementModel> _elementimage=[];

  @override
  void initState() {
    super.initState();
    elementimage=getElement();
    elementimage.then((value) {
      setState(() {
        _elementimage=value;
      });
    });
  }

String getlogo(String data){
    for(var i in _elementimage){
      if(i.name==data){
        return i.image_link;
      }
    }
    return 'null';
}

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.element, style: TextStyle(color: Colors.black),),
        centerTitle: true,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
            top: 20.0, left: 15.0, right: 15.0, bottom: 15.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: width / (width * 1.25),
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemCount: widget.filterpoke.length,
          itemBuilder: (context, index) {
            var data = widget.filterpoke[index];
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => PokemonDetail(pokedetail: data)));
              },
            );
          },
        ),
      ),
    );
  }
}
