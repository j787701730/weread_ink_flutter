import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weread_ink_flutter/book_content.dart';

class BookDesc extends StatefulWidget {
  @override
  _BookDescState createState() => _BookDescState();
}

class _BookDescState extends State<BookDesc> {
  double width;
  double height;
  bool fullScreen = false;
  bool processState = true;
  bool openMore = true;
  String focusIndex;
  String moreOrClose;
  double _process = 0.0;

  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 200), () {
//      SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    });
  }

  @override
  void dispose() {
    super.dispose();
//    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    double top = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                setState(() {
                  fullScreen = !fullScreen;
                  processState = true;
                });
              },
              child: Container(
                width: width,
                height: height - top,
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
                    processState = true;
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
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    fullScreen = true;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BookContent(),
                                    ),
                                  );
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black,
                                    ),
                                  ),
                                  width: width / 3,
                                  child: Image.asset('images/t6_25684283.jpg'),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 20,
                                  bottom: 10,
                                ),
                                child: Text(
                                  '三国演义',
                                  style: TextStyle(
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SourceHanSerifCN',
                                  ),
                                ),
                              ),
                              Container(
                                child: Text(
                                  '罗贯中',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'SourceHanSerifCN',
                                  ),
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
                              crossAxisAlignment: CrossAxisAlignment.end,
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
                                        style: TextStyle(height: 1.3),
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
                                        style: TextStyle(height: 1.3),
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
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Text(
                                    '本书采用清毛纶、毛宗岗父子的评改本为底本，主要校以明嘉靖刊本《三国志通俗演义》。另外，清代以来流行的毛本的各种翻版多曾参看，人民文学出版社本《三国演义》的整理成果多曾吸收。书中的人名、地名及职官名等，据中华书局点校本《三国志》及谭其骧主编之《中国历史地图集》作了校订。',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20,
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
                                  child: InkWell(
                                    onTap: () {},
                                    onHighlightChanged: (val) {
                                      setState(() {
                                        if (val) {
                                          moreOrClose = 'more';
                                        } else {
                                          moreOrClose = null;
                                          if (!fullScreen) {
                                            fullScreen = !fullScreen;
                                          } else {
                                            openMore = !openMore;
                                          }
                                        }
                                      });
                                    },
                                    highlightColor: Colors.black,
                                    child: Text(
                                      '更多',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: moreOrClose == 'more' ? Colors.white : Colors.black,
                                      ),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Material(
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
                            padding: EdgeInsets.symmetric(horizontal: 15),
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
                      Material(
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
                            padding: EdgeInsets.symmetric(horizontal: 15),
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
                      Material(
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
                            padding: EdgeInsets.symmetric(horizontal: 15),
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
                      Material(
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
                            padding: EdgeInsets.symmetric(horizontal: 15),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {},
                        onTapDown: (val) {
                          setState(() {
                            focusIndex = 'b1';
                          });
                        },
                        onTapUp: (c) {
                          setState(() {
                            focusIndex = null;
                            Navigator.pop(context);
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            focusIndex = null;
                          });
                        },
                        child: Container(
                          color: focusIndex == 'b1' ? Colors.black : Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 15),
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
                      GestureDetector(
                        onTap: () {},
                        onTapDown: (c) {
                          setState(() {
                            focusIndex = 'b2';
                          });
                        },
                        onTapUp: (e) {
                          setState(() {
                            focusIndex = null;
                            processState = !processState;
                          });
                        },
                        onTapCancel: () {
                          setState(() {
                            focusIndex = null;
                          });
                        },
                        child: Container(
                          color: focusIndex == 'b2' ? Colors.black : Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 15),
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
                      Material(
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
                            padding: EdgeInsets.symmetric(horizontal: 15),
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
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 56,
              child: Offstage(
                offstage: processState,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  height: 120,
                  width: width,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text('2分钟'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Icon(
                            Icons.keyboard_arrow_left,
                            size: 40,
                            color: _process == 0.0 ? Colors.grey : Colors.black,
                          ),
                          Container(
                            width: width * 0.6,
                            child: CupertinoSlider(
                              value: _process,
                              min: 0,
                              max: 100,
                              onChanged: (val) {
                                setState(() {
                                  _process = val;
                                });
                              },
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.keyboard_arrow_right,
                              size: 40,
                              color: _process == 100.0 ? Colors.grey : Colors.black,
                            ),
                          ),
                        ],
                      ),
                      Text('版权信息'),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              top: 0,
              right: 0,
              bottom: 0,
              child: Offstage(
                offstage: openMore,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      openMore = !openMore;
                    });
                  },
                  child: Container(
                    color: Color(0x99999999),
                    alignment: Alignment.center,
                    child: Container(
                      height: height * 0.7,
                      width: width - 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            20,
                          ),
                        ),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                '简介',
                                style: TextStyle(
                                  fontSize: 24,
                                ),
                              ),
                              Material(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {},
                                  highlightColor: Colors.black,
                                  onHighlightChanged: (val) {
                                    setState(() {
                                      if (val) {
                                        moreOrClose = 'close';
                                      } else {
                                        openMore = !openMore;
                                        moreOrClose = null;
                                      }
                                    });
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: moreOrClose == 'close' ? Colors.white : Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 10,
                          ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Text(
                                '本书采用清毛纶、毛宗岗父子的评改本为底本，主要校以明嘉靖刊本《三国志通俗演义》。另外，清代以来流行的毛本的各种翻版多曾参看，人民文学出版社本《三国演义》的整理成果多曾吸收。书中的人名、地名及职官名等，据中华书局点校本《三国志》及谭其骧主编之《中国历史地图集》作了校订。',
                                style: TextStyle(
                                  fontSize: 16,
                                  height: 1.5,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
