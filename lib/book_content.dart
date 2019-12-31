import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookContent extends StatefulWidget {
  @override
  _BookContentState createState() => _BookContentState();
}

class _BookContentState extends State<BookContent> {
  List<Map<String, int>> pageConfig = [];
  Map ajaxData = {};
  PageController _controller;
  ScrollController _bookMenuController;

  List bookMenu = [];
  bool loading = false;
  Map param = {
    'id': 1,
    'books_id': 1,
  };

  _getBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bookmark = prefs.getString('bookmark');
    if (bookmark == null) {
      param['id'] = 1;
      getBookContent();
    } else {
      param['id'] = jsonDecode(bookmark)['0']['id'];
      getBookContent();
    }
  }

  _setBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookmark', jsonEncode(ajaxData));
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: 0);
    _bookMenuController = ScrollController();
    _getBookmark();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _bookMenuController.dispose();
  }

  getPageOffsets(String content, double height, double width, double fontSize) {
    String tempStr = content;
    List<Map<String, int>> pageConfigTemp = [{}];
    int last = 0;
    while (true) {
      Map<String, int> offset = {};
      offset['start'] = last;
      TextPainter textPainter = TextPainter(
        textDirection: TextDirection.ltr,
//        locale: Locale('zh', 'CH'),
      );
      textPainter.text = TextSpan(
        text: tempStr,
        style: TextStyle(
          fontSize: fontSize,
          height: 1.5,
          fontFamily: 'SourceHanSerifCN',
        ),
      );
      textPainter.layout(maxWidth: width);
      var end = textPainter.getPositionForOffset(Offset(width, height)).offset;

      if (end == 0) {
        break;
      }
      tempStr = tempStr.substring(end, tempStr.length);
      offset['end'] = last + end;
      last = last + end;
      pageConfigTemp.add(offset);
    }
    setState(() {
      pageConfig = pageConfigTemp;
    });
//    return pageConfig;
//    print(pageConfig);
  }

  getBookContent({flag}) async {
    setState(() {
      loading = true;
    });
    Response res = await Dio().post(
      "http://www.zhengw.top/getContent",
      data: param,
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
//          'X-Requested-With': 'XMLHttpRequest',
          'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
      ),
    );
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    setState(() {
      ajaxData = res.data;
      getPageOffsets(
        ajaxData['0']['content'],
        height - top - (16 * 1.5) - 46,
        width - 40,
        16.0,
      );
      _controller.jumpToPage(flag == 'prev' ? pageConfig.length - 1 : 1);
      _setBookmark();
      loading = false;
    });
  }

  getBookMenu({@required height}) async {
    Response res = await Dio().post(
      "http://www.zhengw.top/getBook",
      data: {'id': 1},
      options: Options(
        contentType: Headers.formUrlEncodedContentType,
        headers: {
//          'X-Requested-With': 'XMLHttpRequest',
          'content-type': 'application/x-www-form-urlencoded;charset=UTF-8'
        },
      ),
    );
    if (mounted) {
      int index = 0;
      for (var o in res.data['data']) {
        if (o['id'] == param['id']) {
          break;
        }
        index++;
      }
      setState(() {
        bookMenu = res.data['data'];
        if (index > height / 2 / 34.0) {
          _bookMenuController
              .jumpTo((index + 1) * 34.0 - (height / 2 < (bookMenu.length - index) * 34 ? height / 2 : height));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).padding.top;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      endDrawer: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            left: BorderSide(
              color: Colors.black,
            ),
          ),
        ),
        width: width * 3 / 4,
        height: height,
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: ListView.builder(
          controller: _bookMenuController,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                param['id'] = bookMenu[index]['id'];
                getBookContent();
                Navigator.of(context).pop();
              },
              child: Container(
                height: 34,
                alignment: Alignment.centerLeft,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  color: param['id'] == bookMenu[index]['id'] ? Colors.black : Colors.white,
                ),
                child: Text(
                  bookMenu[index]['name'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: param['id'] == bookMenu[index]['id'] ? Colors.white : Colors.black,
                  ),
                ),
              ),
            );
          },
          itemCount: bookMenu.length,
        ),
      ),
      body: SafeArea(
        child: PageView.builder(
          controller: _controller,
          itemBuilder: ((context, index) {
            return loading
                ? Container(
                    child: Center(
                      child: CupertinoActivityIndicator(),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: SingleChildScrollView(
                      child: index == pageConfig.length || index == 0
                          ? Container(
                              height: height - top,
                              child: Center(
                                child: CupertinoActivityIndicator(),
                              ),
                            )
                          : GestureDetector(
                              onTap: () {
                                getBookMenu(height: height - top);
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: Container(
                                height: height - top,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 20,
                                      alignment: Alignment.bottomLeft,
                                      child: Text(
                                        '${ajaxData['0']['name']}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: height - top - 40,
                                      child: Text(
                                        '${ajaxData['0']['content'].substring(pageConfig[index]['start'], pageConfig[index]['end'])}',
                                        style: TextStyle(
                                          height: 1.5,
                                          fontSize: 16,
                                          fontFamily: 'SourceHanSerifCN',
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 20,
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        '$index/${pageConfig.length}',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                    ),
                  );
          }),
          itemCount: pageConfig.length + 1,
          onPageChanged: (index) {
            setState(() {
              index = index;
              if (index == pageConfig.length && ajaxData['next'] != '') {
                param['id'] = ajaxData['next'];
                getBookContent(flag: 'next');
              } else if (index == 0 && ajaxData['prev'] != '') {
                param['id'] = ajaxData['prev'];
                getBookContent(flag: 'prev');
              }
            });
          },
        ),
      ),
    );
  }
}
