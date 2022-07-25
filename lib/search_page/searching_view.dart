import 'package:flutter/material.dart';
import 'package:game_lib_app/details_page/details_page.dart';
import 'package:game_lib_app/resource_manager.dart';

class SearchingView extends StatefulWidget {
  const SearchingView({Key? key}) : super(key: key);

  @override
  State<SearchingView> createState() => _SearchingViewState();
}

class _SearchingViewState extends State<SearchingView> {
  Future<void> searchInAPI(String text) async {
    int length = await resMan.searchForPhrases(text);
    setState(
      () {
        listLength = length;
      },
    );
  }

  void checkIfEmpty(String value) {
    if (value.isEmpty) {
      setState(() {
        listLength = 0;
        resMan.searchResponses = [];
      });
    }
  }

  late FocusNode focusNode = FocusNode();

  TextEditingController editingController = TextEditingController();
  int listLength = 0;
  ResourceManager resMan = ResourceManager();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        color: Colors.grey[600],
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              const Icon(Icons.search_rounded),
                              Flexible(
                                  child: TextField(
                                onChanged: (value) => checkIfEmpty(value),
                                focusNode: focusNode,
                                autofocus: true,
                                controller: editingController,
                                autocorrect: false,
                                onSubmitted: (text) => searchInAPI(text),
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 13.0),
                                    hintText: "Search",
                                    border: InputBorder.none),
                              )),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    editingController.clear();
                                    setState(() {
                                      listLength = 0;
                                      resMan.searchResponses = [];
                                    });
                                  },
                                  icon: const Icon(Icons.cancel))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 13.0),
                  child: GestureDetector(
                      onTap: (() => Navigator.pop(context)),
                      child: const Center(child: Text("Cancel"))),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: listLength,
        itemBuilder: (context, index) => ListTile(
          leading: SizedBox(
            width: 45,
            child: resMan.searchResponses[index].game?.cover?.url != null
                ? Image.network(
                    ResourceManager.getPictureWithResolution(
                        resMan.searchResponses[index].game!.cover!.url,
                        'thumb'),
                    fit: BoxFit.fitWidth,
                  )
                : Container(),
          ),
          title: Text(
            resMan.searchResponses[index].name ?? "",
            style: const TextStyle(color: Colors.white),
            overflow: TextOverflow.clip,
          ),
          onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailsPage(
                      gameID: resMan.searchResponses[index].game!.id!,
                      resMan: resMan))),
        ),
      ),
    );
  }
}
