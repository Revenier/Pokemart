import 'package:flutter/material.dart';
import 'package:frontend/My%20Widget/MyButton.dart';
import 'package:frontend/My%20Widget/MyTextField.dart';
import 'package:frontend/My%20Widget/bgwidget.dart';
import 'package:frontend/My%20Widget/change_data.dart';
import 'package:frontend/My%20Widget/take_data.dart';
import 'package:frontend/Page_admin/profile_admin.dart';
import 'package:frontend/Page_user/NavigationBar.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

  @override
class _EditProfileState extends State<EditProfile> {
    TextEditingController _nameController = TextEditingController();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _roleController = TextEditingController();

    @override
    void initState() {
      super.initState();
      fetchData();
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

    Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return overallBG(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            "EDIT PROFILE",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          automaticallyImplyLeading: true,
          iconTheme: const IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [

                // >> Name <<
                Row(
                  children: [
                    Container(
                      height: height*0.04,
                      child: Text("Name",  style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(width: width*0.64),
                  ],
                ),
                MyTextField(
                    controller: _nameController,
                    TextHint: 'name',
                    secureText: false,
                    line: 1,
                    unlockText: true
                ),

                SizedBox(height: height*0.02),

                // >> Email <<
                Row(
                  children: [
                    Container(
                      height: height*0.04,
                      child: Text("Email",  style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(width: width*0.64),
                  ],
                ),
                MyTextField(
                    controller: _emailController,
                    TextHint: '',
                    secureText: false,
                    line: 1,
                    unlockText: false
                ),

                SizedBox(height: height*0.02),

                // >> Password <<
                Row(
                  children: [
                    Container(
                      height: height*0.04,
                      child: Text("Password",  style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(width: width*0.64),
                  ],
                ),
                MyTextField(
                    controller: _passwordController,
                    TextHint: '',
                    secureText: true,
                    line: 1,
                    unlockText: false
                ),

                SizedBox(height: height*0.02),

                // >> Role <<
                Row(
                  children: [
                    Container(
                      height: height*0.04,
                      child: Text("Role",  style: TextStyle(fontSize: 18),),
                    ),
                    SizedBox(width: width*0.64),
                  ],
                ),
                MyTextField(
                    controller: _roleController,
                    TextHint: '',
                    line: 1,
                    secureText: false,
                    unlockText: false
                ),

                SizedBox(height: height*0.3),

                MyButton(
                  onTap: () async {
                    String newName = _nameController.text;
                    await ChangeData('account', 'name', newName);
                    await updateData();

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "You've changed your name to $newName",
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: Colors.white,
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                    if(_roleController.text=='Admin'){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>MainProfileAdmin()));
                    }else{
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BottomNavBar(index: 2,)));
                    }
                  },
                  buttonColor: Colors.blueAccent,
                  Text_on_button: 'Done',
                  sizeX: 50,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
