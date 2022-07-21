import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchingView extends StatefulWidget {
  const SearchingView({Key? key}) : super(key: key);

  @override
  State<SearchingView> createState() => _SearchingViewState();
}

class _SearchingViewState extends State<SearchingView> {
  Future<String> searchInAPI(String text) async {
    return "cat";
  }

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
                                onSubmitted: (text) => searchInAPI(text),
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(bottom: 13.0),
                                    hintText: "Search",
                                    border: InputBorder.none),
                              )),
                              const Icon(Icons.cancel)
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
                      child: Center(child: Text("Cancel"))),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
