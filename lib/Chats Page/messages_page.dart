import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:uny_app/Chats%20Page/chat_page.dart';

class ChatsPage extends StatefulWidget{

  @override
  _ChatsPageState createState() => _ChatsPageState();
}


class _ChatsPageState extends State<ChatsPage> with SingleTickerProviderStateMixin{

  late double height;
  late double width;

  bool _isSearching = false;

  TabController? _tabController;


  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
       height = constraints.maxHeight;
       width = constraints.maxWidth;
       return ResponsiveWrapper.builder(
           Scaffold(
             extendBodyBehindAppBar: false,
             body: mainBody(),
           ),
         maxWidth: 800,
         minWidth: 450,
         defaultScale: true,
         breakpoints: [
           ResponsiveBreakpoint.resize(450, name: MOBILE),
           ResponsiveBreakpoint.autoScale(800, name: MOBILE),
         ],
       );
      },
    );
  }

  Widget mainBody(){
    return Column(
      children: [
        SizedBox(height: height / 15),
        Container(
          height: height / 20,
          padding: EdgeInsets.symmetric(horizontal: width / 20),
          child: TextFormField(
            cursorColor: Color.fromRGBO(145, 10, 251, 5),
            textAlign: TextAlign.center,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.only(bottom: height / 50),
              filled: true,
              fillColor: Colors.grey.withOpacity(0.1),
              prefixIcon: _isSearching != true
                  ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.search, color: Colors.grey),
                  Text('Поиск сообщений',
                      style: TextStyle(
                          fontSize: 17, color: Colors.grey))
                ],
              )
                  : null,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(color: Colors.grey.withOpacity(0.1))),
            ),
            onTap: () {
              setState(() {
                _isSearching = true;
              });
            },

            onChanged: (value){
              if (value.length == 0) {
                setState(() {
                  _isSearching = false;
                });
              } else {
                setState(() {
                  _isSearching = true;
                });
              }
            },
          ),
        ),
        SizedBox(height: 10),
        TabBar(
          controller: _tabController,
          indicatorColor: Color.fromRGBO(145, 10, 251, 5),
          labelColor: Color.fromRGBO(145, 10, 251, 5),
          unselectedLabelColor: Colors.grey,
          padding: EdgeInsets.symmetric(horizontal: width / 10),
          tabs: [
            Tab(
                text: 'Недавние',
            ),
            Tab(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Text('Запросы'),
                  SizedBox(width: 10),
                  ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      height: 20,
                      width: 40,
                      child: Center(
                        child: Text(
                          '99+',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(255, 83, 155, 5),
                                Color.fromRGBO(237, 48, 48, 5)
                              ]
                          )
                      ),
                    ),
                  )
                ],
              )
            )
          ],
        ),
        Container(
          height: height / 1.22,
          child: TabBarView(
            controller: _tabController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Container(
                child: recentMessages()
              ),
              Container(
                child: messageRequests(),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget recentMessages(){
    return ListView.separated(
      itemCount: 10,
      physics: RangeMaintainingScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.withOpacity(0.7),
          indent: height / 13,
          height: 1,
          thickness: 0.5,
        );
      },
      itemBuilder: (context, index){
        return InkWell(
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserChatPage())
            );
          },
           child: Container(
             height: height / 11,
             width: width,
             child: Stack(
               children: [
                 Container(
                     padding: EdgeInsets.only(top: 10, left: 10),
                     child: Center(
                       child: Stack(
                         alignment: Alignment.centerLeft,
                         children: [
                           Align(
                             alignment: Alignment.centerLeft,
                             child: Container(
                               height: height / 10,
                               width: width / 7,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   shape: BoxShape.circle,
                                   image: DecorationImage(
                                       image: AssetImage('assets/video_search_sample_pic.png'),
                                       fit: BoxFit.cover,
                                       filterQuality: FilterQuality.high
                                   ),
                                   border: Border.all(
                                     color: Colors.deepOrange,
                                     width: 3,
                                   )
                               ),
                             ),
                           ),
                           Padding(
                             padding: EdgeInsets.symmetric(horizontal: 12),
                             child: Align(
                               alignment: Alignment.bottomLeft,
                               heightFactor: 5,
                               child: Container(
                                 padding: EdgeInsets.symmetric(horizontal: 3),
                                 child: Text('31 %', style: TextStyle(
                                     color: Colors.white)),
                                 decoration: BoxDecoration(
                                   color: Colors.deepOrange,
                                   borderRadius: BorderRadius.all(
                                       Radius.circular(10)),
                                 ),
                               ),
                             ),
                           )
                         ],
                       ),
                     )
                 ),
                 SizedBox(width: 10),
                 Positioned(
                   top: height / 60,
                   left: width / 5.5,
                   child: Text('Милена С.',
                       style: TextStyle(fontWeight: FontWeight.bold)),
                 ),
                 Positioned(
                   top: height / 60,
                   left: width / 1.11,
                   child: Text('15:20', style: TextStyle(color: Colors.grey)),
                 ),
                 Positioned(
                     top: height / 26,
                     left: width / 5.5,
                     child: Container(
                       width: width / 2,
                       child: Text(
                         'Да, тогда до завтра 🐹 Я еще тортик и сок захвачу то...',
                         style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                         maxLines: 2,
                       ),
                     )
                 ),
               ],
             ),
           ),
        );
      },
    );
  }

  Widget messageRequests() {
    return ListView.separated(
      itemCount: 10,
      physics: RangeMaintainingScrollPhysics(),
      separatorBuilder: (context, index) {
        return Divider(
          color: Colors.grey.withOpacity(0.7),
          indent: height / 13,
          height: 1,
          thickness: 0.5,
        );
      },
      itemBuilder: (context, index) {
        return Slidable(
          key: ValueKey(index),
          startActionPane: null,
          endActionPane: ActionPane(
            extentRatio: 0.7,
            motion: DrawerMotion(),
            // dismissible: DismissiblePane(
            //   onDismissed: () {},
            // ),
            children: [
              SlidableAction(
                icon: Icons.check,
                backgroundColor: Color.fromRGBO(16, 174, 83, 10),
                onPressed: (context) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UserChatPage()
                      )
                  );
                },
                label: 'Принять',
              ),
              SlidableAction(
                icon: Icons.block_flipped,
                backgroundColor: Color.fromRGBO(68, 13, 102, 10),
                onPressed: null,
                label: 'Блок.',
              ),
              SlidableAction(
                icon: Icons.delete_forever_outlined,
                backgroundColor: Colors.red,
                onPressed: null,
                label: 'Удалить',
              ),
            ],
          ),
          child: Container(
            height: height / 11,
            width: width,
            child: Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.centerLeft,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            height: height / 10,
                            width: width / 7,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/sample_pic.png'),
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high
                                ),
                                border: Border.all(
                                  color: Colors.green,
                                  width: 3,
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 13.1),
                          child: Align(
                            alignment: Alignment.bottomLeft,
                            heightFactor: 5,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 3),
                              child: Text('64 %', style: TextStyle(
                                  color: Colors.white)),
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.all(
                                    Radius.circular(10)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ),
                SizedBox(width: 10),
                Positioned(
                  top: height / 60,
                  left: width / 5.5,
                  child: Text('Кристина З.',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                Positioned(
                  top: height / 60,
                  left: width / 1.11,
                  child: Text('15:20', style: TextStyle(color: Colors.grey)),
                ),
                Positioned(
                    top: height / 26,
                    left: width / 5.5,
                    child: Container(
                      width: width / 2,
                      child: Text(
                        'Проспорила вчера в карты и сделала огромную татуху с 🍆 ...',
                        style: TextStyle(color: Colors.grey.withOpacity(0.8)),
                        maxLines: 2,
                      ),
                    )
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
