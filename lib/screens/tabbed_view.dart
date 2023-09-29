import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_riverpod_poc/providers/show_case_provider.dart';
import 'package:go_riverpod_poc/widgets/showcase.dart';
import 'package:showcaseview/showcaseview.dart';

class TabbedViewScreen extends ConsumerStatefulWidget {
  const TabbedViewScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      TabbedViewScreenState();
}

class TabbedViewScreenState extends ConsumerState<TabbedViewScreen>
    with SingleTickerProviderStateMixin {
  final _tabsLength = 3;
  late List<GlobalKey> _stepKeys;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabsLength, vsync: this);
    _stepKeys = List.generate(4, (index) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      ShowCaseWidget.of(context).startShowCase(_stepKeys);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.watch(showCaseContentStepProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        onPressed: () {
          ShowCaseWidget.of(context).startShowCase(_stepKeys);
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          width: MediaQuery.of(context).size.width - 32,
          child: Column(
            children: [
              const SizedBox(height: 100),
              ShowcaseWidget(
                identifier: _stepKeys[0],
                title: 'Category Tabs',
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Cars: ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                        children: [
                          TextSpan(
                            text:
                                'cars are used for all kinds of things such as transportation, recreation, travel, racing, etc.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'Trains: ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                        children: [
                          TextSpan(
                            text:
                                'trains have been around for centuries and used to be the most luxusious way to travel.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        text: 'Bicycles: ',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                        children: [
                          TextSpan(
                            text:
                                'many bicycles have made their way through my house including my favorite one which is the Lynskey Live Wire.',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                child: TabBar(
                  unselectedLabelColor: Colors.grey,
                  labelColor: Colors.black,
                  controller: _tabController,
                  onTap: (index) {
                    setState(() {
                      _tabController.index = index;
                    });
                  },
                  tabs: const [
                    Tab(icon: Icon(Icons.directions_car)),
                    Tab(icon: Icon(Icons.directions_transit)),
                    Tab(icon: Icon(Icons.directions_bike)),
                  ],
                ),
              ),
              Builder(builder: (context) {
                int selectedIndex = _tabController.index;

                switch (selectedIndex) {
                  case 1:
                    return Expanded(
                      child: TransportTab(
                        type: 'Train',
                        length: 1 + Random().nextInt(29),
                        stepKey: _stepKeys[1],
                      ),
                    );
                  case 2:
                    return Expanded(
                      child: TransportTab(
                        type: 'Bicycle',
                        length: 1 + Random().nextInt(29),
                        stepKey: _stepKeys[1],
                      ),
                    );
                  default:
                    return Expanded(
                      child: TransportTab(
                        type: 'Car',
                        length: 1 + Random().nextInt(29),
                        stepKey: _stepKeys[1],
                      ),
                    );
                }
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class TransportTab extends StatelessWidget {
  final String type;
  final int length;
  final GlobalKey stepKey;
  final bool? isLast;
  const TransportTab({
    Key? key,
    required this.type,
    required this.length,
    required this.stepKey,
    this.isLast = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final strings = List<String>.generate(length, (i) => '$type $i');
    return ListView.builder(
      itemCount: strings.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == 0) {
          bool isLast = index == strings.length - 1;

          return ListTile(
            title: ShowcaseWidget(
              identifier: stepKey,
              title: 'Note $index',
              content: const SizedBox.shrink(),
              rightButtonTitle: isLast ? 'Finish' : 'Next',
              child: Text(strings[index]),
            ),
          );
        }

        return ListTile(
          title: Text(strings[index]),
        );
      },
    );
  }
}
