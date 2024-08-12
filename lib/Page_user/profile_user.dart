import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/take_data.dart';
import 'package:frontend/Page_user/history_page.dart';
import 'package:frontend/page/edit_profile_page.dart';
import 'package:frontend/page/login_page.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MainProfileUser extends StatefulWidget {
  const MainProfileUser({super.key});

  @override
  State<MainProfileUser> createState() => _MainProfileUserState();
}

class _MainProfileUserState extends State<MainProfileUser> {
  bool isSwitched = false;
  late Future<String?> getName, getEmail;
  String _getName='';
  String _getEmail='';

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _roleController = TextEditingController();

  late Future<List<transactionModel>> transactionList;
  List<transactionModel> _transactionList = [];
  List<transactionModel> userTransaction = [];



  @override
  void initState() {
    super.initState();
    fetchData();
    getName = takeData('name');
    getName.then((value) {
      setState(() {
        _getName = value!;
      });
    });

    getEmail = takeData('email');
    getEmail.then((value) {
      setState(() {
        _getEmail = value!;
      });
    });

    transactionList = getTransaction();
    transactionList.then((value) {
      setState(() {
        _transactionList = value;
      });
    });
  }

  Future<void> fetchData() async {
    _nameController.text = await takeData('name') ?? '';
    _emailController.text = await takeData('email') ?? '';
    _passwordController.text = await takeData('pw') ?? '';
    _roleController.text = await takeData('role') ?? '';
  }

  Future<void> updateData() async {
    await fetchData();
  }

  void FilterUserHistory(String values){
    List<transactionModel> searchList = _transactionList.where((transaction){
      return transaction.userEmail.contains(values);
    }).toList();
    setState(() {
      userTransaction=searchList;
    });
  }


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: Colors.blue.shade300,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("PROFILE", style: TextStyle(color: Colors.black),),
          centerTitle: true,
          automaticallyImplyLeading: false,
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () async {
                String newName = _nameController.text;
                await updateData();
                setState(() {
                  _getName = _nameController.text;
                });
              },
            ),
          ],
        ),
        body: Stack(
            children: [
              Column(
                  children: [
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(top: height * 0.03),
                            width: width* 0.27,
                            height: height* 0.27,
                            alignment: Alignment.center,
                            decoration:  BoxDecoration(
                                color:Colors.blue.shade100,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(200)
                            )
                        )
                    )
                  ]
              ),
              Center(
                  child: Container(
                      margin: EdgeInsets.only(bottom: height* 0.05, left: width* 0.05, right: width* 0.05, top: height * 0.10,
                      ),
                      width: width* 0.9,
                      height: height* 0.7,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                          color:Colors.blue.shade100,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(40)
                      ),
                  )
              ),
              Column(
                  children: [
                    Center(
                        child: Container(
                            margin: EdgeInsets.only(top: height * 0.05),
                            width: width* 0.2,
                            height: height* 0.1,
                            alignment: Alignment.bottomCenter,
                            
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(100)
                            ),
                            child: Image.asset('asset/Logo/pokeball_bluewhite.png'),
                        )
                    )
                  ]
              ),
              Container(
                margin: EdgeInsets.only(top: height*0.15,),
                height: height*0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(_getName, style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),maxLines: 1),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: height*0.18),
                height: height*0.06,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AutoSizeText(_getEmail, style: TextStyle(color: Colors.black, fontSize: 15 ))
                  ],
                )
              ),
              
              Padding(
                  padding: EdgeInsets.only(top: height* 0.25,left: width*0.122),
                  child: Container(
                    width: width*0.2,
                    height: height*0.03,
                    child: Row(
                     children: [
                       AutoSizeText("General", style: TextStyle(fontSize: 15),),
                     ],
                    ),
                  )
              ),
              Column(
                  children: [
                    GestureDetector(
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: height* 0.29),
                              width: width* 0.792,
                              height: height* 0.067,
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(5, 5)
                                    )
                                  ]
                              ),
                              child: Row(
                                  children:  [
                                    SizedBox(width: width*0.052),
                                    Container(child: FittedBox(child: Icon(Icons.checklist,size: 35))),
                                    SizedBox(width:width* 0.051,),
                                    AutoSizeText("History",style: TextStyle(fontSize: 14)),
                                  ]
                              )
                          )
                      ),
                      onTap: (){
                        FilterUserHistory(_getEmail);
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> HistoryPage(transactionList: userTransaction)));
                      },
                    )
                  ]
              ),

              Column(
                  children: [
                    GestureDetector(
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: height* 0.38),
                              width: width* 0.792,
                              height: height* 0.067,
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(5, 5)
                                    )
                                  ]
                              ),
                              child: Row(
                                  children:  [
                                    SizedBox(width: width*0.052),
                                    Container(child: FittedBox(child: Icon(Icons.person_outline,size: 35))),
                                    SizedBox(width:width* 0.051,),
                                     AutoSizeText("Edit Profile",style: TextStyle(fontSize: 14)),
                                  ]
                              )
                          )
                      ),
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=> const EditProfile()));
                      },
                    )
                  ]
              ),
              Column(
                  children: [
                    GestureDetector(
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: height* 0.47),
                              width: width* 0.792,
                              height: height* 0.067,
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(5, 5)
                                    )
                                  ]
                              ),
                              child: Row(
                                  children:  [
                                    SizedBox(width: width*0.052),
                                    Container(child: FittedBox(child: Icon(Icons.notifications_none_outlined,size: 35))),
                                    SizedBox(width:width* 0.051,),
                                    AutoSizeText("Notification",style: TextStyle(fontSize: 14)),
                                    SizedBox(width: width* 0.2),
                                    Switch(value: isSwitched, onChanged: (value){
                                      setState(() {
                                    isSwitched = value;
                                  });
                                    })
                                  ]
                              )
                          )
                      ),
                    ),
                  ]
              ),
              Column(
                  children: [
                    GestureDetector(
                      child: Center(
                          child: Container(
                              margin: EdgeInsets.only(top: height* 0.56),
                              width: width* 0.792,
                              height: height* 0.067,
                              decoration:  BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.rectangle,
                                  borderRadius: BorderRadius.circular(20.0),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        spreadRadius: 1,
                                        blurRadius: 2,
                                        offset: const Offset(5, 5)
                                    )
                                  ]
                              ),
                              child: Row(
                                  children:[
                                    SizedBox(width: width*0.052),
                                    Container(child: FittedBox(child: Icon(Icons.logout_outlined,size: 35))),
                                    SizedBox(width:width* 0.051,),
                                    AutoSizeText("Log Out",style: TextStyle(fontSize: 14)),
                                  ]
                              )
                          )
                      ),
                      onTap: ()async{
                        try {
                          await FirebaseAuth.instance.signOut();
                          await GoogleSignIn().signOut();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                          print("User signed out");
                        } catch (e) {
                          print("Error signing out: $e");
                        }
                      },
                    )
                  ]
              )
            ]
        ),
    );
  }
}
