import 'package:flutter/material.dart';

class BookContent extends StatefulWidget {
  @override
  _BookContentState createState() => _BookContentState();
}

class _BookContentState extends State<BookContent> {
  String content =
      '''世上谁人能不死？任你风华绝代，艳冠天下，到头来也是红粉骷髅；任你一代天骄，坐拥万里江山，到头来也终将化成一?g黄土！长生不老，是所有人都渴望的。但是没有不老的红颜，也没有不朽的帝王，红颜天骄与芸芸众生一般无二，都难以逃脱生老病死，没有人能够永生于这个世间。不过，关于长生不死的传说却始终流传于世。

        达摩、独孤求败、西门吹雪、李寻欢、师妃暄、???⒗朔?啤⑴影摺⑶孛窝???br>
        一个个名传千古的名字，像古老的魔咒不断的激励着后人，让人们相信长生不死并非绝对荒谬，有些人是可以达到那一领域的。

        只是，时间最是无情，随着岁月的流逝，曾经不朽的传说，也渐渐磨灭在时间的长河中。

        直至沉寂无尽岁月后，奇迹在平淡中再次爆发！

        十五月圆之夜，一代天骄神女兰诺，将在昆仑红尘峰斩断尘缘，破碎虚空而去，天下修者莫不震惊，长生之说再成热论。

        近几日，昆仑山涌来十几万人，上至王公贵族，下至贩夫走卒，遍及三教九流，他们都拥有同样一个目的，将要见证一场千古难得一现的神迹。

        终于到了月圆之日，巍巍昆仑，壮阔秀丽，在皎洁的月色下，仿佛笼罩上了一层朦胧的轻纱，让这片圣山如同仙境一般飘渺。

        月夜中，萧晨奔跑如风，满身都是血迹，就连乌黑的长发都被血水染红了。但是如刀削般的英俊面容满是不屈之色，一双如星辰般明亮的眸子，更是透射着坚毅的光芒。

        他正在进行生死大逃亡！

        皇家天女赵琳儿誓要诛灭他，率数十名修者四方围剿。天女面遮轻纱，身材婀娜，曲线曼妙，眸若秋水，翩若惊鸿，似浮光掠影一般轻灵，如谪仙临尘一般飘逸。

        无路可逃，萧晨向红尘峰冲去！

        月夜下，红尘峰附近人山人海，满山遍野皆是人影，不过十几万人聚集在一起，却是如此的安静，所有人都在静静的仰望着红尘峰上那个白衣女子。

        绝巅之上，兰诺一身白衣胜雪，在月华的笼罩下，她的仙躯仿佛透发着淡淡圣洁的光辉，白色衣裙随风拂动，真如那不食人间烟火的广寒仙子一般。

        这半个月以来，她两次试破虚空，不过都在功成的刹那，收回了迈出的那只脚。

        一步之遥，她将永生天地间！

        但是，如若跨出那一步，漫漫红尘，都将永离她而去，从此断绝一切尘缘！

        拔慧剑斩尘缘，这需要莫大的勇气！因为走出那一步，在以后无尽的长生岁月中，等待她的也许将是无尽的孤寂。

        天心难测，仙情如霜！

        今日，已经从清晨站到现在，红尘种种一一浮现于她心间，终于到了挥别尘世的时候。一道道炽烈的神光，突然爆发于绝巅之上，整片山巅都笼罩上了一层无比圣洁的光辉。

        兰诺冰肌玉骨，在圣洁的霞光中，她是如此的出尘与高洁，在万众仰视中，虚空破碎了，她纵容而坚定的向前迈步而去。

        在最后的一刹那，她回眸向红尘望了最后一眼，那如梦似幻的仙颜，永远的留在了世人的心间，十几万人齐声呼喊兰诺的名字。

        不过整齐的呼喊声很快散乱了，人们发现山巅之上两条快速奔跑的身影，竟然随着兰诺一同破碎虚空而去！

        九州史记载，七三一六年，一代天骄神女兰诺武破虚空而去，皇家天女赵琳儿有幸结仙缘，随同进入长生界。

        至于萧晨，则无缘载入史册中。

        在破碎虚空而去的刹那，萧晨当真是震惊到了极点！

        他从来没有想到过有这样一天，竟然会以这种方式通往长生界。在那一瞬间他想到了很多，家人、朋友……都将永别了，他将永远的离开这个尘世。

        生死大逃亡，竟然会是这样一个结果。对于许多人来说，破碎虚空进入长生界，那是千古荣耀。但是萧晨却情愿放弃这种机会，他是如此的眷恋这个尘世，父母、亲人……永别了！他无言挥别红尘。

        萧晨并不知道，皇家天女赵琳儿也同样破碎虚空而去。
  
  ''';
  List<Map<String, int>> pageConfig = [];

  getPageOffsets(String content, double height, double width, double fontSize) {
    String tempStr = content;
    pageConfig = [];
    int last = 0;
    while (true) {
      Map<String, int> offset = {};
      offset['start'] = last;
      TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
      textPainter.text = TextSpan(
        text: tempStr,
        style: TextStyle(
            fontSize: fontSize,
            height: 10.5,
//        SettingManager.getInstance().getLetterHeight(),
            letterSpacing: 1
//        SettingManager.getInstance().getLetterSpacing(),
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
      pageConfig.add(offset);
    }
//    return pageConfig;
    print(pageConfig);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPageOffsets(content, 2560, 1440, 14.0);
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Container(
              child: Text(
                '${content.substring(pageConfig[0]['start'], pageConfig[0]['end'])}',
                style: TextStyle(height: 1.5),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
