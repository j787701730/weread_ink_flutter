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
  double fontSize = 16.0;
  List bookMenu = [];
  bool loading = false;
  bool showMenu = true;
  bool showBookMenu = true;
  bool showFontMenu = true;
  bool showStyleMenu = true;
  List style = [
    {
      'text': 0xff000000,
      'bgcolor': 0xffffffff,
    },
    {
      'text': 0xff000000,
      'bgcolor': 0xffF1EAD9,
    },
    {
      'text': 0xff000000,
      'bgcolor': 0xffC7EAC9,
    },
    {
      'text': 0xffffffff,
      'bgcolor': 0xff000000,
    },
  ];
  int styleIndex = 0;
  Map param = {
    'id': 1,
    'books_id': 1,
  };

  _getBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String bookmark = prefs.getString('bookmark');
    int bookStyle = prefs.getInt('bookstyle');
    double bookFontSize = prefs.getDouble('booksfontszie');
    if (bookmark == null) {
      param['id'] = 1;
    } else {
      param['id'] = jsonDecode(bookmark)['0']['id'];
    }
    if (bookStyle == null) {
      styleIndex = 0;
    } else {
      styleIndex = bookStyle;
    }
    if (bookFontSize == null) {
      fontSize = 16.0;
    } else {
      fontSize = bookFontSize;
    }
    getBookContent();
  }

  _setBookmark() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('bookmark', jsonEncode(ajaxData));
  }

  _setBookStyle(index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('bookstyle', index);
  }

  _setBookFontSize(fontSize) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('booksfontszie', fontSize);
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

  getPageOffsets(String content) {
    String tempStr = content;
    List<Map<String, int>> pageConfigTemp = ajaxData['prev'] == '' ? [] : [{}];
    int last = 0;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double top = mediaQuery.padding.top;
    double left = mediaQuery.padding.left;
    double right = mediaQuery.padding.right;
    double bottom = mediaQuery.padding.bottom;
    double width = mediaQuery.size.width;
    double offsetHeight = height - top - (fontSize * 1.5) - 46 - bottom;
    double offsetWidth = width - 40 - left - right;
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
      textPainter.layout(maxWidth: offsetWidth);
      var end = textPainter.getPositionForOffset(Offset(offsetWidth, offsetHeight)).offset;

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

    setState(() {
      ajaxData = res.data;
      getPageOffsets(ajaxData['0']['content']);
      _controller.jumpToPage(flag == 'prev' ? pageConfig.length - 1 : ajaxData['prev'] == '' ? 0 : 1);
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
        if (index > height / 2 / 44.0) {
          _bookMenuController
              .jumpTo((index + 1) * 44.0 - (height / 2 < (bookMenu.length - index) * 44 ? height / 2 : height));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double top = mediaQuery.padding.top;
    double width = mediaQuery.size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            PageView.builder(
              controller: _controller,
              itemBuilder: ((context, index) {
                return loading
                    ? Container(
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              '${style[styleIndex]['bgcolor']}',
                            ),
                          ),
                        ),
                        child: Center(
                          child: CupertinoActivityIndicator(),
                        ),
                      )
                    : Container(
                        padding: EdgeInsets.only(
                          left: 20,
                          right: 20,
                        ),
                        decoration: BoxDecoration(
                          color: Color(
                            int.parse(
                              '${style[styleIndex]['bgcolor']}',
                            ),
                          ),
                        ),
                        child:
                            index == pageConfig.length && ajaxData['next'] != '' || index == 0 && ajaxData['prev'] != ''
                                ? Container(
                                    height: height - top,
                                    child: Center(
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  )
                                : GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        showMenu = !showMenu;
                                        showStyleMenu = true;
                                        showFontMenu = true;
                                      });
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
                                            width: width - 40,
                                            alignment: Alignment.topCenter,
                                            child: SingleChildScrollView(
                                              child: Text(
                                                '${ajaxData['0']['content'].substring(pageConfig[index]['start'], pageConfig[index]['end'])}',
                                                style: TextStyle(
                                                  height: 1.5,
                                                  fontSize: fontSize,
                                                  fontFamily: 'SourceHanSerifCN',
                                                  color: Color(
                                                    int.parse(
                                                      '${style[styleIndex]['text']}',
                                                    ),
                                                  ),
                                                ),
                                                textAlign: TextAlign.justify,
//                                            textWidthBasis: TextWidthBasis.longestLine,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 20,
                                            alignment: Alignment.topRight,
                                            child: Text(
                                              '${ajaxData['prev'] == '' ? index + 1 : index}/${pageConfig.length - 1}',
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
                      );
              }),
              itemCount: ajaxData['next'] == '' ? pageConfig.length : pageConfig.length + 1,
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
            Positioned(
              left: 0,
              bottom: 0,
              child: Offstage(
                offstage: showMenu,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(color: Colors.black),
                    ),
                  ),
                  height: 44,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: 43,
                          width: 60,
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            getBookMenu(height: height - top);
                            showMenu = true;
                            showBookMenu = false;
                            showFontMenu = true;
                            showStyleMenu = true;
                          });
                        },
                        child: Container(
                          height: 43,
                          width: 60,
                          child: Icon(Icons.menu),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showStyleMenu = !showStyleMenu;
                          });
                        },
                        child: Container(
                          height: 43,
                          width: 60,
                          child: Icon(Icons.wb_sunny),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            showFontMenu = !showFontMenu;
                          });
                        },
                        child: Container(
                          height: 43,
                          width: 60,
                          alignment: Alignment.center,
                          child: Text(
                            'A',
                            style: TextStyle(
                              fontSize: 26,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 40,
              child: Offstage(
                offstage: showFontMenu,
                child: Container(
                  height: 44,
                  alignment: Alignment.center,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(left: 20),
                        child: Text('A'),
                      ),
                      Expanded(
                        child: Slider(
                          value: fontSize,
                          min: 16,
                          max: 22,
                          label: '$fontSize',
                          onChanged: (val) {
                            setState(() {
                              fontSize = val;
                            });
                          },
                          onChangeEnd: (val) {
                            setState(() {
                              fontSize = val;
                              _setBookFontSize(val);
                              getPageOffsets(ajaxData['0']['content']);
                            });
                          },
                          divisions: 6,
                        ),
                        flex: 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Text(
                          'A',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 40,
              right: 0,
              child: Offstage(
                offstage: showStyleMenu,
                child: Container(
                  height: 44,
                  decoration: BoxDecoration(
                    color: Color(0xffE9E5D4),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: style.map<Widget>(
                      (item) {
                        return Container(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                styleIndex = style.indexOf(item);
                                _setBookStyle(styleIndex);
                              });
                            },
                            child: Container(
                              width: width / 5,
                              height: 26,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: styleIndex == style.indexOf(item)
                                      ? Color(0xff9B5E05)
                                      : Color(
                                          int.parse(
                                            '${item['bgcolor']}',
                                          ),
                                        ),
                                ),
                                color: Color(
                                  int.parse(
                                    '${item['bgcolor']}',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Offstage(
                offstage: showBookMenu,
                child: Row(
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          showBookMenu = true;
                        });
                      },
                      child: Container(
                        height: height,
                        color: Colors.transparent,
                        width: width / 4,
                      ),
                    ),
                    Container(
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
                              setState(() {
                                param['id'] = bookMenu[index]['id'];
                                getBookContent();
                                showBookMenu = true;
                              });
                            },
                            child: Container(
                              height: 44,
                              alignment: Alignment.centerLeft,
                              decoration: BoxDecoration(
                                border: Border(
                                  top: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: 3,
                                  bottom: 3,
                                ),
                                color: param['id'] == bookMenu[index]['id'] ? Colors.black : Colors.white,
                                child: Text(
                                  bookMenu[index]['name'],
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    color: param['id'] == bookMenu[index]['id'] ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: bookMenu.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
