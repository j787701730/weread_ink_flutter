import 'package:flutter/material.dart';
import 'package:weread_ink_flutter/book_desc.dart';

class Bookshelf extends StatefulWidget {
  @override
  _BookshelfState createState() => _BookshelfState();
}

class _BookshelfState extends State<Bookshelf> {
  int bottomIndex;
  int bookSelectIndex;
  double width;
  BuildContext _context;
  List bookshelf = [
    {'name': '围城', 'img': 'ia_100000001.jpg'},
    {'name': '平凡的世界（全三册）', 'img': 'ia_100000002.jpg'},
    {'name': '三体（全三册）', 'img': 'ia_100000003.jpg'},
    {'name': '人生', 'img': 'ia_100000004.jpg'},
    {'name': '围城', 'img': 'ia_100000001.jpg'},
    {'name': '平凡的世界（全三册）', 'img': 'ia_100000002.jpg'},
    {'name': '三体（全三册）', 'img': 'ia_100000003.jpg'},
    {'name': '人生', 'img': 'ia_100000004.jpg'},
    {'name': '围城', 'img': 'ia_100000001.jpg'},
    {'name': '平凡的世界（全三册）', 'img': 'ia_100000002.jpg'},
    {'name': '三体（全三册）', 'img': 'ia_100000003.jpg'},
    {'name': '人生', 'img': 'ia_100000004.jpg'},
  ];

  @override
  void initState() {
    super.initState();
    _context = context;
  }

  _changeBottomIndex(val) {
    setState(() {
      bottomIndex = val;
    });
  }

  Widget moreColumn(item, count) {
    double reduceWidth = 48 + 52.0;
    return Container(
      width: (width - reduceWidth) / count,
      margin: EdgeInsets.only(
        right: (bookshelf.indexOf(item) + 1) % 3 == 0 ? 0 : 26,
        bottom: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          GestureDetector(
            onTapDown: (e) {
              setState(() {
                bookSelectIndex = bookshelf.indexOf(item);
              });
            },
            onTapUp: (e) {
              setState(() {
                bookSelectIndex = null;
                Navigator.push(
                  _context,
                  MaterialPageRoute(
                    builder: (context) => BookDesc(),
                  ),
                );
              });
            },
            onTapCancel: () {
              setState(() {
                bookSelectIndex = null;
              });
            },
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  left: -2,
                  top: -2,
                  child: Container(
                    width: (width - reduceWidth) / count + 4,
                    height: 4.0 + ((width - reduceWidth) / count * 360) ~/ 250,
                    color: bookSelectIndex == bookshelf.indexOf(item) ? Colors.black : Colors.transparent,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black,
                    ),
                  ),
                  child: Image.asset(
                    'images/${item['img']}',
                  ),
                ),
                Positioned(
                  right: 1,
                  top: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        left: BorderSide(
                          color: Colors.black,
                        ),
                        bottom: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      right: 6,
                      left: 6,
                    ),
                    child: Text(
                      '更新',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                Positioned(
                  left: 1,
                  bottom: 1,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(
                          color: Colors.black,
                        ),
                        right: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(
                      top: 2,
                      bottom: 2,
                      right: 6,
                      left: 6,
                    ),
                    child: Text(
                      '已下载',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                )
              ],
            ),
          ),
          Text(
            '${item['name']}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              height: 1.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double top = mediaQuery.padding.top;
    width = mediaQuery.size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(bottom: 56),
              height: height - top,
              child: ListView(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                ),
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.black,
                                  ),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(40),
                                  ),
                                ),
                                width: 46,
                                height: 46,
                                child: ClipOval(
                                  child: Image.asset('images/yu.jpg'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                height: 46,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Text(
                                      '简单快乐',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Text(
                                      '无限卡110天',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            child: Row(
                              children: <Widget>[
                                Text(
                                  '意见反馈',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(
                                  Icons.keyboard_arrow_right,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Wrap(
                    children: bookshelf.map<Widget>(
                      (item) {
                        return moreColumn(item, 3);
                      },
                    ).toList(),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 56,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.black),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    GestureDetector(
                      onTapDown: (e) {
                        _changeBottomIndex(0);
                      },
                      onTapUp: (e) {
                        _changeBottomIndex(null);
                      },
                      onTapCancel: () {
                        _changeBottomIndex(null);
                      },
                      child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 6, right: 6),
                        color: bottomIndex == 0 ? Colors.black : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back,
                              color: bottomIndex == 0 ? Colors.white : Colors.black,
                            ),
                            Text(
                              '返回',
                              style: TextStyle(
                                color: bottomIndex == 0 ? Colors.white : Colors.black,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (e) {
                        _changeBottomIndex(1);
                      },
                      onTapUp: (e) {
                        _changeBottomIndex(null);
                      },
                      onTapCancel: () {
                        _changeBottomIndex(null);
                      },
                      child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 6, right: 6),
                        color: bottomIndex == 1 ? Colors.black : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.cloud_download,
                              color: bottomIndex == 1 ? Colors.white : Colors.black,
                            ),
                            Text(
                              '下载到本地',
                              style: TextStyle(
                                color: bottomIndex == 1 ? Colors.white : Colors.black,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (e) {
                        _changeBottomIndex(2);
                      },
                      onTapUp: (e) {
                        _changeBottomIndex(null);
                      },
                      onTapCancel: () {
                        _changeBottomIndex(null);
                      },
                      child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 6, right: 6),
                        color: bottomIndex == 2 ? Colors.black : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.book,
                              color: bottomIndex == 2 ? Colors.white : Colors.black,
                            ),
                            Text(
                              '管理书架',
                              style: TextStyle(
                                color: bottomIndex == 2 ? Colors.white : Colors.black,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (e) {
                        _changeBottomIndex(3);
                      },
                      onTapUp: (e) {
                        _changeBottomIndex(null);
                      },
                      onTapCancel: () {
                        _changeBottomIndex(null);
                      },
                      child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 6, right: 6),
                        color: bottomIndex == 3 ? Colors.black : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_up,
                              color: bottomIndex == 3 ? Colors.white : Colors.black,
                            ),
                            Text(
                              '上一页',
                              style: TextStyle(
                                color: bottomIndex == 3 ? Colors.white : Colors.black,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTapDown: (e) {
                        _changeBottomIndex(4);
                      },
                      onTapUp: (e) {
                        _changeBottomIndex(null);
                      },
                      onTapCancel: () {
                        _changeBottomIndex(null);
                      },
                      child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 6, right: 6),
                        color: bottomIndex == 4 ? Colors.black : Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.keyboard_arrow_down,
                              color: bottomIndex == 4 ? Colors.white : Colors.black,
                            ),
                            Text(
                              '下一页',
                              style: TextStyle(
                                color: bottomIndex == 4 ? Colors.white : Colors.black,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
