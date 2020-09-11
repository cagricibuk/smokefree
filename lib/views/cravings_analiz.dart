import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class BarChartSample3 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => BarChartSample3State();
}

class BarChartSample3State extends State<BarChartSample3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Analiz"),
      ),
      body: Column(
        children: [
          Card(
            child: Container(
              color: Colors.lightGreen,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Eylül 1.Hafta",
                    style: TextStyle(fontSize: 26, color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  AspectRatio(
                    aspectRatio: 1.7,
                    child: Card(
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                      color: Colors.lightGreen,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 20,
                          barTouchData: BarTouchData(
                            enabled: false,
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.transparent,
                              tooltipPadding: const EdgeInsets.all(0),
                              tooltipBottomMargin: 8,
                              getTooltipItem: (
                                BarChartGroupData group,
                                int groupIndex,
                                BarChartRodData rod,
                                int rodIndex,
                              ) {
                                return BarTooltipItem(
                                  rod.y.round().toString(),
                                  TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              },
                            ),
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: SideTitles(
                              showTitles: true,
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14),
                              margin: 20,
                              getTitles: (double value) {
                                switch (value.toInt()) {
                                  case 0:
                                    return 'Mn';
                                  case 1:
                                    return 'Te';
                                  case 2:
                                    return 'Wd';
                                  case 3:
                                    return 'Tu';
                                  case 4:
                                    return 'Fr';
                                  case 5:
                                    return 'St';
                                  case 6:
                                    return 'Sn';
                                  default:
                                    return '';
                                }
                              },
                            ),
                            leftTitles: SideTitles(showTitles: false),
                          ),
                          borderData: FlBorderData(
                            show: false,
                          ),
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(y: 8, color: Colors.white)
                            ], showingTooltipIndicators: [
                              0
                            ]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(y: 10, color: Colors.white)
                            ], showingTooltipIndicators: [
                              0
                            ]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(y: 6, color: Colors.white)
                            ], showingTooltipIndicators: [
                              0
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(y: 15, color: Colors.white)
                            ], showingTooltipIndicators: [
                              0
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(y: 13, color: Colors.white)
                            ], showingTooltipIndicators: [
                              0
                            ]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(y: 10, color: Colors.white)
                            ], showingTooltipIndicators: [
                              0
                            ]),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
