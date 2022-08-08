import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restore/screens/avatar.dart';
import 'package:restore/services/authservice.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final Map<String, String> _authDetails = {
    "firstName": "",
    "lastName": "",
    "level": "",
    "college": "",
    "department": "",
    "matricNumber": "",
    "telephone": "",
  };

  String? selectedCollege;

  Future _submit() async {
    FormState? currentState = _formKey.currentState;
    if (currentState != null) {
      if (!currentState.validate()) return;

      currentState.save();
      bool success = await AuthService.getService().profile(_authDetails);
      if (success) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Avatar()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text("Complete your profile",
                  style: emphasizedHeader.copyWith(
                      fontSize: 28, fontWeight: FontWeight.w800)),
              const SizedBox(
                height: 5,
              ),
              Text("You're almost there...",
                  style: emphasizedSubheader.copyWith(
                      fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.person_outline_rounded,
                                      size: 20, color: iconColor)),
                              border: InputBorder.none,
                              hintText: "First Name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please input a name";
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                _authDetails["firstName"] = value!,
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.person_outline_rounded,
                                      size: 20, color: iconColor)),
                              border: InputBorder.none,
                              hintText: "Last Name",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please input a name";
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                _authDetails["lastName"] = value!,
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.bookmarks_outlined,
                                      size: 20, color: iconColor)),
                              border: InputBorder.none,
                              hintText: "Matric Number",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please input a number";
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                _authDetails["matricNumber"] = value!,
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
                          child: TextFormField(
                            decoration: const InputDecoration(
                              prefixIcon: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.phone_rounded,
                                      size: 20, color: iconColor)),
                              border: InputBorder.none,
                              hintText: "Telephone",
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please input a number";
                              }
                              return null;
                            },
                            onSaved: (value) =>
                                _authDetails["telephone"] = value!,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          key: _formKey,
                          hint: const Text("Choose College"),
                          value: selectedCollege,
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.house_outlined,
                                      size: 20, color: iconColor)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: borderColor),
                                  borderRadius: BorderRadius.circular(6)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      width: 1, color: borderColor))),
                          items: colleges
                              .map((item) => DropdownMenuItem<String>(
                                    child: Text(item,
                                        style: GoogleFonts.poppins()),
                                    value: item,
                                  ))
                              .toList(),
                          dropdownColor: backgroundColor,
                          onChanged: (item) {
                            setState(() => selectedCollege = item ?? "");
                            _authDetails["college"] = item ?? "";
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          key: _formKey,
                          hint: const Text("Choose Department"),
                          value: "",
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.business_outlined,
                                      size: 20, color: iconColor)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: borderColor),
                                  borderRadius: BorderRadius.circular(6)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      width: 1, color: borderColor))),
                          items: getDepartments(selectedCollege)
                              .map((item) => DropdownMenuItem<String>(
                                    child: Text(item,
                                        style: GoogleFonts.poppins()),
                                    value: item,
                                  ))
                              .toList(),
                          dropdownColor: backgroundColor,
                          onChanged: (item) =>
                              _authDetails["department"] = item ?? "",
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: SizedBox(
                        height: 60,
                        child: DropdownButtonFormField<String>(
                          key: _formKey,
                          hint: const Text("Choose Level"),
                          value: "",
                          decoration: InputDecoration(
                              prefixIcon: const Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 2.0),
                                  child: Icon(Icons.grade_outlined,
                                      size: 20, color: iconColor)),
                              border: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 1, color: borderColor),
                                  borderRadius: BorderRadius.circular(6)),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(6),
                                  borderSide: const BorderSide(
                                      width: 1, color: borderColor))),
                          items: levels
                              .map((item) => DropdownMenuItem<String>(
                                    child: Text(item,
                                        style: GoogleFonts.poppins()),
                                    value: item,
                                  ))
                              .toList(),
                          dropdownColor: backgroundColor,
                          onChanged: (item) =>
                              _authDetails["level"] = item ?? "",
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: GestureDetector(
                  onTap: () => _submit(),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(6),
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
    );
  }
}
