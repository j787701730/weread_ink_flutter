import 'package:flutter/material.dart';

class BookDesc extends StatefulWidget {
  @override
  _BookDescState createState() => _BookDescState();
}

class _BookDescState extends State<BookDesc> {
  double width;
  double height;
  bool fullScreen = false;
  String focusIndex;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  fullScreen = !fullScreen;
                });
              },
              child: Container(
                width: width,
                height: height,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        width: width,
                        color: Color(0xffEEECEA),
                      ),
                    ),
                    Container(
                      height: height * 28 / 64,
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 24,
              bottom: 24,
              right: 24,
              top: 24,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    fullScreen = !fullScreen;
                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffE0DFDE),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        20,
                      ),
                    ),
                  ),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: width / 3,
                                child: Image.asset('images/ia_100000007.jpg'),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 20,
                                  bottom: 10,
                                ),
                                child: Text(
                                  '一禅小和尚',
                                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '一禅小和尚',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: height * 28 / 64 - 24 - 2,
                        padding: EdgeInsets.only(
                          top: 30,
                          left: 30,
                          right: 30,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            '7.7',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 34,
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(bottom: 4),
                                            child: Row(
                                              children: <Widget>[
                                                Icon(
                                                  Icons.star,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  size: 20,
                                                ),
                                                Icon(
                                                  Icons.star_border,
                                                  size: 20,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        '332人点评',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Text(
                                            '1.3',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 34,
                                            ),
                                          ),
                                          Container(
                                            child: Text('万人'),
                                            padding: EdgeInsets.only(bottom: 8),
                                          )
                                        ],
                                      ),
                                      Text(
                                        '阅读此书',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                top: 20,
                                bottom: 10,
                              ),
                              child: Text(
                                '简介',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 40,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '一禅的人物设定为一个对世界有强烈好奇心、每天都能从生活中发现趣味和智慧哲学的暖萌小和尚。他的师父阿斗是一个不拘小节，偶尔鸡汤偶尔老童趣的出家人，一禅和他的师父生活在一座景色优美的寺庙里，周围的村庄里住着一群善良淳朴的人们。漫画以每篇以20格左右的水墨长条漫画展开故事剧情，在妙趣横生的日常故事中，展现纷繁世间的纯净真情，带给一禅、每一集的出场人物、也给读者讲述一个又一个意味深长的道理。',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    '更多',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: Offstage(
                offstage: fullScreen,
                child: Container(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    bottom: 4,
                    top: 4,
                  ),
                  height: 56,
                  width: width,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            onHighlightChanged: (val) {
                              setState(() {
                                focusIndex = val ? 't1' : null;
                                if (!val) {}
                              });
                            },
                            highlightColor: Colors.black,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 26,
                                    child: Image.asset('images/font.jpg'),
                                  ),
                                  Text(
                                    '文字',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: focusIndex == 't1' ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            onHighlightChanged: (val) {
                              setState(() {
                                focusIndex = val ? 't2' : null;
                                if (!val) {}
                              });
                            },
                            highlightColor: Colors.black,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 26,
                                    child: Image.asset('images/download.jpg'),
                                  ),
                                  Text(
                                    '下载到本地',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: focusIndex == 't2' ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            onHighlightChanged: (val) {
                              setState(() {
                                focusIndex = val ? 't3' : null;
                                if (!val) {}
                              });
                            },
                            highlightColor: Colors.black,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 26,
                                    child: Image.asset('images/book.jpg'),
                                  ),
                                  Text(
                                    '已加入到书架',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: focusIndex == 't3' ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            onHighlightChanged: (val) {
                              setState(() {
                                focusIndex = val ? 't4' : null;
                                if (!val) {}
                              });
                            },
                            highlightColor: Colors.black,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 26,
                                    child: Image.asset('images/shop.jpg'),
                                  ),
                                  Text(
                                    '已购买',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: focusIndex == 't4' ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
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
              bottom: 0,
              left: 0,
              child: Offstage(
                offstage: fullScreen,
                child: Container(
                  height: 56,
                  width: width,
                  padding: EdgeInsets.only(
                    left: 24,
                    right: 24,
                    bottom: 4,
                    top: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            onHighlightChanged: (val) {
                              setState(() {
                                focusIndex = val ? 'b1' : null;
                                if (!val) {
                                  Navigator.pop(context);
                                }
                              });
                            },
                            highlightColor: Colors.black,
                            child: Container(
                              color: Colors.transparent,
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 26,
                                    child: Image.asset('images/back.jpg'),
                                  ),
                                  Text(
                                    '返回',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: focusIndex == 'b1' ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            onHighlightChanged: (val) {
                              setState(() {
                                focusIndex = val ? 'b2' : null;
                                if (!val) {}
                              });
                            },
                            highlightColor: Colors.black,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 26,
                                    child: Image.asset('images/process.jpg'),
                                  ),
                                  Text(
                                    '进度',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: focusIndex == 'b2' ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Material(
                          color: Colors.white,
                          child: InkWell(
                            onTap: () {},
                            onHighlightChanged: (val) {
                              setState(() {
                                focusIndex = val ? 'b3' : null;
                                if (!val) {}
                              });
                            },
                            highlightColor: Colors.black,
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    height: 26,
                                    child: Image.asset('images/menu.jpg'),
                                  ),
                                  Text(
                                    '目录',
                                    style: TextStyle(
                                      fontSize: 12,
                                      height: 1.4,
                                      color: focusIndex == 'b3' ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
