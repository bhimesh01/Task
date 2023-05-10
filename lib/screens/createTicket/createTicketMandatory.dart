import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class CreateTicket extends StatefulWidget {
  const CreateTicket({Key? key}) : super(key: key);

  @override
  _MyCreateTicketState createState() => _MyCreateTicketState();
}

final List<String> projects = [
  'Project A',
  'Project B',
  'Project C',
  'Project D',
  'Project E',
];

final List<String> users = [
  'Nishant Ghosh',
  'Praneetha',
  'Bhimesh',
  'Abhishek',
  'Sneha',
  'Riktha',
  'UserName1',
  'UserName2',
];

String? dropdownValue = projects[0];
String? userDropDownValue;

class _MyCreateTicketState extends State<CreateTicket> {
  TextEditingController taskNameController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double deviceSize = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: const Color(0xFFF5F5FA),
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: Padding(
            padding: EdgeInsets.all(13),
            child: GestureDetector(
              onTap: () {
                print("Navigation tapped!");
              },
              child: Image.asset("assets/icons/menuIcon.png"),
            ),
          ),
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  icon: Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Image.asset('assets/icons/arrowDown.png',
                        width: 18, height: 18),
                  ),
                  dropdownColor: Colors.white,
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue.toString();
                    });
                  },
                  value: dropdownValue,
                  items: projects
                      .map((value) => DropdownMenuItem(
                            value: value,
                            child: Text(value),
                          ))
                      .toList(),
                ),
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        child: Text(
                          'Create New Ticket',
                          style:
                              TextStyle(color: Color(0xff222995), fontSize: 12),
                        ),
                        padding: EdgeInsets.only(left: 15),
                      ),
                      color: Colors.white,
                      width: deviceSize / 1.2,
                      height: 40,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Image.asset(
                  'assets/images/createTicketMandatory.png',
                  width: deviceSize / 1.2,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  width: deviceSize / 1.2,
                  child: TextField(
                    controller: taskNameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Task Name',
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: Container(
                  width: deviceSize / 1.2,
                  child: TextField(
                    controller: taskDescriptionController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 7,
                    decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Description',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        )),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                child: Container(
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                        icon: Padding(
                          padding: EdgeInsets.only(right: 20),
                          child: Image.asset('assets/icons/arrowDown.png',
                              width: 18, height: 18),
                        ),
                        dropdownColor: Colors.white,
                        value: userDropDownValue,
                        items: users
                            .map((item) => DropdownMenuItem(
                                  value: item,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 10),
                                    child: Text(item),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            userDropDownValue = value.toString();
                          });
                        }),
                  ),
                  width: deviceSize / 1.2,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ));
  }
}
