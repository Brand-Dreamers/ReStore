import 'package:flutter/material.dart';
import 'package:restore/components/constants.dart';

class ViewDocuments extends StatefulWidget {
  const ViewDocuments({Key? key}) : super(key: key);

  @override
  State<ViewDocuments> createState() => _ViewDocumentsState();
}

class DocumentContainer extends StatelessWidget {
  const DocumentContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        boxShadow: [BoxShadow(color: Colors.black26)],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2.0, horizontal: 5.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const []),
      ),
    );
  }
}

Future<DocumentContainer> getDocuments(String filter) async {
  return null as DocumentContainer;
}

class _ViewDocumentsState extends State<ViewDocuments> {
  String currentFilter = documentFilter[0];
  late List<DocumentContainer> documents;

  void setFilter(String filter) => setState(() => currentFilter = filter);

  @override
  Widget build(BuildContext context) {
    void _showFilterPanel(String filter) {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return FilterPanel(
              currentFilter: filter,
              changeFilter: setFilter,
            );
          });
    }

    return Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(
            "View Documents",
            style: emphasizedSubheader.copyWith(fontSize: 16),
          ),
          actions: [
            TextButton.icon(
                onPressed: () => _showFilterPanel(currentFilter),
                icon: const Icon(
                  Icons.filter_list,
                  color: Colors.black,
                ),
                label: Text(
                  "Filter",
                  style: emphasizedSubheader.copyWith(fontSize: 14),
                ))
          ],
          elevation: 0.0,
        ),
        body: SafeArea(
            child: Center(
          child: FutureBuilder(
              future: getDocuments(currentFilter),
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Popup();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  return Text("Error", style: emphasizedHeader.copyWith(fontSize: 16));
                } else {
                  return const NotificationContainer(
                      message: "An error occured",
                      imageURL: "images/fatal error.png");
                }
              })),
        )));
  }
}

class FilterPanel extends StatefulWidget {
  final String currentFilter;
  final Function changeFilter;
  const FilterPanel(
      {Key? key, required this.currentFilter, required this.changeFilter})
      : super(key: key);

  @override
  State<FilterPanel> createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Filter By", style: emphasizedHeader.copyWith(fontSize: 16)),
            const SizedBox(
              height: 30,
            ),
            ListView.builder(
                itemCount: documentFilter.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(documentFilter[index]),
                    trailing: documentFilter[index] == widget.currentFilter
                        ? const Icon(
                            Icons.done_outlined,
                            color: buttonColor,
                          )
                        : const Text(""),
                    onTap: () => widget.changeFilter(documentFilter[index]),
                  );
                }),
          ]),
    );
  }
}
