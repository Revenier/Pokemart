import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/My%20Widget/take_data.dart';

class all_transaction extends StatefulWidget {
  const all_transaction({super.key});

  @override
  State<all_transaction> createState() => _all_transactionState();
}

class _all_transactionState extends State<all_transaction> {
  late Future<List<transactionModel>> transactionList;
  List<transactionModel> _transactionList = [];

  @override
  void initState() {
    super.initState();
    transactionList = getTransaction();
    transactionList.then((value) {
      setState(() {
        _transactionList = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return overallBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "ALL TRANSACTION",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: ListView.builder(
          itemCount: _transactionList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.fromLTRB(10, 15, 10, 0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 2,
                      offset: const Offset(5, 5))
                ],
              ),
              child: ListTile(
                subtitle: Text(_transactionList[index].userEmail, style: TextStyle(fontSize: 20),),
                title: Text(_transactionList[index].userName, style: TextStyle(fontSize: 20),),
                trailing: Column(
                  children: [
                    Text(_transactionList[index].PokeName, style: TextStyle(fontSize: 20),),
                    SizedBox(height: 10,),
                    Text('ID: '+ _transactionList[index].PokeID, style: TextStyle(fontSize: 15),),
                  ],
                )
              ),
            );
          },
        ),
      ),
    );
  }
}
