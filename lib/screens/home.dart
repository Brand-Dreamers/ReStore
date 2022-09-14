import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';
import 'package:restore/components/user.dart';
import 'package:restore/screens/stamp.dart';
import 'package:restore/screens/view.dart';
import 'package:restore/services/authservice.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late VoidCallback logout;
  late Future<List<DocumentInfo>?> documents;

  @override
  void initState() {
    super.initState();
    documents = AuthService.getService().getUserDocuments();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          "Restore",
          style: emphasizedSubheader.copyWith(
              color: buttonColor, fontWeight: FontWeight.w400, fontSize: 28),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: PopupMenuButton<dynamic>(
              onSelected: (value) {
                User.setUser(null);
                Navigator.pop(context);
              },
              icon: ClipRRect(
                  borderRadius: BorderRadius.circular(6.0),
                  child: Image.network(
                    api + User.getUser()!.email + ext,
                    width: 50,
                    height: 50,
                  )),
              itemBuilder: (context) {
                return [
                  PopupMenuItem<dynamic>(
                      child: Row(
                    children: const [
                      Icon(Icons.power_settings_new_rounded,
                          color: Colors.black),
                      SizedBox(
                        width: 10,
                      ),
                      Text("Sign Out"),
                    ],
                  ))
                ];
              },
            ),
          ),
        ],
      ),
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome, ${User.getUser()!.email}",
                    style: emphasizedHeader.copyWith(
                        fontSize: 20, fontWeight: FontWeight.w800),
                  ),
                  Text(
                    "What would you like to do today?",
                    style: emphasizedSubheader.copyWith(
                        fontSize: 14, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: size.height - 200,
                    child: SingleChildScrollView(
                        child: FutureBuilder(
                            future: documents,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Popup();
                              } else if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                if (snapshot.hasData) {
                                  List<DocumentInfo>? userDocuments =
                                      snapshot.data as List<DocumentInfo>?;
                                  if (userDocuments == null ||
                                      userDocuments.isEmpty) {
                                    return const Center(
                                      child: Text("No Documents Uploaded"),
                                    );
                                  } else {
                                    return ListView.builder(
                                        scrollDirection: Axis.vertical,
                                        physics: const BouncingScrollPhysics(),
                                        itemCount: userDocuments.length,
                                        itemBuilder: (context, index) {
                                          return ListTile(
                                              title: Text(
                                                  userDocuments[index].title),
                                              subtitle: Text(
                                                  userDocuments[index].size),
                                              leading: Image.asset(
                                                "images/pdf.png",
                                                height: 40,
                                                width: 40,
                                              ),
                                              onTap: () =>
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) => View(
                                                            data: userDocuments[
                                                                index])), // Show the document
                                                  ));
                                        });
                                  }
                                } else {
                                  return const Center(
                                      child: Text(
                                          "Something Went Wrong. Please Try Again!"));
                                }
                              } else {
                                return const Center(
                                    child: Text(
                                        "An Error Occured On The Server. Contact The Developer!"));
                              }
                            })),
                  ),
                ]),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const Stamp())),
        elevation: 1.0,
        child: const Icon(Icons.upload_rounded),
      ),
    );
  }
}
