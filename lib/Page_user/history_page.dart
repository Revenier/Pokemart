import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/Model.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/My%20Widget/take_data.dart';

class HistoryPage extends StatefulWidget {
  final List<transactionModel> transactionList;
  const HistoryPage({Key?key, required this.transactionList}): super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {
    return overallBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "HISTORY",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: ListView.builder(
          itemCount: widget.transactionList.length,
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
                subtitle: Text('ID: '+ widget.transactionList[index].PokeID, style: TextStyle(fontSize: 15),),
                title: Text(widget.transactionList[index].PokeName, style: TextStyle(fontSize: 20),),
                trailing: Image.network(widget.transactionList[index].PokeImage),
              ),
            );
          },
        ),
      ),
    );
  }
}
