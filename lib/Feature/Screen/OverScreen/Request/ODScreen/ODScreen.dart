
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/LeaveAppbar.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/Leave/LeaveWidget/LeaveDetailWidget.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/ODScreen/ODWidget/NullODCustomActionSlideButton.dart';
import 'package:campuslink/Feature/Screen/OverScreen/Request/ODScreen/ODWidget/ODCustomActionSlideButton.dart';
import 'package:campuslink/Provider/StudenProvider.dart';
import 'package:campuslink/l10n/AppLocalization.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class ODScreen extends StatefulWidget {
  static const route = '/ODScreen';
  const ODScreen({Key? key}) : super(key: key);

  @override
  _ODScreenState createState() => _ODScreenState();
}

class _ODScreenState extends State<ODScreen>with SingleTickerProviderStateMixin {
  late final AnimationController controller;
  PickerDateRange? _selectedRange; // To store the selected date range


  @override
  void initState() {
    controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this
    );
    super.initState();
  }
  @override
  void dispose() {
    controller.dispose(); // Dispose of the AnimationController
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>;
    final credit = args['credit'];
    final color = args['color'] as Gradient;
    final student = Provider.of<StudentProvider>(context).user;
    return Scaffold(
      appBar: ODLeaveAppBar(
        context: context,
        text: S.current.booking
      ),
      body: ListView(
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          FadeInDown(
            child: Card(
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)
              ),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  gradient: color
                ),
                child: SfDateRangePicker(
                  minDate: DateTime.now(),
                  maxDate: DateTime.now().add(Duration(days: 30)),
                  enablePastDates: false,
                  selectionMode: DateRangePickerSelectionMode.range,
                  initialSelectedRange: PickerDateRange(DateTime.now(), DateTime.now()),
                  initialDisplayDate: DateTime.now(),
                  onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                    setState(() {
                      _selectedRange = args.value;
                    });
                    if(calculateTotalDaysSelected()<=2){
                      controller.animateTo(1);
                    }
                    else{
                      controller.animateTo(0.5);
                    }
                    //print(_selectedRange!.startDate);
                  },
                  headerStyle: DateRangePickerHeaderStyle(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                  ),
                  monthCellStyle: DateRangePickerMonthCellStyle(
                    todayTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    blackoutDateTextStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                    disabledDatesTextStyle: TextStyle(
                      color: Color.fromARGB(77, 243, 242, 242),
                      fontSize: 14.0,
                    ),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  yearCellStyle: DateRangePickerYearCellStyle(
                    disabledDatesTextStyle: TextStyle(
                      color: Color.fromARGB(77, 243, 242, 242),
                      fontSize: 14.0,
                    ),
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                    ),
                  ),
                  selectionColor: Colors.white,
                  rangeSelectionColor: Colors.white,
                  todayHighlightColor: Colors.blue, // Replace 'themeColor.backgroundColor' with your desired color
                  startRangeSelectionColor: Colors.green,
                  endRangeSelectionColor: Colors.deepOrangeAccent,
                ),
              ),
            ),
          ),
          //Diplay Total Credit You having
          FadeInLeft(child: LeaveDetailsWidget(text: S.current.credityouhave,hint: '${student.credit}',)),
          //Diplay per Credit 
          FadeInLeft(child: LeaveDetailsWidget(text: S.current.percredit,hint: '${credit}',)),
          //Diplay no of days selected
          FadeInLeft(child: LeaveDetailsWidget(text: S.current.totaldaysselected,hint: '${calculateTotalDaysSelected()}',)),
          //Calulate no of days selected and credit
          FadeInLeft(child: LeaveDetailsWidget(text: S.current.totalcredit,hint: '${calculateTotalDaysSelected() * credit}',)),
          // Container(
          //   alignment: Alignment.center,
          //   child: Lottie.asset('asset/lottie/house.json',height: 100,controller: controller))
        ],
      ),
      bottomNavigationBar: _selectedRange != null
    ? ODCustomActionSlideButton(
        daySelected: calculateTotalDaysSelected(),
        perCredit: credit,
        StudentCredit: student.credit,
        startDate: _selectedRange!.startDate,
        endDate: _selectedRange!.endDate,
        color: color,
      )
    : NullODCustomActionSlideButton(
        daySelected: calculateTotalDaysSelected(),
        perCredit: credit,
        StudentCredit: student.credit,
        color: color,
    )
    );
  }
  
int calculateTotalDaysSelected() {
    if (_selectedRange != null &&
        _selectedRange!.startDate != null &&
        _selectedRange!.endDate != null) {
      return _selectedRange!.endDate!
          .difference(_selectedRange!.startDate!)
          .inDays +
          1;
    } else {
      return 0; // No range selected
    }
  }
  }
