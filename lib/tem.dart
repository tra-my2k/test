import 'package:flutter/material.dart';
import 'package:line_chart/charts/line-chart.widget.dart';
import 'package:line_chart/model/line-chart.model.dart';
  // class ChartData {
  //       ChartData(this.x, this.y);
  //       final String x;
  //       final double? y;
  //     }

class temperatureChart extends StatelessWidget{

    List<LineChartModel> data = [
      LineChartModel(amount: 300, date: DateTime(2020, 1, 1)),
      LineChartModel(amount: 200, date: DateTime(2020, 1, 2)),
      LineChartModel(amount: 300, date: DateTime(2020, 1, 3)),
      LineChartModel(amount: 500, date: DateTime(2020, 1, 4)),
      LineChartModel(amount: 800, date: DateTime(2020, 1, 5)),
      LineChartModel(amount: 200, date: DateTime(2020, 1, 6)),
      LineChartModel(amount: 120, date: DateTime(2020, 1, 7)),
      LineChartModel(amount: 140, date: DateTime(2020, 1, 8)),
      LineChartModel(amount: 110, date: DateTime(2020, 1, 9)),
      LineChartModel(amount: 250, date: DateTime(2020, 1, 10)),
      LineChartModel(amount: 390, date: DateTime(2020, 1, 11)),
      LineChartModel(amount: 1300, date: DateTime(2020, 1, 12)),
      LineChartModel(amount: 300, date: DateTime(2020, 1, 1)),
      LineChartModel(amount: 200, date: DateTime(2020, 1, 2)),
      LineChartModel(amount: 300, date: DateTime(2020, 1, 3)),
      LineChartModel(amount: 500, date: DateTime(2020, 1, 4)),
      LineChartModel(amount: 800, date: DateTime(2020, 1, 5)),
      LineChartModel(amount: 200, date: DateTime(2020, 1, 6)),
      LineChartModel(amount: 120, date: DateTime(2020, 1, 7)),
      LineChartModel(amount: 140, date: DateTime(2020, 1, 8)),
    ];
  @override
  Widget build(BuildContext context) {

    Paint circlePaint = Paint()
    ..color = Colors.white;
    Paint insideCirclePaint = Paint()..color = Colors.white;

    Paint linePaint = Paint()
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..color = Color.fromARGB(255, 241, 228, 106);


    return Container (
      padding: EdgeInsets.only(top: 30),
      child: 
        Column(
          children: [
            Row( 
              children: [
                Expanded(flex: 1, child: Text('Dự báo theo giờ', style: TextStyle(color: Colors.white),)),
                // Spacer(flex: 2,),
                TextButton(
                  onPressed: (){}, 
                  child: Text('Thêm', style: TextStyle(color: Colors.white,decoration: TextDecoration.underline, fontWeight: FontWeight.normal),)
                ),  
              ],
            ),

                  
            Container(
              height: 200,
              margin: EdgeInsets.only(bottom: 30),
              padding: EdgeInsets.all( 20),
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 16, 4, 59).withOpacity(0.7),
                // border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(20)),
              
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                          timeIcon(),
                        ],
                      ),

                      

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Text(
                          //   'Line chart - Line, Circles, Pointer',
                          //   style: Theme.of(context).textTheme.headline5,
                          // ),
                          LineChart(
                            width: 500,
                            height: 50,
                            data: data,
                            linePaint: linePaint,
                            circlePaint: circlePaint,
                            showPointer: true,
                            showCircles: true,
                            customDraw: (Canvas canvas, Size size) {},
                            linePointerDecoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            pointerDecoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color.fromARGB(255, 56, 27, 27),
                            ),
                            insideCirclePaint: insideCirclePaint,
                            onValuePointer: (LineChartModelCallback value) {
                              print('${value.chart} ${value.percentage}');
                            },
                            onDropPointer: () {
                              print('onDropPointer');
                            },
                            insidePadding: 16,
                          ),
                        ],
                      ),


                    ],
                  )
                ],
              ),
            )
          ]
        ),
    );
  }


Widget timeIcon(){
 return Container(
  width: 25,
  child: Row(
    children: [
      Text('20',)
    ],
  ),
 ); 
}
}

// class timeIcon {
//   final now = DateTime.now();
//   final later = now.add(const Duration(hours: 36));
// }






        