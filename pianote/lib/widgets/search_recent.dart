import 'package:flutter/material.dart';
import 'package:get_it_mixin/get_it_mixin.dart';
import 'package:pianote/providers/history_provider.dart';

class SearchRecent extends StatefulWidget with GetItStatefulWidgetMixin{
  //final HistoryProvider recentProvider;
  final String searchValue;
  SearchRecent({Key? key, required this.searchValue}) : super(key: key);
  @override
  State<SearchRecent> createState() => _SearchRecentState();
}

class _SearchRecentState extends State<SearchRecent> with GetItStateMixin{
  late Future<List<String>> _recentSearch;

  @override
  void initState() {
    super.initState();
    //_recentSearch = Future.value(widget.recentProvider.recentSearch);
    _recentSearch = get<HistoryProvider>().getRecentSearch();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '최근 검색',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: Colors.grey[700],
                    fontWeight: FontWeight.w600,
                  ),
                ),
                TextButton(
                  onPressed: () => get<HistoryProvider>().removeAllRecentSearch(),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                  ),
                  child: Text(
                    '모두 지우기',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: FutureBuilder<List<String>>(
                future: _recentSearch,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No recent searches found.'));
                  } else {
                    return Scrollbar(
                          child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final item = snapshot.data![index];
                            return GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                // Handle the tap event
                                print('Tapped on $item');
                              },
                              child: Container(
                                color: Colors.white,
                                padding: EdgeInsets.all(8.0),
                                margin: EdgeInsets.symmetric(vertical: 1.0),
                                child: Text(
                                  item,
                                  style: TextStyle(fontSize: 14.0),
                                ),
                              ),
                            );
                          },
                        // )
                      )
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}