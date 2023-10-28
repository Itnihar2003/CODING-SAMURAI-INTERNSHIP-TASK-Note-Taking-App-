import 'package:flutter/material.dart';
import 'package:noteapp/homepage.dart';

class edit extends StatefulWidget {
  final tittlevalue;
  final contentvalue;
  final int index;

  const edit({
    super.key,
    this.tittlevalue,
    this.contentvalue, required this.index,
  });

  @override
  State<edit> createState() => _editState();
}

class _editState extends State<edit> {
  int selectedindex = -1;
  TextEditingController tittleedit = TextEditingController();
  TextEditingController contentedit = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Edit page",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
        ),
        backgroundColor: Colors.pinkAccent,
      ),
      body: Expanded(
          child: Container(
              child: AlertDialog(
        backgroundColor: const Color.fromARGB(255, 241, 199, 213),
        content: TextField(
          controller: contentedit,
          decoration: InputDecoration(
              hintText: "Enter Content",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => home(
                                  newcontent: contentedit.text,
                                  newtittle: tittleedit.text, finalindex: widget.index,
                                )));
                   
                  },
                  child: const Text(
                    "save",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent),
                  onPressed: () {
                    tittleedit.text = widget.tittlevalue;
                    contentedit.text = widget.contentvalue;
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  )),
            ],
          )
        ],
        title: TextField(
          controller: tittleedit,
          decoration: InputDecoration(
              hintText: "Enter tittle",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12))),
        ),
      ))),
    );
  }
}
