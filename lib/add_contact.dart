import 'package:day39_sqflite/contact.dart';
import 'package:day39_sqflite/db_helper.dart';
import 'package:day39_sqflite/demo.dart';
import 'package:flutter/material.dart';

class AddContact extends StatefulWidget {
  const AddContact({Key? key,this.contact}) : super(key: key);
final Contact? contact;
  @override
  State<AddContact> createState() => _AddContactState();
}

class _AddContactState extends State<AddContact> {
  TextEditingController _nameController=TextEditingController();
  TextEditingController _contactController=TextEditingController();
  @override
  void initState() {
    if(widget.contact!=null){
      _nameController.text=widget.contact!.name!;
      _nameController.text=widget.contact!.contact!;
    }
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("contacts"),
        centerTitle: true,),
      body: Padding(padding: EdgeInsets.all(15),
      child: Column(
          children: [
            _buildTextField(_nameController,"name"),
            SizedBox(height: 10,),
            _buildTextField(_contactController,"contact"),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: () async{
              await DBHelper.createContact(Contact(
                  name: _nameController.text,
                  contact: _contactController.text,
              )

              );
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => Demo()));
              // setState(() {
              //   Navigator.of(context).pop();
              // });

            },
                child: Text("Add Contact")
            )
        ],
      ),
      ),
    );
  }
  TextField _buildTextField(TextEditingController _controller,String hint){
    return TextField(
      controller: _controller,
      decoration: InputDecoration(
        labelText: hint,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15)
        )
      ),
    );
  }
}
