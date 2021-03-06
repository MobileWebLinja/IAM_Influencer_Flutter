import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_kazee5/utils/CustomSlider.dart';
import 'package:flutter_app_kazee5/utils/color.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app_kazee5/utils/value.dart';

class Filter_upcoming extends StatefulWidget {
  Filter_upcoming({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _Filter_upcoming createState() => _Filter_upcoming();
}

class _Filter_upcoming extends State<Filter_upcoming>
    with AutomaticKeepAliveClientMixin<Filter_upcoming> {
  @override
  bool get wantKeepAlive => true;
  String filter_url =
      "https://web.iam.id/iam-mobile/api/influencer/filter-campaign";
  double minValue = 0;
  double maxValue = 10000;
  final startController = TextEditingController();
  final endController = TextEditingController();
  List<String> selectedChoices_state = [
    "ongoing",
    "finished",
  ];
  List<String> selectedChoices_category = [
    "Parenting",
    "Entertaiment",
    "Health & Sport",
    "Lifestyle & Travel",
    "Fashion",
    "Technology",
    "Beauty",
    "Food",
    "Other"
  ];
  List<String> selectedChoices_gender = [
    "Male",
    "Female",
  ];
  @override
  void initState() {
    super.initState();
    startController.addListener(_setStartValue);
    startController.text = starValue.toString();
    endController.addListener(_setEndValue);
    endController.text = endValue.toString();
  }

  _setStartValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        starValue = double.parse(startController.text).toInt();
      });
    }
    print("Second text field: ${startController.text}");
  }

  _setEndValue() {
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        endValue = double.parse(endController.text).toInt();
      });
    }
    print("Second text field: ${endController.text}");
  }

  @override
  Widget build(BuildContext context) {
    List<String> kategori = [
      "Parenting",
      "Entertaiment",
      "Health & Sport",
      "Lifestyle & Travel",
      "Fashion",
      "Technology",
      "Beauty",
      "Food",
      "Other"
    ];
    List<String> status = [
      "ongoing",
      "finished",
    ];
    List<String> gender = [
      "Male",
      "Female",
    ];

    var size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          centerTitle: true,
          title: Text("Filter Campaign ",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: size.width / 22)),
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: kLinearGradient),
          ),
          actions: [
            Container(
              margin: EdgeInsets.only(
                top: size.width / 150,
                right: size.width / 10,
              ),
              alignment: Alignment.center,
              child: InkWell(
                  child: Text(
                    "Clear",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: size.width / 22),
                  ),
                  onTap: () {
                    setState(() {
                      upcoming_selectedChoices_state.clear();
                      upcoming_selectedChoices_gender.clear();
                      upcoming_selectedChoices_category.clear();
                      starValue = 0;
                      endValue = 0;
                      startController.text = starValue.toString();
                      endController.text = endValue.toString();
                    });
                  }),
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Center(
              child: Column(
            children: [
              SizedBox(
                height: size.height / 15,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 20,
                  ),
                  Text("Katgori", style: TextStyle(fontSize: size.width / 22)),
                ],
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Container(
                margin: EdgeInsets.only(
                  left: size.width / 20,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: MultiSelectChip_category(
                    kategori,
                    onSelectionChanged: (selectedList) {
                      setState(() {
                        upcoming_selectedReportList_category = selectedList;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 20,
                  ),
                  Text("Status", style: TextStyle(fontSize: size.width / 22)),
                ],
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: size.width / 20,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: MultiSelectChip_status(
                    status,
                    onSelectionChanged: (selectedList) {
                      setState(() {
                        upcoming_selectedReportList_status = selectedList;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 20,
                  ),
                  Text("Gender", style: TextStyle(fontSize: size.width / 22)),
                ],
              ),
              SizedBox(
                height: size.height / 50,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  left: size.width / 20,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: MultiSelectChip_gender(
                    gender,
                    onSelectionChanged: (selectedList) {
                      setState(() {
                        upcoming_selectedReportList_gender = selectedList;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: size.height / 20,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 15,
                  ),
                  Text("Followers",
                      style: TextStyle(fontSize: size.width / 22)),
                ],
              ),
              SizedBox(
                height: size.height / 40,
              ),
              Row(
                children: [
                  SizedBox(
                    width: size.width / 20,
                  ),
                  Container(
                    height: size.height / 30,
                    width: size.width / 3.5,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: startController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kSelectedLabelColor,
                          fontSize: size.height / 50),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  ),
                  Text("  -  "),
                  Container(
                    height: size.height / 30,
                    width: size.width / 3.5,
                    alignment: Alignment.center,
                    child: TextField(
                      controller: endController,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: kSelectedLabelColor,
                          fontSize: size.height / 50),
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        disabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: Colors.grey)),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: size.height / 30),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  activeTrackColor: kSelectedLabelColor,
                  inactiveTrackColor: Colors.grey[300],
                  trackHeight: 3.0,
                  thumbShape: CustomSliderThumbCircle(thumbRadius: 12.0),
                  thumbColor: kSelectedLabelColor,
                  overlayColor: kSelectedLabelColor.withAlpha(50),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
                ),
                child: RangeSlider(
                  values: RangeValues(
                      starValue.roundToDouble(), endValue.roundToDouble()),
                  min: minValue,
                  max: maxValue,
                  onChanged: (values) {
                    setState(() {
                      starValue = values.start.toInt();
                      endValue = values.end.toInt();
                      startController.text = values.start.toInt().toString();
                      endController.text = values.end.toInt().toString();
                    });
                  },
                ),
              ),
              SizedBox(
                height: size.height / 30,
              ),
              GestureDetector(
                onTap: () {},
                child: Container(
                    width: size.width / 1.7,
                    height: size.height / 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(60),
                        gradient: kLinearGradient),
                    child: InkWell(
                      child: Center(
                        child: Text("Save",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: size.height / 40,
                            )),
                      ),
                      onTap: () {
                        // print('"'+upcoming_selectedReportList_status.reduce((value, element) => value + ',' + element)+'"');
                        // print('"'+upcoming_selectedReportList_category.reduce((value, element) => value + ',' + element)+'"');
                        // print('"'+upcoming_selectedReportList_gender.reduce((value, element) => value + ',' + element)+'"');
                        // print('"'+starValue.toInt().toString()+"-"+endValue.toInt().toString()+'"');
                        http.post(filter_url, body: {
                          "status": (upcoming_selectedReportList_status
                                      .length ==
                                  0)
                              ? ""
                              : upcoming_selectedReportList_status.reduce(
                                  (value, element) => value + ',' + element),
                          "category": (upcoming_selectedReportList_category
                                      .length ==
                                  0)
                              ? ""
                              : upcoming_selectedReportList_category.reduce(
                                  (value, element) => value + ',' + element),
                          "gender": (upcoming_selectedReportList_gender
                                      .length ==
                                  0)
                              ? ""
                              : upcoming_selectedReportList_gender.reduce(
                                  (value, element) => value + ',' + element),
                          "followers": (starValue).toString() +
                              "-" +
                              (endValue).toString()
                        }).then((response) {
                          print(response.body);
                          var convertDataToJson = jsonDecode(response.body);
                          data_upcoming = convertDataToJson['data'];
                          if (data_upcoming != null) {
                            if ((5 >= data_upcoming.length)) {
                              print("good");
                              items_upcoming.clear();
                              items_upcoming.addAll(data_upcoming);
                              present_upcoming = data_upcoming.length;
                            } else {
                              items_upcoming.clear();
                              items_upcoming
                                  .addAll(data_upcoming.getRange(0, 5));
                              present_upcoming = 5;
                            }
                          }
                          Navigator.pop(context);
                        });
                      },
                    )),
              )
            ],
          )),
        ));
  }
}

