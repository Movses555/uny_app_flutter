import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:random_color/random_color.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:universal_platform/universal_platform.dart';
import 'package:uny_app/Interests%20Model/career_interests_model.dart';
import 'package:uny_app/Interests%20Model/family_interests_model.dart';
import 'package:uny_app/Interests%20Model/general_interests_model.dart';
import 'package:uny_app/Interests%20Model/sport_interests_model.dart';
import 'package:uny_app/Interests%20Model/travelling_interests_model.dart';

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  RandomColor _randomColor = RandomColor();

  int _familyInterestsCounter = 0;
  int _careerInterestsCounter = 0;
  int _sportInterestsCounter = 0;
  int _travelingInterestsCounter = 0;
  int _generalInterestsCounter = 0;

  late FamilyInterests familyInterests;
  late CareerInterests careerInterests;
  late SportInterests sportInterests;
  late TravelingInterests travelingInterests;
  late GeneralInterests generalInterests;

  late double height;
  late double width;

  List<String>? _familyInterestsList = [];
  List<String>? _careerInterestsList = [];
  List<String>? _sportInterestsList = [];
  List<String>? _travelingInterestsList = [];
  List<String>? _generalInterestsList = [];

  List<String> _selectedFamilyInterests = [];
  List<String> _selectedCareerInterests = [];
  List<String> _selectedSportInterests = [];
  List<String> _selectedTravelingInterests = [];
  List<String> _selectedGeneralInterests = [];

  List<String> _familyFilteredList = [];
  List<String> _careerFilteredList = [];
  List<String> _sportFilteredList = [];
  List<String> _travelingFilteredList = [];
  List<String> _generalFilteredList = [];

  List<Color> _familyInterestsColor = [];
  List<Color> _careerInterestsColor = [];
  List<Color> _sportInterestsColor = [];
  List<Color> _travelingInterestsColor = [];
  List<Color> _generalInterestsColor = [];

  List<Widget>? _familyInterestsWidgetList;
  List<Widget>? _careerInterestsWidgetList;
  List<Widget>? _sportInterestsWidgetList;
  List<Widget>? _travelingInterestsWidgetList;
  List<Widget>? _generalInterestsWidgetList;

  double _selectedFamilyInterestsValue = 0.0;
  double _selectedCareerInterestsValue = 0.0;
  double _selectedSportInterestsValue = 0.0;
  double _selectedTravelingInterestsValue = 0.0;
  double _selectedGeneralInterestsValue = 0.0;

  bool _isSearching = false;

  bool _isFamilyEnabled = true;
  bool _isCareerEnabled = false;
  bool _isSportEnabled = false;
  bool _isTravelingEnabled = false;
  bool _isGeneralEnabled = false;

  bool _isCareerIconEnabled = false;
  bool _isSportIconEnabled = false;
  bool _isTravelingIconEnabled = false;
  bool _isGeneralIconEnabled = false;

  FocusNode? addNewInterestFieldFocusNode;
  TextEditingController? newInterestFieldTextController;

  @override
  void initState() {
    super.initState();

    addNewInterestFieldFocusNode = FocusNode();
    newInterestFieldTextController = TextEditingController();

    familyInterests = FamilyInterests.init();
    careerInterests = CareerInterests.init();
    sportInterests = SportInterests.init();
    travelingInterests = TravelingInterests.init();
    generalInterests = GeneralInterests.init();

    _familyInterestsList = familyInterests.getFamilyInterests();
    _familyFilteredList = _familyInterestsList!;

    _careerInterestsList = careerInterests.getCareerInterests();
    _careerFilteredList = _careerInterestsList!;

    _sportInterestsList = sportInterests.getSportInterests();
    _sportFilteredList = _sportInterestsList!;

    _travelingInterestsList = travelingInterests.getTravellingInterests();
    _travelingFilteredList = _travelingInterestsList!;

    _generalInterestsList = generalInterests.getGeneralInterests();
    _generalFilteredList = _generalInterestsList!;

    for (int i = 0; i < _familyInterestsList!.length; ++i) {
      _familyInterestsColor.add(_randomColor.randomColor(
          colorHue: ColorHue.custom(Range(120, 130)),
          colorSaturation: ColorSaturation.mediumSaturation,
          colorBrightness: ColorBrightness.primary));
    }

    for (int i = 0; i < _careerInterestsList!.length; ++i) {
      _careerInterestsColor.add(_randomColor.randomColor(
          colorHue: ColorHue.custom(Range(180, 190)),
          colorSaturation: ColorSaturation.highSaturation,
          colorBrightness: ColorBrightness.primary));
    }

    for (int i = 0; i < _sportInterestsList!.length; ++i) {
      _sportInterestsColor.add(_randomColor.randomColor(
          colorHue: ColorHue.custom(Range(200, 220)),
          colorSaturation: ColorSaturation.highSaturation,
          colorBrightness: ColorBrightness.primary));
    }

    for (int i = 0; i < _travelingInterestsList!.length; ++i) {
      _travelingInterestsColor.add(_randomColor.randomColor(
          colorHue: ColorHue.custom(Range(10, 40)),
          colorSaturation: ColorSaturation.highSaturation,
          colorBrightness: ColorBrightness.light));
    }

    for (int i = 0; i < _generalInterestsList!.length; ++i) {
      _generalInterestsColor.add(_randomColor.randomColor(
          colorHue: ColorHue.custom(Range(240, 315)),
          colorSaturation: ColorSaturation.highSaturation,
          colorBrightness: ColorBrightness.light));
    }

    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      if (UniversalPlatform.isIOS) {
        await showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return popup18PlusAttentionWidget();
            });
      } else if (UniversalPlatform.isAndroid) {
        await showModalBottomSheet(
            context: context,
            builder: (context) {
              return popup18PlusAttentionWidget();
            });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();

    addNewInterestFieldFocusNode = null;
    newInterestFieldTextController = null;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _familyInterestsWidgetList = List.generate(_familyFilteredList.length, (index) {
      return Material(
        child: InkWell(
          onTap: () {
            _selectedFamilyInterests.add(_familyFilteredList[index]);
            _selectedFamilyInterestsValue += 0.01;
            ++_familyInterestsCounter;

            setState((){});
          },
          borderRadius:
          BorderRadius.all(Radius.circular(30)),
          child: Chip(
            elevation: 5.0,
            visualDensity: VisualDensity.comfortable,
            padding: EdgeInsets.all(10),
            backgroundColor: _familyInterestsColor[index],
            shadowColor: Colors.grey,
            label: Text(
              _familyFilteredList[index],
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    });

    _careerInterestsWidgetList = List.generate(_careerFilteredList.length,
            (index) {
          return Material(
            child: InkWell(
              onTap: () {
                _selectedCareerInterests.add(_careerFilteredList[index]);
                _selectedCareerInterestsValue += 0.01;
                ++_careerInterestsCounter;

                setState((){});
              },
              borderRadius:
              BorderRadius.all(Radius.circular(30)),
              child: Chip(
                elevation: 5.0,
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.all(10),
                backgroundColor: _careerInterestsColor[index],
                shadowColor: Colors.grey,
                label: Text(
                  _careerFilteredList[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });

    _sportInterestsWidgetList = List.generate(_sportFilteredList.length,
            (index) {
          return Material(
            child: InkWell(
              onTap: () {
                _selectedSportInterests.add(_sportFilteredList[index]);
                _selectedSportInterestsValue += 0.01;
                ++_sportInterestsCounter;

                setState((){});
              },
              borderRadius:
              BorderRadius.all(Radius.circular(30)),
              child: Chip(
                elevation: 5.0,
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.all(10),
                backgroundColor: _sportInterestsColor[index],
                shadowColor: Colors.grey,
                label: Text(
                  _sportFilteredList[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });

    _travelingInterestsWidgetList = List.generate(_travelingFilteredList.length,
            (index) {
          return Material(
            child: InkWell(
              onTap: () {
                _selectedTravelingInterests.add(_travelingFilteredList[index]);
                _selectedTravelingInterestsValue += 0.01;
                ++_travelingInterestsCounter;

                setState((){});
              },
              borderRadius:
              BorderRadius.all(Radius.circular(30)),
              child: Chip(
                elevation: 5.0,
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.all(10),
                backgroundColor: _travelingInterestsColor[index],
                shadowColor: Colors.grey,
                label: Text(
                  _travelingFilteredList[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });

    _generalInterestsWidgetList = List.generate(_generalFilteredList.length,
            (index) {
          return Material(
            child: InkWell(
              onTap: () {
                _selectedGeneralInterests.add(_generalFilteredList[index]);
                _selectedGeneralInterestsValue += 0.01;
                ++_generalInterestsCounter;

                setState((){});
              },
              borderRadius:
              BorderRadius.all(Radius.circular(30)),
              child: Chip(
                elevation: 5.0,
                visualDensity: VisualDensity.comfortable,
                padding: EdgeInsets.all(10),
                backgroundColor: _generalInterestsColor[index],
                shadowColor: Colors.grey,
                label: Text(
                  _generalFilteredList[index],
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        height = constraints.maxHeight;
        width = constraints.maxWidth;
        return ResponsiveWrapper.builder(
            Scaffold(
              extendBodyBehindAppBar: true,
              appBar: AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.grey),
                  onPressed: () => Navigator.pop(context),
                ),
                title: Container(
                  height: height / 20,
                  padding: EdgeInsets.only(right: width / 20),
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
                                Text('Поиск интересов',
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
                    onChanged: (value) {
                      if(_isFamilyEnabled){
                        _familyFilteredList = _familyInterestsList!.where((interest) => interest.toLowerCase().startsWith(value.toLowerCase())).toList();
                      }else if(_isCareerEnabled){
                        _careerFilteredList = _careerInterestsList!.where((interest) => interest.toLowerCase().startsWith(value.toLowerCase())).toList();
                      }else if(_isSportEnabled){
                        _sportFilteredList = _sportInterestsList!.where((interest) => interest.toLowerCase().startsWith(value.toLowerCase())).toList();
                      }else if(_isTravelingEnabled){
                        _travelingFilteredList = _travelingInterestsList!.where((interest) => interest.toLowerCase().startsWith(value.toLowerCase())).toList();
                      }else{
                        _generalFilteredList = _generalInterestsList!.where((interest) => interest.toLowerCase().startsWith(value.toLowerCase())).toList();
                      }

                      didChangeDependencies();

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
                centerTitle: true,
              ),
              body: mainBody(),
            ),
            defaultScale: true,
            breakpoints: [
              const ResponsiveBreakpoint.resize(480, name: MOBILE),
              const ResponsiveBreakpoint.autoScale(720, name: MOBILE)
            ]);
      },
    );
  }

  Widget mainBody() {
    return Wrap(
      children: [
        Container(
            padding: EdgeInsets.only(
                top: height / 7, left: width / 20, bottom: height / 30),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _openFamilyInterests(),
                        child: Row(
                          children: [Container(
                            height: 35,
                            width: 35,
                            child: Icon(Icons.lock_open, color: Colors.white),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.green,
                            ),
                          ),
                            SizedBox(width: 5),
                            Text('Семья',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),],
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: width / 8,
                        height: 2,
                        color: _isCareerIconEnabled
                            ? Colors.green
                            : Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(width: 5)
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _isCareerIconEnabled ?
                        _openCareerInterests() : null,
                        child: Row(
                          children: [
                            _isCareerIconEnabled
                                ? Container(
                              height: 35,
                              width: 35,
                              child: Icon(Icons.lock_open, color: Colors.white),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.lightBlue,
                              ),
                            )
                                : Icon(CupertinoIcons.lock_circle_fill,
                                color: Colors.grey, size: 40),
                            SizedBox(width: 5),
                            Text('Карьера',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),],
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: width / 8,
                        height: 2,
                        color: _isSportIconEnabled
                            ? Colors.lightBlue
                            : Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _isSportIconEnabled ?
                        _openSportInterests() : null,
                        child: Row(
                          children: [
                            _isSportIconEnabled
                                ? Container(
                              height: 35,
                              width: 35,
                              child: Icon(Icons.lock_open, color: Colors.white),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.blueAccent,
                              ),
                            )
                                : Icon(CupertinoIcons.lock_circle_fill,
                                color: Colors.grey, size: 40),
                            SizedBox(width: 5),
                            Text('Спорт',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: width / 8,
                        height: 2,
                        color: _isTravelingIconEnabled
                            ? Colors.blueAccent
                            : Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _isTravelingIconEnabled ?
                        _openTravelingInterests() : null,
                        child: Row(
                          children: [
                            _isTravelingIconEnabled
                                ? Container(
                              height: 35,
                              width: 35,
                              child: Icon(Icons.lock_open, color: Colors.white),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange,
                              ),
                            )
                                : Icon(CupertinoIcons.lock_circle_fill,
                                color: Colors.grey, size: 40),
                            SizedBox(width: 5),
                            Text('Путешествия',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                      Container(
                        width: width / 8,
                        height: 2,
                        color: _isGeneralIconEnabled
                            ? Colors.orange
                            : Colors.grey.withOpacity(0.5),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: () => _isGeneralIconEnabled
                            ? _openGeneralInterests() : null,
                        child: Row(
                          children: [
                            _isGeneralIconEnabled
                                ? Container(
                              height: 35,
                              width: 35,
                              child: Icon(Icons.lock_open, color: Colors.white),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurpleAccent,
                              ),
                            )
                                : Icon(CupertinoIcons.lock_circle_fill,
                                color: Colors.grey, size: 40),
                            SizedBox(width: 5),
                            Text('Общее',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                          ],
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            )),
        AnimatedSwitcher(
          duration: Duration(seconds: 1),
          transitionBuilder: (child, animation){
            return SlideTransition(
              position: Tween<Offset>(begin: Offset(1.2, 0), end: Offset(0, 0))
                  .animate(animation),
              child: child,
            );
          },
          child: _isCareerEnabled
              ? careerInterestsGridView()
              : _isSportEnabled
              ? sportInterestsGridView()
              : _isTravelingEnabled
              ? travelingInterestsGridView()
              : _isGeneralEnabled
              ? generalInterestsGridView()
              : _isFamilyEnabled
              ? familyInterestsGridView()
              : null
        ),
      ],
    );
  }

  Widget familyInterestsGridView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width * 0.78,
                height: 26,
                padding: EdgeInsets.only(left: width / 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      children: [
                        Container(
                          height: height,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.green[100],
                            color: Colors.green,
                            value: _selectedFamilyInterestsValue,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            '${_familyInterestsCounter}',
                            style: TextStyle(fontSize: 15, color: Colors.green),
                          ),
                        )
                      ],
                    ))),
            InkWell(
              onTap: _selectedFamilyInterests.length != 0 ? () {
                setState(() {
                  _isCareerEnabled = true;
                  _isCareerIconEnabled = true;

                  _isFamilyEnabled = false;
                });
              } : null,
              child: Container(
                height: 50,
                width: 100,
                child: Center(
                  child: Text('Далее',
                      style: TextStyle(
                          fontSize: 15, color:
                      Colors.white)),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          _selectedFamilyInterests.length != 0 ?
                         Colors.deepPurpleAccent : Colors.grey,
                          _selectedFamilyInterests.length != 0 ?
                         Colors.blueAccent : Colors.grey
                      ])),
              ),
            )
          ],
        ),
        SizedBox(height: height / 100),
        _selectedFamilyInterests.length == 0
            ? Center(
                child: Text(
                  'Выберите минимум один интерес для продолжения',
                  style: TextStyle(
                      fontSize: 15, color: Colors.grey.withOpacity(0.7)),
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: List.generate(_selectedFamilyInterests.length, (index) {
                      return Material(
                        child: InkWell(
                          borderRadius: BorderRadius.all(Radius.circular(30)),
                          child: Chip(
                            labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                            elevation: 3.0,
                            visualDensity: VisualDensity.comfortable,
                            padding: EdgeInsets.all(10),
                            backgroundColor: _familyInterestsColor[index],
                            shadowColor: Colors.grey,
                            label: Text(
                              _selectedFamilyInterests[index],
                              style: TextStyle(color: Colors.white),
                            ),
                            deleteIcon: Icon(CupertinoIcons.clear_circled,
                                color: Colors.white),
                            onDeleted: () {
                              _selectedFamilyInterests.removeAt(index);
                              _selectedFamilyInterestsValue -= 0.01;
                              --_familyInterestsCounter;

                              setState((){});
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
        SizedBox(height: height / 100),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        _familyFilteredList.length != 0 ? SizedBox(
            height: height / 1.4,
            child: SafeArea (
              top: false,
              child: SingleChildScrollView (
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView (
                    scrollDirection: Axis.horizontal,
                    child: Container (
                      padding: EdgeInsets.only(left: 10),
                      width: width * 2,
                      child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: _familyInterestsWidgetList!
                      ),
                    )),
              ),
            )) : AnimatedPadding(
                duration: Duration(milliseconds: 150),
                padding: EdgeInsets.symmetric(
                    vertical:  height / 5,
                    horizontal: width / 10),
                child: Column(
                  children: [
                    Text(
                      'По вашему запросу не найдено подходящего интереса. Вы можете добавить новый вручную',
                      maxLines: 2,
                      style: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                    addInterestsWidget()
                  ],
                )
        )
      ],
    );
  }

  Widget careerInterestsGridView(){
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width * 0.78,
                height: 26,
                padding: EdgeInsets.only(left: width / 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      children: [
                        Container(
                          height: height,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.blue[100],
                            color: Color.fromRGBO(1, 188, 248, 5),
                            value: _selectedCareerInterestsValue,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            '${_careerInterestsCounter}',
                            style: TextStyle(fontSize: 15, color: Color.fromRGBO(1, 188, 248, 5)),
                          ),
                        )
                      ],
                    ))),
            InkWell(
              onTap: _selectedCareerInterests.length != 0 ? (){
                setState(() {
                  _isSportEnabled = true;
                  _isSportIconEnabled = true;

                  _isCareerEnabled = false;
                });
              } : null,
              child: Container(
                height: 50,
                width: 100,
                child: Center(
                  child: Text('Далее',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          _selectedCareerInterests.length != 0 ? Colors.deepPurpleAccent : Colors.grey,
                          _selectedCareerInterests.length != 0 ? Colors.blueAccent : Colors.grey])),
              ),
            )
          ],
        ),
        SizedBox(height: height / 100),
        _selectedCareerInterests.length == 0
            ? Center(
          child: Text(
            'Выберите минимум один интерес для продолжения',
            style: TextStyle(
                fontSize: 15, color: Colors.grey.withOpacity(0.7)),
          ),
        ) : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List.generate(_selectedCareerInterests.length, (index) {
                return Material(
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Chip(
                      labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      elevation: 3.0,
                      visualDensity: VisualDensity.comfortable,
                      padding: EdgeInsets.all(10),
                      backgroundColor: _careerInterestsColor[index],
                      shadowColor: Colors.grey,
                      label: Text(
                        _selectedCareerInterests[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      deleteIcon: Icon(CupertinoIcons.clear_circled,
                          color: Colors.white),
                      onDeleted: () {
                        _selectedCareerInterests.removeAt(index);
                        _selectedCareerInterestsValue -= 0.01;
                        --_careerInterestsCounter;

                        setState((){});
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: height / 100),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        _careerFilteredList.length != 0 ? SizedBox(
            height: height / 1.4,
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      width: width * 2,
                      child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: _careerInterestsWidgetList!
                      ),
                    )),
              ),
            )) : AnimatedPadding(
            duration: Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(
                vertical:  height / 5,
                horizontal: width / 10),
            child: Column(
              children: [
                Text(
                  'По вашему запросу не найдено подходящего интереса. Вы можете добавить новый вручную',
                  maxLines: 2,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                addInterestsWidget()
              ],
            )
        )
      ],
    );
  }

  Widget sportInterestsGridView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width * 0.78,
                height: 26,
                padding: EdgeInsets.only(left: width / 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      children: [
                        Container(
                          height: height,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.blueAccent.withOpacity(0.3),
                            color: Colors.blueAccent,
                            value: _selectedSportInterestsValue,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            '${_sportInterestsCounter}',
                            style: TextStyle(fontSize: 15, color: Colors.blueAccent),
                          ),
                        )
                      ],
                    ))),
            InkWell(
              onTap: _selectedSportInterests.length != 0 ? (){
                setState(() {
                  _isSportEnabled = false;

                  _isTravelingEnabled = true;
                  _isTravelingIconEnabled = true;
                });
              } : null,
              child: Container(
                height: 50,
                width: 100,
                child: Center(
                  child: Text('Далее',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          _selectedSportInterests.length != 0 ? Colors.deepPurpleAccent : Colors.grey,
                          _selectedSportInterests.length != 0 ? Colors.blueAccent : Colors.grey
                        ])),
              ),
            )
          ],
        ),
        SizedBox(height: height / 100),
        _selectedSportInterests.length == 0
            ? Center(
          child: Text(
            'Выберите минимум один интерес для продолжения',
            style: TextStyle(
                fontSize: 15, color: Colors.grey.withOpacity(0.7)),
          ),
        )
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List.generate(_selectedSportInterests.length, (index) {
                return Material(
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Chip(
                      labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      elevation: 3.0,
                      visualDensity: VisualDensity.comfortable,
                      padding: EdgeInsets.all(10),
                      backgroundColor: _sportInterestsColor[index],
                      shadowColor: Colors.grey,
                      label: Text(
                        _selectedSportInterests[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      deleteIcon: Icon(CupertinoIcons.clear_circled,
                          color: Colors.white),
                      onDeleted: () {
                        _selectedSportInterests.removeAt(index);
                        _selectedSportInterestsValue -= 0.01;
                        --_sportInterestsCounter;

                        setState((){});
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: height / 100),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        _sportFilteredList.length != 0 ? SizedBox(
            height: height / 1.4,
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      width: width * 2,
                      child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: _sportInterestsWidgetList!
                      ),
                    )),
              ),
            )) : AnimatedPadding(
            duration: Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(
                vertical:  height / 5,
                horizontal: width / 10),
            child: Column(
              children: [
                Text(
                  'По вашему запросу не найдено подходящего интереса. Вы можете добавить новый вручную',
                  maxLines: 2,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                addInterestsWidget()
              ],
            )
        )
      ],
    );
  }

  Widget travelingInterestsGridView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width * 0.78,
                height: 26,
                padding: EdgeInsets.only(left: width / 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      children: [
                        Container(
                          height: height,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.orange.withOpacity(0.3),
                            color: Colors.orange,
                            value: _selectedTravelingInterestsValue,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            '${_travelingInterestsCounter}',
                            style: TextStyle(fontSize: 15, color: Colors.orange),
                          ),
                        )
                      ],
                    ))),
            InkWell(
              onTap: _selectedTravelingInterests.length != 0 ? (){
                setState(() {
                  _isTravelingEnabled = false;

                  _isGeneralEnabled = true;
                  _isGeneralIconEnabled= true;
                });
              } : null,
              child: Container(
                height: 50,
                width: 100,
                child: Center(
                  child: Text('Далее',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          _selectedTravelingInterests.length != 0 ? Colors.deepPurpleAccent : Colors.grey,
                          _selectedTravelingInterests.length != 0 ? Colors.blueAccent : Colors.grey
                        ])),
              ),
            )
          ],
        ),
        SizedBox(height: height / 100),
        _selectedTravelingInterests.length == 0
            ? Center(
          child: Text(
            'Выберите минимум один интерес для продолжения',
            style: TextStyle(
                fontSize: 15, color: Colors.grey.withOpacity(0.7)),
          ),
        )
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List.generate(_selectedTravelingInterests.length, (index) {
                return Material(
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Chip(
                      labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      elevation: 3.0,
                      visualDensity: VisualDensity.comfortable,
                      padding: EdgeInsets.all(10),
                      backgroundColor: _travelingInterestsColor[index],
                      shadowColor: Colors.grey,
                      label: Text(
                        _selectedTravelingInterests[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      deleteIcon: Icon(CupertinoIcons.clear_circled,
                          color: Colors.white),
                      onDeleted: () {
                        _selectedTravelingInterests.removeAt(index);
                        _selectedTravelingInterestsValue -= 0.01;
                        --_travelingInterestsCounter;

                        setState((){});
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: height / 100),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        _travelingFilteredList.length != 0 ? SizedBox(
            height: height / 1.4,
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      width: width * 2,
                      child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: _travelingInterestsWidgetList!
                      ),
                    )),
              ),
            )) : AnimatedPadding(
            duration: Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(
                vertical:  height / 5,
                horizontal: width / 10),
            child: Column(
              children: [
                Text(
                  'По вашему запросу не найдено подходящего интереса. Вы можете добавить новый вручную',
                  maxLines: 2,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                addInterestsWidget()
              ],
            )
        )
      ],
    );
  }

  Widget generalInterestsGridView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
                width: width * 0.78,
                height: 26,
                padding: EdgeInsets.only(left: width / 20),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    child: Stack(
                      children: [
                        Container(
                          height: height,
                          child: LinearProgressIndicator(
                            backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
                            color: Colors.deepPurpleAccent,
                            value: _selectedGeneralInterestsValue,
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 10),
                          child: Text(
                            '${_generalInterestsCounter}',
                            style: TextStyle(fontSize: 15, color: Colors.deepPurpleAccent),
                          ),
                        )
                      ],
                    ))),
            InkWell(
              onTap: _selectedGeneralInterests.length != 0 ? (){

              } : null,
              child: Container(
                height: 50,
                width: 100,
                child: Center(
                  child: Text('Готово',
                      style: TextStyle(fontSize: 15, color: Colors.white)),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                        colors: [
                          _selectedGeneralInterests.length != 0 ? Colors.deepPurpleAccent : Colors.grey,
                          _selectedGeneralInterests.length != 0 ? Colors.blueAccent : Colors.grey
                        ])),
              ),
            )
          ],
        ),
        SizedBox(height: height / 100),
        _selectedGeneralInterests.length == 0
            ? Center(
          child: Text(
            'Выберите минимум один интерес для продолжения',
            style: TextStyle(
                fontSize: 15, color: Colors.grey.withOpacity(0.7)),
          ),
        )
            : SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            padding: EdgeInsets.only(bottom: 5),
            child: Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: List.generate(_selectedGeneralInterests.length, (index) {
                return Material(
                  child: InkWell(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                    child: Chip(
                      labelPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
                      elevation: 3.0,
                      visualDensity: VisualDensity.comfortable,
                      padding: EdgeInsets.all(10),
                      backgroundColor: _generalInterestsColor[index],
                      shadowColor: Colors.grey,
                      label: Text(
                        _selectedGeneralInterests[index],
                        style: TextStyle(color: Colors.white),
                      ),
                      deleteIcon: Icon(CupertinoIcons.clear_circled,
                          color: Colors.white),
                      onDeleted: () {
                        _selectedGeneralInterests.removeAt(index);
                        _selectedGeneralInterestsValue -= 0.01;
                        --_generalInterestsCounter;

                        setState((){});
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
        SizedBox(height: height / 100),
        Divider(
          thickness: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        _generalFilteredList.length != 0 ? SizedBox(
            height: height / 1.4,
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Container(
                      padding: EdgeInsets.only(left: 10),
                      width: width * 2,
                      child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: _generalInterestsWidgetList!
                      ),
                    )),
              ),
            )) : AnimatedPadding(
            duration: Duration(milliseconds: 150),
            padding: EdgeInsets.symmetric(
                vertical:  height / 5,
                horizontal: width / 10),
            child: Column(
              children: [
                Text(
                  'По вашему запросу не найдено подходящего интереса. Вы можете добавить новый вручную',
                  maxLines: 2,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                ),
                addInterestsWidget()
              ],
            )
        )
      ],
    );
  }

  Widget popup18PlusAttentionWidget() {
    return Material(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      child: Container(
        padding: EdgeInsets.only(top: 15),
        height: height / 3,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: width / 8),
                  Text('Раздел 18+',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(CupertinoIcons.clear_thick_circled),
                    color: Colors.grey.withOpacity(0.5),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 15, right: 20),
              child: Text(
                'Этот раздел содержит материалы, которые могут носить деликатный характер. Желаете продолжить?',
                maxLines: 3,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.only(top: height / 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 150,
                    height: 48,
                    child: Material(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height * 0.10,
                          child: Center(
                              child: Text('Отмена',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17))),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                  ),
                  SizedBox(width: 12),
                  Container(
                      alignment: Alignment.center,
                      width: 150,
                      height: 48,
                      child: Material(
                        borderRadius: BorderRadius.circular(11),
                        color: Color.fromRGBO(145, 10, 251, 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: height * 0.10,
                            child: Center(
                                child: Text('Продолжить',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17))),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget addInterestsWidget(){
    return Container(
      padding: EdgeInsets.only(top: height / 50, left: width / 10, right: width / 10),
      child: Material(
        borderRadius: BorderRadius.circular(11),
        color: Color.fromRGBO(145, 10, 251, 5),
        child: InkWell(
          onTap: () => showAddInterestSheet(),
          child: SizedBox(
            height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(CupertinoIcons.add_circled, color: Colors.white),
                  SizedBox(width: 5),
                  Text('Добавить новый интерес', style: TextStyle(fontSize: 17, color: Colors.white))
                ],
              )
          ),
        ),
      ),

    );
  }

  Widget newInterestsWidget(BuildContext sheetContext){
    return Material(
      borderRadius: BorderRadius.only(topLeft: Radius.circular(35), topRight: Radius.circular(35)),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        padding: EdgeInsets.only(top: 10),
        height: addNewInterestFieldFocusNode!.hasFocus ? height / 1.3 : height / 2,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(35), topRight: Radius.circular(35)),
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: width / 8),
                  Text('Новый интерес',
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  IconButton(
                    icon: Icon(CupertinoIcons.clear_thick_circled),
                    color: Colors.grey.withOpacity(0.5),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 15, right: 20),
              child: Text(
                'Новый интерес появится в вашем профиле после проверки модератором Uny',
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 17, color: Colors.grey),
              ),
            ),
            SizedBox(height: 32),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Название интереса', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: newInterestFieldTextController,
                    focusNode: addNewInterestFieldFocusNode,
                    cursorColor: Color.fromRGBO(145, 10, 251, 5),
                    style: TextStyle(color: Colors.grey),
                    decoration: InputDecoration(
                      fillColor: Colors.grey.withOpacity(0.2),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    onTap: () {
                      Focus.of(sheetContext).requestFocus(addNewInterestFieldFocusNode);
                    },
                    onEditingComplete: () {
                      addNewInterestFieldFocusNode!.unfocus();
                    }
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 180,
                    height: 48,
                    child: Material(
                      borderRadius: BorderRadius.circular(11),
                      color: Colors.white,
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: height * 0.10,
                          child: Center(
                              child: Text('Отмена',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 17))),
                        ),
                      ),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11),
                        border: Border.all(color: Colors.grey, width: 0.5)),
                  ),
                  SizedBox(width: 12),
                  Container(
                      alignment: Alignment.center,
                      width: 180,
                      height: 48,
                      child: Material(
                        borderRadius: BorderRadius.circular(11),
                        color: Color.fromRGBO(145, 10, 251, 5),
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            addNewInterest(newInterestFieldTextController!.text);
                          },
                          child: Container(
                            height: height * 0.10,
                            child: Center(
                                child: Text('Отправить',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 17))),
                          ),
                        ),
                      ))
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Text.rich(
                TextSpan(
                  text: 'Нажимая "Отправить", вы подтверждаете согласие с ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                        text: 'условиями использования UnyApp',
                        style: TextStyle(color: Colors.blue)
                    )
                  ],
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }

  void addNewInterest(String value){
    if(_isFamilyEnabled){
      setState(() {
        _selectedFamilyInterests.add(value);
        _selectedFamilyInterestsValue += 0.01;

        ++_familyInterestsCounter;
      });
    }else if(_isCareerEnabled){
      setState(() {
        _selectedCareerInterests.add(value);
        _selectedCareerInterestsValue += 0.01;

        ++_careerInterestsCounter;
      });
    }else if(_isSportEnabled){
      setState(() {
        _selectedSportInterests.add(value);
        _selectedSportInterestsValue += 0.01;

        ++_sportInterestsCounter;
      });
    }else if(_isTravelingEnabled){
      setState(() {
        _selectedTravelingInterests.add(value);
        _selectedTravelingInterestsValue += 0.01;

        ++_travelingInterestsCounter;
      });
    }else if(_isGeneralEnabled){
      setState(() {
        _selectedGeneralInterests.add(value);
        _selectedGeneralInterestsValue += 0.01;

        ++_generalInterestsCounter;
      });
    }
  }

  void showAddInterestSheet(){
    if(UniversalPlatform.isIOS){
      showCupertinoModalPopup(
        context: context,
        builder: (context) {
          return newInterestsWidget(context);
        }
      );
    }else if(UniversalPlatform.isAndroid){
      showModalBottomSheet(
        context: context,
        builder: (context){
          return newInterestsWidget(context);
        }
      );
    }
  }

  void _openFamilyInterests(){
    setState(() {
      _isFamilyEnabled = true;

      _isCareerEnabled = false;
      _isSportEnabled = false;
      _isTravelingEnabled = false;
      _isGeneralEnabled = false;
    });
  }

  void _openCareerInterests(){
    setState(() {
      _isCareerEnabled = true;

      _isFamilyEnabled = false;
      _isSportEnabled = false;
      _isTravelingEnabled = false;
      _isGeneralEnabled = false;
    });
  }

  void _openSportInterests(){
    setState(() {
      _isSportEnabled = true;

      _isCareerEnabled = false;
      _isFamilyEnabled = false;
      _isTravelingEnabled = false;
      _isGeneralEnabled = false;
    });
  }

  void _openTravelingInterests(){
    setState(() {
      _isTravelingEnabled = true;

      _isSportEnabled = false;
      _isCareerEnabled = false;
      _isFamilyEnabled = false;
      _isGeneralEnabled = false;
    });
  }

  void _openGeneralInterests(){
    setState(() {
      _isGeneralEnabled = true;

      _isTravelingEnabled = false;
      _isSportEnabled = false;
      _isCareerEnabled = false;
      _isFamilyEnabled = false;
    });
  }

  // Checking whether keyboard opened or closed
  bool isKeyboardClosed(){
    return MediaQuery.of(context).viewInsets.bottom == 0.0;
  }
}
