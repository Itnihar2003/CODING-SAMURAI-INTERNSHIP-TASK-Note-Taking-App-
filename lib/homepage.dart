import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:noteapp/data.dart';
import 'package:noteapp/editpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  final newcontent;
  final newtittle;
  final finalindex;
  const home({super.key, this.newcontent, this.newtittle, this.finalindex});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  TextEditingController pop = TextEditingController();
  TextEditingController pop1 = TextEditingController();
  List<data> data1s = [];
  int selectedindex = -1;

  setdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String> data1List =
        data1s.map((data) => jsonEncode(data.toJson())).toList();
    pref.setStringList('myData', data1List);
  }

  getdata() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    List<String>? data1List = pref.getStringList('myData');
    if (data1List != null) {
      List<data> finaldata = data1List
          //here data and data1 are not same
          .map((data1) => data.fromJson(json.decode(data1)))
          .toList();
      return finaldata;
    }
  }

  @override
  void initState() {
    update();
    super.initState();
  }

  update() async {
    List<data> sdata = await getdata();
    setState(() {
      data1s = sdata;
    });
  }

  save() {
    if (pop.text != "" && pop1.text != "") {
      setState(() {
        data1s.add(data(tittle: pop.text.trim(), content: pop1.text.trim()));
      });
      setdata();
    }
  }

  show() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 241, 199, 213),
              content: TextField(
                controller: pop1,
                decoration: InputDecoration(
                    hintText: "Enter Content",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.pinkAccent),
                    onPressed: () {
                      save();

                      Navigator.pop(context);
                      pop.clear();
                      pop1.clear();
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ))
              ],
              title: TextField(
                controller: pop,
                decoration: InputDecoration(
                    hintText: "Enter tittle",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12))),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: IconButton(
                onPressed: () {
                  setState(() {
                    selectedindex = widget.finalindex;
                    data1s[selectedindex].tittle = widget.newtittle;
                    data1s[selectedindex].content = widget.newcontent;
                  });
                  setdata();
                },
                icon: const Column(
                  children: [
                    Icon(
                      Icons.refresh,
                      color: Colors.black,
                      size: 20,
                    ),
                    Text(
                      "Reload",
                      style: TextStyle(fontSize: 12),
                    )
                  ],
                )),
          )
        ],
        title: const Text(
          "Note App",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Expanded(
          child: Container(
        color: const Color.fromARGB(255, 241, 199, 213),
        child: ListView.builder(
          itemCount: data1s.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.pinkAccent),
                  child: InkWell(
                    onLongPress: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => edit(
                                    tittlevalue: data1s[index].tittle,
                                    contentvalue: data1s[index].content,
                                    index: index,
                                  )));
                    },
                    child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          trailing: IconButton(
                              onPressed: () {
                                setState(() {
                                  data1s.removeAt(index);
                                  setdata();
                                });
                              },
                              icon: const Icon(
                                Icons.delete,
                                size: 30,
                                color: Colors.black,
                              )),
                          title: Text(
                            "Tittle:\n${data1s[index].tittle}",
                            style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          subtitle: Text(
                            "Content:\n${data1s[index].content}",
                            style: const TextStyle(color: Colors.black),
                          ),
                        )),
                  )),
            );
          },
        ),
      )),
      floatingActionButton: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.pinkAccent,
          child: IconButton(
              onPressed: () {
                show();
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ))),
      bottomNavigationBar: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Text(
          "LongPress Each Container For Edit Text and Press Reload For Update .",
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
