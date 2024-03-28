import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:test/features/daily_record/presentation/bloc/daily_record_bloc.dart';
import 'package:test/features/daily_record/presentation/widgets/activity_tile.dart';
import 'package:test/injection_container.dart';

class DailyRecordPage extends StatelessWidget {
  DailyRecordPage({super.key});

  final TooltipBehavior _tooltip = TooltipBehavior(enable: true);
  final List<ChartData> data = [
    ChartData('David', 25),
    ChartData('Steve', 38),
    ChartData('Jack', 34),
    ChartData('Others', 52)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (_) => sl<DailyRecordBloc>(),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 4.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              'https://media1.popsugar-assets.com/files/thumbor/MxMJ_P97HhqBQzeH5ihTqf5E6n4/0x0:1994x1994/fit-in/2048xorig/filters:format_auto-!!-:strip_icc-!!-/2022/06/23/778/n/48749861/2573842362b4a5c8321982.43571047_/i/dylan-obrien-dating.jpg',
                              height: 50,
                              width: 50,
                            ),
                          ),
                          const SizedBox(
                            width: 20.0,
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Day!',
                                style: TextStyle(
                                  fontSize: 17.0,
                                ),
                              ),
                              Text(
                                'John Dela Cruz',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          shape: BoxShape.circle,
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Icon(
                            Icons.calendar_month_outlined,
                            size: 24.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35.0),
                EasyDateTimeLine(
                  headerProps: const EasyHeaderProps(showHeader: false),
                  initialDate: DateTime.now(),
                  onDateChange: (selectedDate) {
                    //`selectedDate` the new date selected.
                  },
                ),
                const SizedBox(height: 25.0),
                const Text(
                  'Daily Record',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 320,
                  child: SfCircularChart(
                    annotations: const [
                      CircularChartAnnotation(
                        widget: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Total',
                              style: TextStyle(
                                color: Color.fromRGBO(0, 0, 0, 0.5),
                                fontSize: 15.0,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            SizedBox(
                              height: 5.0,
                            ),
                            Text(
                              '19hr 20mins',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                    tooltipBehavior: _tooltip,
                    legend: const Legend(
                      isVisible: true,
                      overflowMode: LegendItemOverflowMode.wrap,
                    ),
                    series: <CircularSeries<ChartData, String>>[
                      DoughnutSeries<ChartData, String>(
                        innerRadius: '65%',
                        dataSource: data,
                        strokeWidth: 30.0,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        enableTooltip: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Activity Details',
                        style: TextStyle(
                          fontSize: 17.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Icon(
                        Icons.filter_list_sharp,
                        size: 28.0,
                        color: Colors.grey.shade500,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10.0),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: ActivityTile(),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        shape: const CircleBorder(),
        backgroundColor: Colors.pink.shade300,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        shape: const CircularNotchedRectangle(),
        notchMargin: 9,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.web,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text('Overview')
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.picture_as_pdf,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text('Report')
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.notifications_none_outlined,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text('Notification')
              ],
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.settings_outlined,
                  color: Colors.grey.shade600,
                ),
                const SizedBox(
                  height: 5.0,
                ),
                Text('Settings')
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ChartData {
  ChartData(this.x, this.y);

  final String x;
  final double y;
}
