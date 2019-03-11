import 'package:bmi_calculator/models/gender.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/models/pageType.dart';
import '../config/widget_utils.dart' show screenAwareSize;
import 'package:bmi_calculator/calculator.dart' as calculator;
import 'package:bmi_calculator/theme/page_styles.dart';
import 'package:bmi_calculator/widgets/bmi_app_bar.dart';

class IconBtn {
  bool isActive;
  final String toolTip;
  final IconData icon;
  IconBtn(this.isActive, this.icon, this.toolTip);
}

class ResultPage extends StatefulWidget {
  final int height;
  final int weight;
  final Gender gender;

  const ResultPage({Key key, this.height, this.weight, this.gender})
      : super(key: key);
  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<IconBtn> buttons = new List<IconBtn>();
  @override
  void initState() {
    buttons.add(new IconBtn(false, Icons.delete, 'delete'));
    buttons.add(new IconBtn(true, Icons.refresh, 'calculate again'));
    buttons.add(new IconBtn(false, Icons.share, 'share'));
    super.initState();
  }

  Widget _drawButtons() {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: List.generate(buttons.length, (index) {
        return new InkWell(
          onTap: () {
            setState(() {
              buttons.forEach((button) => button.isActive = false);
              buttons[index].isActive = true;
            });
            Navigator.of(context).pop();
          },
          child: new BottomButton(buttons[index]),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight(context)),
        child: BmiAppBar(
          pageType: PageType.result,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(screenAwareSize(16.0, context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            ResultCard(
              bmi: calculator.calculateBMI(
                  height: widget.height, weight: widget.weight),
              minWeight:
                  calculator.calculateMinNormalWeight(height: widget.height),
              maxWeight:
                  calculator.calculateMaxNormalWeight(height: widget.height),
            ),
            _drawButtons()
          ],
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  final IconBtn _button;
  BottomButton(this._button);

  @override
  Widget build(BuildContext context) {
    Decoration decoration = BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(5.0),
      color: _button.isActive ? Theme.of(context).primaryColor : Colors.white,
    );

    return Container(
      height: 50.0,
      width: 80.0,
      decoration: decoration,
      child: Icon(
        _button.icon,
        color: _button.isActive
            ? Colors.white
            : Color.fromRGBO(200, 200, 200, 1.0),
        size: 28.0,
      ),
    );
  }
}

class ResultCard extends StatelessWidget {
  final double bmi;
  final double minWeight;
  final double maxWeight;

  ResultCard({Key key, this.bmi, this.minWeight, this.maxWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.only(
            top: screenAwareSize(32.0, context),
            bottom: screenAwareSize(16.0, context)),
        child: Column(
          children: <Widget>[
            Text(
              '🔥',
              style: TextStyle(fontSize: 50.0),
            ),
            Text(
              this.bmi.toStringAsFixed(1),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 80.0),
            ),
            Text(
              'BMI = ${bmi.toStringAsFixed(2)} kg/m2',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
            ),
            Text(
              'Normal BMI range for the height: \n ${minWeight.round()}kg - ${maxWeight.round()}kg',
              style: TextStyle(
                  height: 1.5,
                  color: Color.fromRGBO(200, 200, 200, 1.0),
                  fontSize: 12.0),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
