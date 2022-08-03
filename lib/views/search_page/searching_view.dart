import 'package:flutter/material.dart';

import 'package:game_lib_app/models/search_response/search_response.dart';
import 'package:game_lib_app/repositories/igdb_repository.dart';
import 'package:game_lib_app/views/details_page/details_page.dart';
import 'package:game_lib_app/widgets/favourite_games_dialog.dart/favourite_game_dialog.dart';
import 'package:get/utils.dart';

class SearchingView extends StatefulWidget {
  const SearchingView({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchingView> createState() => _SearchingViewState();
}

class _SearchingViewState extends State<SearchingView> {
  bool isFetching = false;
  List<SearchResponse> loadedResponses = [];
  Future<void> searchInAPI(String text, int offset) async {
    isFetching = true;
    loadedResponses.addAll(await IgdbRepository.searchForPhrases(text, offset));
    if (mounted) {
      setState(
        () {},
      );
    }
    isFetching = false;
  }

  void checkIfEmpty(String value) {
    if (value.isEmpty) {
      if (mounted) {
        setState(() {
          loadedResponses = [];
        });
      }
    }
  }

  FocusNode focusNode = FocusNode();

  TextEditingController editingController = TextEditingController();
  String searchText = '';
  @override
  Widget build(BuildContext context) {
    int listLength = loadedResponses.length;
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
                                onSubmitted: (text) => isFetching
                                    ? null
                                    : {
                                        searchText = text,
                                        loadedResponses = [],
                                        searchInAPI(text, 0)
                                      },
                                decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(bottom: 13.0),
                                    hintText: "search".tr,
                                    border: InputBorder.none),
                              )),
                              IconButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () {
                                    editingController.clear();
                                    if (mounted) {
                                      setState(() {
                                        loadedResponses = [];
                                      });
                                    }
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
                      child: Center(child: Text("cancel".tr))),
                ),
              ],
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: listLength + 1,
          itemBuilder: (context, index) {
            if (index == listLength) {
              if (index > 0) {
                return TextButton(
                    onPressed: () =>
                        isFetching ? null : searchInAPI(searchText, listLength),
                    child: Text('search_more'.tr));
              }
              return const SizedBox();
            }
            SearchResponse resp = loadedResponses[index];
            return GestureDetector(
              onLongPress: () => showDialog(
                context: context,
                builder: (_) => FavDialog(
                  game: resp.game!,
                ),
              ),
              child: ListTile(
                leading: SizedBox(
                  width: 45,
                  child: resp.game?.cover?.url != null
                      ? Image.network(
                          IgdbRepository.getPictureWithResolution(
                              resp.game!.cover!.url, 'thumb'),
                          fit: BoxFit.fitWidth,
                        )
                      : const SizedBox(),
                ),
                title: Text(
                  resp.name ?? "",
                  style: const TextStyle(color: Colors.white),
                  overflow: TextOverflow.clip,
                ),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailsPage(
                      gameID: resp.game!.id,
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    editingController.dispose();
    super.dispose();
  }
}
