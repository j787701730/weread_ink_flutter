import 'package:flutter/material.dart';
import 'package:weread_ink_flutter/book_desc.dart';

class TopList extends StatefulWidget {
  @override
  _TopListState createState() => _TopListState();
}

class _TopListState extends State<TopList> {
  int bottomIndex;
  int bookSelectIndex;

  _changeBottomIndex(val) {
    setState(() {
      bottomIndex = val;
    });
  }

  List topList = [
    {'img': 'top_1.jpg'},
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
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = mediaQuery.size.height;
    double top = mediaQuery.padding.top;
    double width = mediaQuery.size.width;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: height - top,
              margin: EdgeInsets.only(bottom: 56),
              child: ListView.builder(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  top: 24,
                ),
                itemBuilder: (context, index) {
                  return index == 0
                      ? Container(
                          height: 30,
                          margin: EdgeInsets.only(
                            bottom: 20,
                          ),
                          alignment: Alignment.centerLeft,
                          child: Image.asset(
                            'images/${topList[index]['img']}',
                            fit: BoxFit.contain,
                          ),
                        )
                      : Container(
                          margin: EdgeInsets.only(
                            bottom: 20,
                          ),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '$index',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                width: width / 5,
                                margin: EdgeInsets.only(
                                  right: 20,
                                ),
                                child: GestureDetector(
                                  onTapDown: (e) {
                                    setState(() {
                                      bookSelectIndex = index;
                                    });
                                  },
                                  onTapUp: (e) {
                                    setState(() {
                                      bookSelectIndex = null;
                                      Navigator.push(
                                        context,
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
                                          width: width / 5 + 4.0,
                                          height: 4.0 + (width / 5 * 360) ~/ 250,
                                          color: bookSelectIndex == index ? Colors.black : Colors.transparent,
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                          ),
                                        ),
                                        child: Image.asset(
                                          'images/${topList[index]['img']}',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      '${topList[index]['name']}',
                                      style: TextStyle(
                                        fontFamily: 'SourceHanSerifCN',
                                        fontSize: 18,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: 10,
                                        bottom: 10,
                                      ),
                                      child: Text(
                                        '钱锺书',
                                        style: TextStyle(),
                                      ),
                                    ),
                                    Row(
                                      children: <Widget>[
                                        Text('9.5'),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                        ),
                                        Icon(
                                          Icons.star,
                                          size: 16,
                                        ),
                                        Icon(
                                          Icons.star_border,
                                          size: 16,
                                        ),
                                        Text('256人点评'),
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                },
                itemCount: topList.length,
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                height: 56,
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    GestureDetector(
                      onTapDown: (e) {
                        _changeBottomIndex(0);
                      },
                      onTapUp: (e) {
                        _changeBottomIndex(null);
                        Navigator.pop(context);
                      },
                      onTapCancel: () {
                        _changeBottomIndex(null);
                      },
                      child: Container(
                        height: 55,
                        padding: EdgeInsets.only(left: 10, right: 10),
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
                    Row(
                      children: <Widget>[
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
                            padding: EdgeInsets.only(left: 10, right: 10),
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
                            padding: EdgeInsets.only(left: 10, right: 10),
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