class SliderCustomShape {}

class MultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip(this.reportList, {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChipState createState() => _MultiSelectChipState();
}

class _MultiSelectChipState extends State<MultiSelectChip> {
  // String selectedChoice = "";
  List<String> selectedChoices = List();
  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          padding:
              const EdgeInsets.only(top: 6.0, bottom: 6, left: 10, right: 10),
          label: Text(
            item,
            style: TextStyle(
                fontSize: 16,
                color: selectedChoices.contains(item)
                    ? Colors.white
                    : Colors.black38),
          ),
          selected: selectedChoices.contains(item),
          selectedColor: kSelectedLabelColor,
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

//status part
class MultiSelectChip_status extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip_status(this.reportList, {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChipState_status createState() => _MultiSelectChipState_status();
}

class _MultiSelectChipState_status extends State<MultiSelectChip_status> {
  // String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          padding:
              const EdgeInsets.only(top: 6.0, bottom: 6, left: 10, right: 10),
          label: Text(
            item,
            style: TextStyle(
                fontSize: 16,
                color: upcoming_selectedChoices_state.contains(item)
                    ? Colors.white
                    : Colors.black38),
          ),
          selected: upcoming_selectedChoices_state.contains(item),
          selectedColor: kSelectedLabelColor,
          onSelected: (selected) {
            setState(() {
              upcoming_selectedChoices_state.contains(item)
                  ? upcoming_selectedChoices_state.remove(item)
                  : upcoming_selectedChoices_state.add(item);
              widget
                  .onSelectionChanged(upcoming_selectedChoices_state); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

//category part
class MultiSelectChip_category extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip_category(this.reportList, {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChipState_category createState() =>
      _MultiSelectChipState_category();
}

class _MultiSelectChipState_category extends State<MultiSelectChip_category> {
  // String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          padding:
              const EdgeInsets.only(top: 6.0, bottom: 6, left: 10, right: 10),
          label: Text(
            item,
            style: TextStyle(
                fontSize: 16,
                color: upcoming_selectedChoices_category.contains(item)
                    ? Colors.white
                    : Colors.black38),
          ),
          selected: upcoming_selectedChoices_category.contains(item),
          selectedColor: kSelectedLabelColor,
          onSelected: (selected) {
            setState(() {
              upcoming_selectedChoices_category.contains(item)
                  ? upcoming_selectedChoices_category.remove(item)
                  : upcoming_selectedChoices_category.add(item);
              widget.onSelectionChanged(
                  upcoming_selectedChoices_category); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}

//gender part
class MultiSelectChip_gender extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged; // +added
  MultiSelectChip_gender(this.reportList, {this.onSelectionChanged} // +added
      );
  @override
  _MultiSelectChip_gender createState() => _MultiSelectChip_gender();
}

class _MultiSelectChip_gender extends State<MultiSelectChip_gender> {
  // String selectedChoice = "";

  _buildChoiceList() {
    List<Widget> choices = List();
    widget.reportList.forEach((item) {
      choices.add(Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.all(3.0),
        child: ChoiceChip(
          padding:
              const EdgeInsets.only(top: 6.0, bottom: 6, left: 10, right: 10),
          label: Text(
            item,
            style: TextStyle(
                fontSize: 16,
                color: upcoming_selectedChoices_gender.contains(item)
                    ? Colors.white
                    : Colors.black38),
          ),
          selected: upcoming_selectedChoices_gender.contains(item),
          selectedColor: kSelectedLabelColor,
          onSelected: (selected) {
            setState(() {
              upcoming_selectedChoices_gender.contains(item)
                  ? upcoming_selectedChoices_gender.remove(item)
                  : upcoming_selectedChoices_gender.add(item);
              widget.onSelectionChanged(
                  upcoming_selectedChoices_gender); // +added
            });
          },
        ),
      ));
    });
    return choices;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }
}
