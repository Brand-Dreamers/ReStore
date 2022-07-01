import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/avatar.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? selectedCollege;
  String? selectedLevel;
  String? selectedDepartment;

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _matricController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Complete your profile", style: headerTextStyle),
                const SizedBox(
                  height: 10,
                ),
                Text("You're almost there...", style: subtitleTextStyle),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _firstnameController,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.person_outline,
                                  size: 22, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "First Name",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _lastnameController,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.person_outline,
                                  size: 22, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "Last Name",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: fieldColor,
                      border: Border.all(
                        color: borderColor,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5.0),
                      child: TextField(
                        controller: _matricController,
                        decoration: const InputDecoration(
                          prefixIcon: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.bookmarks_outlined,
                                  size: 22, color: iconColor)),
                          border: InputBorder.none,
                          hintText: "Matric Number",
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Choose College"),
                      value: selectedCollege,
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.house_outlined,
                                  size: 22, color: iconColor)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: borderColor),
                              borderRadius: BorderRadius.circular(5.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  width: 1, color: borderColor))),
                      items: colleges
                          .map((item) => DropdownMenuItem<String>(
                                child: Text(item, style: GoogleFonts.poppins()),
                                value: item,
                              ))
                          .toList(),
                      dropdownColor: backgroundColor,
                      onChanged: (item) => setState(() {
                        selectedCollege = item ?? "";
                        selectedDepartment = null;
                      }),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Choose Department"),
                      value: selectedDepartment,
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.business_outlined,
                                  size: 22, color: iconColor)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: borderColor),
                              borderRadius: BorderRadius.circular(5.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  width: 1, color: borderColor))),
                      items: getDepartments(selectedCollege)
                          .map((item) => DropdownMenuItem<String>(
                                child: Text(item, style: GoogleFonts.poppins()),
                                value: item,
                              ))
                          .toList(),
                      dropdownColor: backgroundColor,
                      onChanged: (item) =>
                          setState(() => selectedDepartment = item ?? ""),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
                  child: SizedBox(
                    height: 60,
                    child: DropdownButtonFormField<String>(
                      hint: const Text("Choose Level"),
                      value: selectedLevel,
                      decoration: InputDecoration(
                          prefixIcon: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 2.0),
                              child: Icon(Icons.grade_outlined,
                                  size: 22, color: iconColor)),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 1, color: borderColor),
                              borderRadius: BorderRadius.circular(5.0)),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: const BorderSide(
                                  width: 1, color: borderColor))),
                      items: levels
                          .map((item) => DropdownMenuItem<String>(
                                child: Text(item, style: GoogleFonts.poppins()),
                                value: item,
                              ))
                          .toList(),
                      dropdownColor: backgroundColor,
                      onChanged: (item) =>
                          setState(() => selectedLevel = item ?? ""),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      User.getUser().surname = _firstnameController.text.trim();
                      User.getUser().lastname = _lastnameController.text.trim();
                      User.getUser().matricNumber =
                          _matricController.text.trim();
                      User.getUser().college = selectedCollege as String;
                      User.getUser().department = selectedDepartment as String;
                      User.getUser().level = selectedLevel as String;
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Avatar()));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: buttonColor,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:
                          Center(child: Text("Submit", style: buttonTextStyle)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
