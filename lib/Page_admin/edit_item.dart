import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/MyButton.dart';
import 'package:frontend/My%20Widget/MyTextField.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/My%20Widget/change_data.dart';
import 'package:frontend/My%20Widget/delete_data.dart';
import 'package:frontend/My%20Widget/take_data.dart';
import 'package:frontend/Page_admin/profile_admin.dart';
import 'package:frontend/page/search.dart';

class Edit_Item extends StatefulWidget {
  final PokeModel detailPoke;
  const Edit_Item({Key?key,  required this.detailPoke}): super(key: key);

  @override
  State<Edit_Item> createState() => _Edit_ItemState();
}

class _Edit_ItemState extends State<Edit_Item> {
  String? selectedValue1;
  String? selectedValue2;
  final _formKey = GlobalKey<FormState>();
  TextEditingController idController = TextEditingController();
  TextEditingController pokeNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  List<elementModel> _elementimage=[];
  List<String> elementList1 = [];
  List<String> elementList2 = [];


  String? validateId(String? value) {
    if (value == null || value.isEmpty) {
      return 'ID must be filled!';
    }
    if (value?.length != 4) {
      return 'ID must be 4 digits';
    } else if (int.tryParse(value!) == null) {
      return 'ID must be a valid number';
    }
    return null;
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name must be filled!';
    }
    return null;
  }

  String? validateDesc(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description must be filled!';
    }
    return null;
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) {
      return 'Price must be filled!';
    }
    if (double.tryParse(value) == null) {
      return 'Price must be a valid number';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    insertController();
    getElement().then((value) {
      setState(() {
        _elementimage = value;
      });
      addData();
      elementList2.add('null');
    });
  }
  void insertController(){
    idController.text=widget.detailPoke.id.padLeft(4,'0');
    pokeNameController.text = widget.detailPoke.name;
    descriptionController.text = widget.detailPoke.desc;
    priceController.text = widget.detailPoke.price.toString();
    selectedValue1 = widget.detailPoke.element1;
    selectedValue2 = widget.detailPoke.element2;
  }
  void addData(){
    for(var i in _elementimage){
      elementList1.add(i.name);
    }
    for(var i in _elementimage){
      elementList2.add(i.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return profileBGWidget(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text("EDIT ITEM", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Color(0xFFDA2F2F),
              onPressed: () {
                // APUS POKEMON --------
                print("pokemon deleted!");
                String ids=widget.detailPoke.id;
                print(ids);
                deletePoke(ids);
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(
                          'Pokemon has been deleted!', style: TextStyle(color: Colors.black),),
                      backgroundColor: Colors.white,
                      behavior: SnackBarBehavior.floating,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )
                );
                Navigator.push(context, MaterialPageRoute(builder: (context)=> SearchPage()));
              },
            ),
          ],
        ),

        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [

                  // --> Pokemon ID
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width*0.01),
                        // color: Colors.amber,
                        child: Text("POKEMON ID", style: TextStyle(fontSize: 15, color: Colors.black87),),
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.01),

                  MyTextField(
                    controller: idController,
                    TextHint: '0000',
                    secureText: false,
                    line: 1,
                    unlockText: false,
                    validator: validateId,
                  ),

                  SizedBox(height: height*0.04,),

                  // --> Pokemon Name -----------------------------------------------------------
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width*0.01),
                        // color: Colors.amber,
                        child: Text("POKEMON NAME", style: TextStyle(fontSize: 15, color: Colors.black87),),
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.01),

                  MyTextField(
                    controller: pokeNameController,
                    TextHint: 'Pokemon',
                    secureText: false,
                    line: 1,
                    unlockText: true,
                    validator: validateName,
                  ),

                  SizedBox(height: height*0.04,),

                  // // --> Element 1 & 2 -----------------------------------------------------------
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,30,0),
                                child: Text("FIRST ELEMENT", style: TextStyle(fontSize: 15, color: Colors.black87),),
                              ),
                            ),
                            SizedBox(height: height*0.01),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white, borderRadius: BorderRadius.circular(10)
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: elementList1
                                        .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    value: selectedValue1,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedValue1 = value;
                                      });
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      height: 40,
                                      width: 200,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 50,
                                    ),
                                    dropdownStyleData: DropdownStyleData(maxHeight: 250,),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                      SizedBox(width: width*0.04,),
                      Expanded(
                        child: Column(

                          children: [
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0,0,30,0),
                                child: Text("SECOND ELEMENT", style: TextStyle(fontSize: 15, color: Colors.black87),),
                              ),
                            ),
                            SizedBox(height: height*0.01,),
                            Center(
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white, borderRadius: BorderRadius.circular(10)
                                ),
                                child: DropdownButtonHideUnderline(
                                  child: DropdownButton2<String>(
                                    isExpanded: true,
                                    hint: Text(
                                      'Select',
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: elementList2
                                        .map((String item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                        ),
                                      ),
                                    ))
                                        .toList(),
                                    value: selectedValue2,
                                    onChanged: (String? value) {
                                      setState(() {
                                        selectedValue2 = value;
                                      });
                                    },
                                    buttonStyleData: const ButtonStyleData(
                                      padding: EdgeInsets.symmetric(horizontal: 16),
                                      height: 40,
                                      width: 200,
                                    ),
                                    menuItemStyleData: const MenuItemStyleData(
                                      height: 50,
                                    ),
                                    dropdownStyleData: DropdownStyleData(maxHeight: 250,),
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),

                    ],
                  ),
                  SizedBox(height: height*0.02,),

                  //--> Description ------------------------------------------------------------
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width*0.01),
                        // color: Colors.amber,
                        child: Text("DESCRIPTION", style: TextStyle(fontSize: 15, color: Colors.black87),),
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.01),

                  MyTextField(
                    controller: descriptionController,
                    TextHint: '',
                    secureText: false,
                    line: 5,
                    unlockText: true,
                    validator: validateDesc,
                  ),

                  SizedBox(height: height*0.02,),

                  // --> Price ---------------------------------------------------------------------
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: width*0.01),
                        // color: Colors.amber,
                        child: Text("Price", style: TextStyle(fontSize: 15, color: Colors.black87),),
                      ),
                    ],
                  ),
                  SizedBox(height: height*0.01),

                  MyTextField(
                    controller: priceController,
                    TextHint: '10.0',
                    secureText: false,
                    line: 1,
                    unlockText: true,
                    validator: validatePrice,
                  ),

                  SizedBox(height: height*0.02,),

                  SizedBox(height: height*0.02,),
                  MyButton(
                    onTap: () async {
                      if (_formKey.currentState?.validate() ?? false) {
                        String id = widget.detailPoke.id;
                        String name = pokeNameController.text;
                        String description = descriptionController.text;
                        String price = priceController.text;
                        String Element1 =selectedValue1.toString();
                        String Element2 =selectedValue2.toString();

                        updatePoke(id, name, description, Element1, Element2, double.tryParse(price) ?? 0);


                        if (id.isEmpty || name.isEmpty || description.isEmpty ||
                            price.isEmpty) {
                          // ... handle empty fields
                          return;
                        }

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                  'Success! Data saved to Firestore.', style: TextStyle(color: Colors.black),),
                              duration: Duration(seconds: 1),
                              backgroundColor: Colors.white,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
                      }

                    },
                    buttonColor: Colors.blue,
                    Text_on_button: 'DONE',
                    sizeX: 1,

                  ),


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
